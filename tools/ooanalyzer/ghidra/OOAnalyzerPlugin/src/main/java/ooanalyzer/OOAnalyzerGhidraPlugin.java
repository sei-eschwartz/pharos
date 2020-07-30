/*******************************************************************************
 * Copyright 2015-2020 Carnegie Mellon University.  See LICENSE file for terms.
 ******************************************************************************/

package ooanalyzer;

import java.awt.event.KeyEvent;
import java.io.File;
import java.util.Collection;
import java.util.List;
import java.util.Optional;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import javax.swing.JOptionPane;

import docking.ActionContext;
import docking.action.DockingAction;
import docking.action.KeyBindingData;
import docking.action.MenuData;
import ghidra.app.plugin.PluginCategoryNames;
import ghidra.app.plugin.ProgramPlugin;
import ghidra.app.script.AskDialog;
import ghidra.framework.cmd.BackgroundCommand;
import ghidra.framework.model.DomainObject;
import ghidra.framework.model.Transaction;
import ghidra.framework.model.AbortedTransactionListener;
import ghidra.framework.plugintool.PluginInfo;
import ghidra.framework.plugintool.PluginTool;
import ghidra.framework.plugintool.util.PluginStatus;
import ghidra.program.model.listing.Program;
import ghidra.util.Msg;
import ooanalyzer.jsontypes.OOAnalyzerClassType;
import ooanalyzer.jsontypes.OOAnalyzerJsonRoot;
import ghidra.util.task.TaskMonitor;


// @formatter:off
@PluginInfo(status = PluginStatus.STABLE, packageName = OOAnalyzerGhidraPlugin.NAME, category = PluginCategoryNames.ANALYSIS, shortDescription = "CERT OOAnalyzer JSON results importer.", description = "Import and apply CERT OOAnalyzer results to a Ghidra project.")
// @formatter:on

/**
 * The main OOAnalyzer Plugin
 *
 */
public class OOAnalyzerGhidraPlugin extends ProgramPlugin {

  private class MyListener implements AbortedTransactionListener {
    @Override
    public void transactionAborted(long tid) {
      Msg.warn (this, "Transaction was just aborted!");
    }

    public void finalize() {
      Msg.warn (this, "MyListener was finalized!");
    }
  }

  private static final String CERT_MENU = "&CERT";
  public static final String NAME = "OOAnalyzer";
  private DockingAction ooaAction = null;

  /**
   * Setup the plugin
   */
  public OOAnalyzerGhidraPlugin(PluginTool tool) {
    super(tool, true, true);
    setupActions();
  }

  public void configureAndExecute() {
    configureAndExecute (null, null);
  }

  public ImportCommand configureAndExecute(File json, Boolean useOOAnalyzerNamespace) {
    ImportCommand bgcmd = new ImportCommand(json, useOOAnalyzerNamespace);

    tool.executeBackgroundCommand(bgcmd, currentProgram);

    return bgcmd;
  }


  class ImportCommand extends BackgroundCommand {

    File jsonFile;
    Boolean useOOAnalyzerNamespace;
    Boolean completed = false;
    Boolean testEnv = false;

    ImportCommand() {
      super("OOAnalyzer Import", true, true, false);
    }

    ImportCommand(File jsonFile_, Boolean useOOAnalyzerNamespace_) {
      super("OOAnalyzer Import", true, true, false);
      jsonFile = jsonFile_;
      useOOAnalyzerNamespace = useOOAnalyzerNamespace_;
      testEnv = jsonFile != null && useOOAnalyzerNamespace != null;
    }

    @Override
    public void taskCompleted () {
      Msg.debug (this, "Task completed!");
      completed = true;
    }

    public boolean getCompleted () {
      return completed;
    }

    @Override
    public boolean applyTo(DomainObject obj, TaskMonitor monitor) {
      cmdConfigureAndExecute(monitor);
      return true;
    }


    private void addAbortListener(Program program, AbortedTransactionListener listener) throws Exception {
      //ProgramDB db = (ProgramDB) program;
      Object transaction = program.getCurrentTransaction();
      Field abortListenersField = Class.forName("ghidra.framework.data.DomainObjectDBTransaction").getDeclaredField("abortedTransactionListeners");
      //Field abortListenersField = transaction.getClass().getDeclaredField("abortedTransactionListeners");
      abortListenersField.setAccessible(true);
      Object listeners = abortListenersField.get(transaction);
      //abortListenersField.get(transaction).add(listener);

      // 2020-07-30 10:30:58 WARN  (OOAnalyzerGhidraPlugin$ImportCommand) Exception java.lang.NoSuchMethodException: ghidra.util.datastruct.CopyOnWriteWeakSet.add(ghidra.framework
      Method add = listeners.getClass().getMethod("add", AbortedTransactionListener.class);
      add.invoke (listeners, listener);

      // ABORT!
      transaction.getClass().getMethod("abort").invoke(transaction);

    }


    /**
     * Run the script
     */
    private void cmdConfigureAndExecute(TaskMonitor monitor) {

      MyListener listener = new MyListener ();
      try {
        addAbortListener (OOAnalyzerGhidraPlugin.this.currentProgram, listener);
      } catch (Exception e) {
        Msg.warn (this, "Exception " + e.toString ());
      }

      // Refuse to continue unless program has been analyzed
      if (!currentProgram.getOptions(Program.PROGRAM_INFO).getBoolean(Program.ANALYZED, false)) {
        Msg.showError(this, null, "Error", "Please run auto analysis before using the OOAnalyzer Ghidra Plugin");
        return;
      }

      if (!testEnv) {
        OOAnalyzerDialog ooaDialog = new OOAnalyzerDialog("OOAnalyzer Settings");
        OOAnalyzerGhidraPlugin.this.tool.showDialog(ooaDialog);
        jsonFile = ooaDialog.getJsonFile();
        useOOAnalyzerNamespace = ooaDialog.useOOAnalyzerNamespace ();

        if (ooaDialog.isCancelled()) {
          return;
        } else if (jsonFile == null) {
          Msg.showError(this, null, "Error", "Invalid JSON file");
          return;
        }
      }

      // String baseJsonName = jsonFile.getName().split("\\.(?=[^\\.]+$)")[0];
      // String baseProgName = currentProgram.getName().split("\\.(?=[^\\.]+$)")[0];
      // if (baseJsonName.equalsIgnoreCase(baseProgName) == false) {
      //   if (0 != JOptionPane.showConfirmDialog(null, "JSON file name mismatch",
      //                                          "The selected JSON name does not match the executable, continue?", JOptionPane.YES_NO_OPTION,
      //                                          JOptionPane.WARNING_MESSAGE)) {
      //     Msg.info(null, "OOAnalyzer cancelled");
      //     return;
      //   }
      // }

      Optional<OOAnalyzerJsonRoot> optJson = OOAnalyzer.parseJsonFile(jsonFile);
      if (optJson.isEmpty()) {
        Msg.showError(this, null, "Error", "Could not load/parse JSON file " + jsonFile.getName());
        return;
      }

      String jsonMd5 = optJson.get ().getMd5 ();
      String ghidraMd5 = currentProgram.getExecutableMD5 ();

      if (jsonMd5 != null && !jsonMd5.equalsIgnoreCase (ghidraMd5)) {
        if (0 /* yes */  != JOptionPane.showConfirmDialog(null,
                                                          String.format ("There was a hash mismatch. This JSON may be for a different file '%s'.  Do you want to continue?", optJson.get ().getFilename ()),
                                                          "MD5 mismatch",
                                                          JOptionPane.YES_NO_OPTION,
                                                          JOptionPane.WARNING_MESSAGE)) {
          Msg.info (null, "OOAnalyzer import canceled by user after MD5 mismatch");
          return;
        }
      }

      // Actually run the plugin
      int result = -1;
      int tid = OOAnalyzerGhidraPlugin.this.currentProgram.startTransaction("OOA");
      try {
        OOAnalyzer ooa = new OOAnalyzer (currentProgram,
                                         useOOAnalyzerNamespace);
        ooa.setMonitor (monitor);
        result = ooa.analyzeClasses(optJson.get().getStructures ());
        if (monitor.isCancelled()) {
          // Do nothing
        } else if (result < 0) {
          Msg.showError(this, null, "Error", "No current program for OOAnalyzer");
          if (testEnv)
            throw new IllegalStateException("No current program for OOAnalyzer");
        } else if (result > 0) {
          Msg.showInfo(this, null, "Results", "OOAnalyzer loaded " + result + " classes");
        } else {
          Msg.showInfo(this, null, "Results", "OOAnalyzer could not find any classes");
          if (testEnv)
            throw new IllegalStateException("OOAnalyzer could not find any classes");
        }
      } finally {
        Msg.debug (null, "hasTransactionTerminated: " + OOAnalyzerGhidraPlugin.this.currentProgram.hasTerminatedTransaction ());
        Transaction transaction = OOAnalyzerGhidraPlugin.this.currentProgram.getCurrentTransaction ();

        if (transaction != null) {
          Msg.debug (this, "Transaction description: " + transaction.getDescription ());
          Msg.debug (this, "ID: " + transaction.getID ());
          for (String s : transaction.getOpenSubTransactions ()) {
            Msg.debug (this, "Open sub-transaction: " + s);
          }
          Msg.debug (this, "Status: " + transaction.getStatus ());
          Msg.debug (this, "has Committed: " + transaction.hasCommittedDBTransaction ());
        } else {
          Msg.debug (this, "Current transaction is null");
        }
        OOAnalyzerGhidraPlugin.this.currentProgram.endTransaction(tid, result > 0);
      }
    }
  }

  private void setupActions() {

    ooaAction = new DockingAction("OOAnalyzer", getName()) {

        @Override
        public void actionPerformed(ActionContext context) {
          configureAndExecute();
        }
      };

    final String ooaActionName = OOAnalyzerGhidraPlugin.NAME;
    final String ooaMenu = CERT_MENU;

    ooaAction.setMenuBarData(new MenuData(new String[] { ooaMenu, ooaActionName }, null,
                                          OOAnalyzerGhidraPlugin.NAME, MenuData.NO_MNEMONIC, null));

    ooaAction.setKeyBindingData(new KeyBindingData(KeyEvent.VK_F12, 0));
    ooaAction.setEnabled(false);
    ooaAction.markHelpUnnecessary();

    tool.addAction(ooaAction);
  }

  /**
   * Called when program activated
   */
  @Override
  protected void programActivated(Program activatedProgram) {
    ooaAction.setEnabled(true);
  }

}
