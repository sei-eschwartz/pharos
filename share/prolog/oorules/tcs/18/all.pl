:- working_directory(_, '/home/ed/Documents/pharos/share/prolog/oorules').
:- [setup].
% Declare new vftable facts in case we don't export any.
:- dynamic factVFTableWrite/3.
:- dynamic factVBTableWrite/3.
:- dynamic possibleVFTableWriteHelper/5.
:- dynamic possibleVBTableWriteHelper/5.
:- dynamic thisPtrOffset/4.
:- dynamic groundVFTableBelongsToClass/2.
:- dynamic groundConstructor/1.
:- dynamic groundDestructor/1.
:- dynamic noCallsBefore/1.
:- dynamic noCallsAfter/1.
:- dynamic returnsSelf/1.
:- dynamic factDerivedClass/4.
:- dynamic ignorefactNOTMergeClasses/2.
noCallsBefore(function(8)).
noCallsBefore(function(9)).
noCallsBefore(function(10)).
noCallsBefore(function(1)).
noCallsBefore(function(2)).
noCallsBefore(function(3)).
noCallsBefore(function(11)).
noCallsBefore(function(12)).
noCallsBefore(function(4)).
noCallsBefore(function(5)).
noCallsBefore(function(6)).
noCallsBefore(function(7)).
noCallsBefore(function(0)).
noCallsBefore(function(13)).
noCallsAfter(function(8)).
noCallsAfter(function(9)).
noCallsAfter(function(10)).
noCallsAfter(function(1)).
noCallsAfter(function(2)).
noCallsAfter(function(3)).
noCallsAfter(function(11)).
noCallsAfter(function(12)).
noCallsAfter(function(4)).
noCallsAfter(function(5)).
noCallsAfter(function(6)).
noCallsAfter(function(7)).
noCallsAfter(function(0)).
noCallsAfter(function(13)).
returnsSelf(function(8)).
returnsSelf(function(9)).
returnsSelf(function(10)).
returnsSelf(function(1)).
returnsSelf(function(2)).
returnsSelf(function(3)).
returnsSelf(function(11)).
returnsSelf(function(12)).
returnsSelf(function(4)).
returnsSelf(function(5)).
returnsSelf(function(6)).
returnsSelf(function(7)).
returnsSelf(function(0)).
returnsSelf(function(13)).
factClassCallsMethod(class(0), function(0)).
factClassCallsMethod(class(0), function(1)).
factClassCallsMethod(class(0), function(2)).
factClassCallsMethod(class(0), function(3)).
factClassCallsMethod(class(0), function(11)).
factClassCallsMethod(class(0), function(0)).
factClassCallsMethod(class(0), function(1)).
factClassCallsMethod(class(0), function(2)).
factClassCallsMethod(class(0), function(3)).
factClassCallsMethod(class(0), function(11)).
factClassCallsMethod(class(0), function(0)).
factClassCallsMethod(class(0), function(1)).
factClassCallsMethod(class(0), function(2)).
factClassCallsMethod(class(0), function(3)).
factClassCallsMethod(class(0), function(11)).
factClassCallsMethod(class(0), function(0)).
factClassCallsMethod(class(0), function(1)).
factClassCallsMethod(class(0), function(2)).
factClassCallsMethod(class(0), function(3)).
factClassCallsMethod(class(0), function(11)).
factClassCallsMethod(class(0), function(0)).
factClassCallsMethod(class(0), function(1)).
factClassCallsMethod(class(0), function(2)).
factClassCallsMethod(class(0), function(3)).
factClassCallsMethod(class(0), function(11)).
factClassCallsMethod(class(1), function(4)).
factClassCallsMethod(class(1), function(5)).
factClassCallsMethod(class(1), function(6)).
factClassCallsMethod(class(1), function(7)).
factClassCallsMethod(class(1), function(12)).
factClassCallsMethod(class(1), function(4)).
factClassCallsMethod(class(1), function(5)).
factClassCallsMethod(class(1), function(6)).
factClassCallsMethod(class(1), function(7)).
factClassCallsMethod(class(1), function(12)).
factClassCallsMethod(class(1), function(4)).
factClassCallsMethod(class(1), function(5)).
factClassCallsMethod(class(1), function(6)).
factClassCallsMethod(class(1), function(7)).
factClassCallsMethod(class(1), function(12)).
factClassCallsMethod(class(1), function(4)).
factClassCallsMethod(class(1), function(5)).
factClassCallsMethod(class(1), function(6)).
factClassCallsMethod(class(1), function(7)).
factClassCallsMethod(class(1), function(12)).
factClassCallsMethod(class(1), function(4)).
factClassCallsMethod(class(1), function(5)).
factClassCallsMethod(class(1), function(6)).
factClassCallsMethod(class(1), function(7)).
factClassCallsMethod(class(1), function(12)).
factClassCallsMethod(class(2), function(0)).
factClassCallsMethod(class(2), function(1)).
factClassCallsMethod(class(2), function(2)).
factClassCallsMethod(class(2), function(3)).
factClassCallsMethod(class(2), function(11)).
factClassCallsMethod(class(2), function(0)).
factClassCallsMethod(class(2), function(1)).
factClassCallsMethod(class(2), function(2)).
factClassCallsMethod(class(2), function(3)).
factClassCallsMethod(class(2), function(11)).
factClassCallsMethod(class(2), function(0)).
factClassCallsMethod(class(2), function(1)).
factClassCallsMethod(class(2), function(2)).
factClassCallsMethod(class(2), function(3)).
factClassCallsMethod(class(2), function(11)).
factClassCallsMethod(class(2), function(0)).
factClassCallsMethod(class(2), function(1)).
factClassCallsMethod(class(2), function(2)).
factClassCallsMethod(class(2), function(3)).
factClassCallsMethod(class(2), function(11)).
factClassCallsMethod(class(2), function(8)).
factClassCallsMethod(class(2), function(0)).
factClassCallsMethod(class(2), function(1)).
factClassCallsMethod(class(2), function(2)).
factClassCallsMethod(class(2), function(3)).
factClassCallsMethod(class(2), function(11)).
factClassCallsMethod(class(3), function(0)).
factClassCallsMethod(class(3), function(1)).
factClassCallsMethod(class(3), function(2)).
factClassCallsMethod(class(3), function(3)).
factClassCallsMethod(class(3), function(11)).
factClassCallsMethod(class(3), function(0)).
factClassCallsMethod(class(3), function(1)).
factClassCallsMethod(class(3), function(2)).
factClassCallsMethod(class(3), function(3)).
factClassCallsMethod(class(3), function(11)).
factClassCallsMethod(class(3), function(0)).
factClassCallsMethod(class(3), function(1)).
factClassCallsMethod(class(3), function(2)).
factClassCallsMethod(class(3), function(3)).
factClassCallsMethod(class(3), function(11)).
factClassCallsMethod(class(3), function(0)).
factClassCallsMethod(class(3), function(1)).
factClassCallsMethod(class(3), function(2)).
factClassCallsMethod(class(3), function(3)).
factClassCallsMethod(class(3), function(11)).
factClassCallsMethod(class(3), function(4)).
factClassCallsMethod(class(3), function(5)).
factClassCallsMethod(class(3), function(6)).
factClassCallsMethod(class(3), function(7)).
factClassCallsMethod(class(3), function(12)).
factClassCallsMethod(class(3), function(4)).
factClassCallsMethod(class(3), function(5)).
factClassCallsMethod(class(3), function(6)).
factClassCallsMethod(class(3), function(7)).
factClassCallsMethod(class(3), function(12)).
factClassCallsMethod(class(3), function(4)).
factClassCallsMethod(class(3), function(5)).
factClassCallsMethod(class(3), function(6)).
factClassCallsMethod(class(3), function(7)).
factClassCallsMethod(class(3), function(12)).
factClassCallsMethod(class(3), function(4)).
factClassCallsMethod(class(3), function(5)).
factClassCallsMethod(class(3), function(6)).
factClassCallsMethod(class(3), function(7)).
factClassCallsMethod(class(3), function(12)).
factClassCallsMethod(class(3), function(9)).
factClassCallsMethod(class(3), function(10)).
factClassCallsMethod(class(3), function(13)).
factClassCallsMethod(class(3), function(9)).
factClassCallsMethod(class(3), function(10)).
factClassCallsMethod(class(3), function(13)).
factClassCallsMethod(class(3), function(0)).
factClassCallsMethod(class(3), function(1)).
factClassCallsMethod(class(3), function(2)).
factClassCallsMethod(class(3), function(3)).
factClassCallsMethod(class(3), function(11)).
factClassCallsMethod(class(3), function(4)).
factClassCallsMethod(class(3), function(5)).
factClassCallsMethod(class(3), function(6)).
factClassCallsMethod(class(3), function(7)).
factClassCallsMethod(class(3), function(12)).
factClassCallsMethod(class(3), function(9)).
factClassCallsMethod(class(3), function(10)).
factClassCallsMethod(class(3), function(13)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(0), function(0)).
factClassRelatedMethod(class(0), function(1)).
factClassRelatedMethod(class(0), function(2)).
factClassRelatedMethod(class(0), function(3)).
factClassRelatedMethod(class(0), function(11)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(1), function(4)).
factClassRelatedMethod(class(1), function(5)).
factClassRelatedMethod(class(1), function(6)).
factClassRelatedMethod(class(1), function(7)).
factClassRelatedMethod(class(1), function(12)).
factClassRelatedMethod(class(2), function(0)).
factClassRelatedMethod(class(2), function(1)).
factClassRelatedMethod(class(2), function(2)).
factClassRelatedMethod(class(2), function(3)).
factClassRelatedMethod(class(2), function(11)).
factClassRelatedMethod(class(0), function(8)).
factClassRelatedMethod(class(2), function(0)).
factClassRelatedMethod(class(2), function(1)).
factClassRelatedMethod(class(2), function(2)).
factClassRelatedMethod(class(2), function(3)).
factClassRelatedMethod(class(2), function(11)).
factClassRelatedMethod(class(0), function(8)).
factClassRelatedMethod(class(2), function(0)).
factClassRelatedMethod(class(2), function(1)).
factClassRelatedMethod(class(2), function(2)).
factClassRelatedMethod(class(2), function(3)).
factClassRelatedMethod(class(2), function(11)).
factClassRelatedMethod(class(0), function(8)).
factClassRelatedMethod(class(2), function(0)).
factClassRelatedMethod(class(2), function(1)).
factClassRelatedMethod(class(2), function(2)).
factClassRelatedMethod(class(2), function(3)).
factClassRelatedMethod(class(2), function(11)).
factClassRelatedMethod(class(0), function(8)).
factClassRelatedMethod(class(2), function(8)).
factClassRelatedMethod(class(2), function(8)).
factClassRelatedMethod(class(2), function(0)).
factClassRelatedMethod(class(2), function(1)).
factClassRelatedMethod(class(2), function(2)).
factClassRelatedMethod(class(2), function(3)).
factClassRelatedMethod(class(2), function(11)).
factClassRelatedMethod(class(0), function(8)).
factClassRelatedMethod(class(3), function(0)).
factClassRelatedMethod(class(3), function(1)).
factClassRelatedMethod(class(3), function(2)).
factClassRelatedMethod(class(3), function(3)).
factClassRelatedMethod(class(3), function(11)).
factClassRelatedMethod(class(0), function(9)).
factClassRelatedMethod(class(0), function(10)).
factClassRelatedMethod(class(0), function(13)).
factClassRelatedMethod(class(3), function(0)).
factClassRelatedMethod(class(3), function(1)).
factClassRelatedMethod(class(3), function(2)).
factClassRelatedMethod(class(3), function(3)).
factClassRelatedMethod(class(3), function(11)).
factClassRelatedMethod(class(0), function(9)).
factClassRelatedMethod(class(0), function(10)).
factClassRelatedMethod(class(0), function(13)).
factClassRelatedMethod(class(3), function(0)).
factClassRelatedMethod(class(3), function(1)).
factClassRelatedMethod(class(3), function(2)).
factClassRelatedMethod(class(3), function(3)).
factClassRelatedMethod(class(3), function(11)).
factClassRelatedMethod(class(0), function(9)).
factClassRelatedMethod(class(0), function(10)).
factClassRelatedMethod(class(0), function(13)).
factClassRelatedMethod(class(3), function(0)).
factClassRelatedMethod(class(3), function(1)).
factClassRelatedMethod(class(3), function(2)).
factClassRelatedMethod(class(3), function(3)).
factClassRelatedMethod(class(3), function(11)).
factClassRelatedMethod(class(0), function(9)).
factClassRelatedMethod(class(0), function(10)).
factClassRelatedMethod(class(0), function(13)).
factClassRelatedMethod(class(3), function(4)).
factClassRelatedMethod(class(3), function(5)).
factClassRelatedMethod(class(3), function(6)).
factClassRelatedMethod(class(3), function(7)).
factClassRelatedMethod(class(3), function(12)).
factClassRelatedMethod(class(1), function(9)).
factClassRelatedMethod(class(1), function(10)).
factClassRelatedMethod(class(1), function(13)).
factClassRelatedMethod(class(3), function(4)).
factClassRelatedMethod(class(3), function(5)).
factClassRelatedMethod(class(3), function(6)).
factClassRelatedMethod(class(3), function(7)).
factClassRelatedMethod(class(3), function(12)).
factClassRelatedMethod(class(1), function(9)).
factClassRelatedMethod(class(1), function(10)).
factClassRelatedMethod(class(1), function(13)).
factClassRelatedMethod(class(3), function(4)).
factClassRelatedMethod(class(3), function(5)).
factClassRelatedMethod(class(3), function(6)).
factClassRelatedMethod(class(3), function(7)).
factClassRelatedMethod(class(3), function(12)).
factClassRelatedMethod(class(1), function(9)).
factClassRelatedMethod(class(1), function(10)).
factClassRelatedMethod(class(1), function(13)).
factClassRelatedMethod(class(3), function(4)).
factClassRelatedMethod(class(3), function(5)).
factClassRelatedMethod(class(3), function(6)).
factClassRelatedMethod(class(3), function(7)).
factClassRelatedMethod(class(3), function(12)).
factClassRelatedMethod(class(1), function(9)).
factClassRelatedMethod(class(1), function(10)).
factClassRelatedMethod(class(1), function(13)).
factClassRelatedMethod(class(3), function(9)).
factClassRelatedMethod(class(3), function(10)).
factClassRelatedMethod(class(3), function(13)).
factClassRelatedMethod(class(3), function(9)).
factClassRelatedMethod(class(3), function(10)).
factClassRelatedMethod(class(3), function(13)).
factClassRelatedMethod(class(3), function(9)).
factClassRelatedMethod(class(3), function(10)).
factClassRelatedMethod(class(3), function(13)).
factClassRelatedMethod(class(3), function(9)).
factClassRelatedMethod(class(3), function(10)).
factClassRelatedMethod(class(3), function(13)).
factClassRelatedMethod(class(3), function(0)).
factClassRelatedMethod(class(3), function(1)).
factClassRelatedMethod(class(3), function(2)).
factClassRelatedMethod(class(3), function(3)).
factClassRelatedMethod(class(3), function(11)).
factClassRelatedMethod(class(0), function(9)).
factClassRelatedMethod(class(0), function(10)).
factClassRelatedMethod(class(0), function(13)).
factClassRelatedMethod(class(3), function(4)).
factClassRelatedMethod(class(3), function(5)).
factClassRelatedMethod(class(3), function(6)).
factClassRelatedMethod(class(3), function(7)).
factClassRelatedMethod(class(3), function(12)).
factClassRelatedMethod(class(1), function(9)).
factClassRelatedMethod(class(1), function(10)).
factClassRelatedMethod(class(1), function(13)).
factClassRelatedMethod(class(3), function(9)).
factClassRelatedMethod(class(3), function(10)).
factClassRelatedMethod(class(3), function(13)).
factClassRelatedMethod(class(3), function(9)).
factClassRelatedMethod(class(3), function(10)).
factClassRelatedMethod(class(3), function(13)).
% vftable(0) for path [ 0 ]
factVFTable(vftable(0)).
factVFTableSizeGTE(vftable(0), 0x4).
factVFTableSizeLTE(vftable(0), 0x4).
factVFTableEntry(vftable(0), 0, function(3)).
possibleVFTableEntry(vftable(0), 0, function(3)).
factMethodInVFTable(vftable(0), 0, function(3)).
% vftable(2) for path [ 0, 2 ]
factVFTable(vftable(2)).
factVFTableSizeGTE(vftable(2), 0x4).
factVFTableSizeLTE(vftable(2), 0x4).
factVFTableEntry(vftable(2), 0, function(3)).
possibleVFTableEntry(vftable(2), 0, function(3)).
factMethodInVFTable(vftable(2), 0, function(3)).
% vftable(3) for path [ 0, 3 ]
factVFTable(vftable(3)).
factVFTableSizeGTE(vftable(3), 0x4).
factVFTableSizeLTE(vftable(3), 0x4).
factVFTableEntry(vftable(3), 0, function(9)).
possibleVFTableEntry(vftable(3), 0, function(9)).
factMethodInVFTable(vftable(3), 0, function(9)).
% vftable(1) for path [ 1 ]
factVFTable(vftable(1)).
factVFTableSizeGTE(vftable(1), 0x4).
factVFTableSizeLTE(vftable(1), 0x4).
factVFTableEntry(vftable(1), 0, function(5)).
possibleVFTableEntry(vftable(1), 0, function(5)).
factMethodInVFTable(vftable(1), 0, function(5)).
% vftable(4) for path [ 1, 3 ]
factVFTable(vftable(4)).
factVFTableSizeGTE(vftable(4), 0x4).
factVFTableSizeLTE(vftable(4), 0x4).
factVFTableEntry(vftable(4), 0, function(5)).
possibleVFTableEntry(vftable(4), 0, function(5)).
factMethodInVFTable(vftable(4), 0, function(5)).
factVFTableWrite(0x10005, function(0), vftable(0)).
% thisptr: GetArg{func0, [], 32, 0}
possibleVFTableWriteHelper(0x10005, function(0), thisptr(0), 0, vftable(0)).
factVFTableWrite(0x13005, function(3), vftable(0)).
% thisptr: GetArg{func3, [], 32, 0}
possibleVFTableWriteHelper(0x13005, function(3), thisptr(1), 0, vftable(0)).
factVFTableWrite(0x16005, function(6), vftable(1)).
% thisptr: GetArg{func6, [], 32, 0}
possibleVFTableWriteHelper(0x16005, function(6), thisptr(2), 0, vftable(1)).
factVFTableWrite(0x1601f, function(6), vftable(0)).
% thisptr: ThisPtrConstOffset{func6, [nullptr, nullptr], 32, $23, 4}
possibleVFTableWriteHelper(0x1601f, function(6), thisptr(3), 1, vftable(0)).
factVFTableWrite(0x17005, function(7), vftable(1)).
% thisptr: GetArg{func7, [], 32, 0}
possibleVFTableWriteHelper(0x17005, function(7), thisptr(4), 0, vftable(1)).
factVFTableWrite(0x18008, function(8), vftable(2)).
% thisptr: GetArg{func8, [], 32, 0}
possibleVFTableWriteHelper(0x18008, function(8), thisptr(5), 0, vftable(2)).
factVFTableWrite(0x19008, function(9), vftable(3)).
% thisptr: ThisPtrConstOffset{func9, [], 32, $4, 20}
possibleVFTableWriteHelper(0x19008, function(9), thisptr(6), 0, vftable(3)).
factVFTableWrite(0x1900f, function(9), vftable(4)).
% thisptr: ThisPtrConstOffset{func9, [], 32, $10, -20}
possibleVFTableWriteHelper(0x1900f, function(9), thisptr(7), 0, vftable(4)).
factVFTableWrite(0x1901f, function(9), vftable(0)).
% thisptr: ThisPtrConstOffset{func9, [nullptr, nullptr], 32, $23, 20}
possibleVFTableWriteHelper(0x1901f, function(9), thisptr(8), 1, vftable(0)).
factVFTableWrite(0x1902f, function(9), vftable(1)).
% thisptr: ThisPtrConstOffset{func9, [nullptr, nullptr, nullptr, nullptr, nullptr, nullptr], 32, $38, -20}
possibleVFTableWriteHelper(0x1902f, function(9), thisptr(9), 1, vftable(1)).
factVFTableWrite(0x19049, function(9), vftable(0)).
% thisptr: ThisPtrConstOffset{func9, [nullptr, nullptr, nullptr], 32, $40, 4}
possibleVFTableWriteHelper(0x19049, function(9), thisptr(10), 1, vftable(0)).
factVFTableWrite(0x1a00d, function(10), vftable(3)).
% thisptr: ThisPtrConstOffset{func10, [], 32, $9, 20}
possibleVFTableWriteHelper(0x1a00d, function(10), thisptr(11), 0, vftable(3)).
factVFTableWrite(0x1a012, function(10), vftable(4)).
% thisptr: GetArg{func10, [], 32, 0}
possibleVFTableWriteHelper(0x1a012, function(10), thisptr(12), 0, vftable(4)).
factVFTableWrite(0x1d00f, function(13), vftable(3)).
% thisptr: ThisPtrConstOffset{func13, [nullptr], 32, $13, 20}
possibleVFTableWriteHelper(0x1d00f, function(13), thisptr(13), 1, vftable(3)).
factVFTableWrite(0x1d016, function(13), vftable(4)).
% thisptr: ThisPtrConstOffset{func13, [nullptr], 32, $5, -20}
possibleVFTableWriteHelper(0x1d016, function(13), thisptr(14), 1, vftable(4)).
factVFTableWrite(0x1d026, function(13), vftable(0)).
% thisptr: ThisPtrConstOffset{func13, [nullptr, nullptr, nullptr], 32, $30, 20}
possibleVFTableWriteHelper(0x1d026, function(13), thisptr(15), 1, vftable(0)).
factVFTableWrite(0x1d036, function(13), vftable(1)).
% thisptr: ThisPtrConstOffset{func13, [nullptr, nullptr, nullptr, nullptr, nullptr, nullptr, nullptr], 32, $5, -20}
possibleVFTableWriteHelper(0x1d036, function(13), thisptr(16), 1, vftable(1)).
factVFTableWrite(0x1d050, function(13), vftable(0)).
% thisptr: ThisPtrConstOffset{func13, [nullptr, nullptr, nullptr, nullptr], 32, $72, 4}
possibleVFTableWriteHelper(0x1d050, function(13), thisptr(17), 1, vftable(0)).
factDerivedClass(class(2), class(0), 0, false).
factDerivedClass(class(2), class(0), 0).
factNOTEmbeddedObject(class(2), class(0), 0).
factObjectInObject(class(2), class(0), 0).
factDerivedClass(class(3), class(1), 0, false).
factDerivedClass(class(3), class(1), 0).
factNOTEmbeddedObject(class(3), class(1), 0).
factObjectInObject(class(3), class(1), 0).
factDerivedClass(class(3), class(0), 0x14, false).
factDerivedClass(class(3), class(0), 0x14).
factNOTEmbeddedObject(class(3), class(0), 0x14).
factObjectInObject(class(3), class(0), 0x14).
factEmbeddedObject(class(1), class(0), 0x4).
factNOTDerivedClass(class(1), class(0), 0x4).
factObjectInObject(class(1), class(0), 0x4).
factEmbeddedObject(class(1), class(0), 0x8).
factNOTDerivedClass(class(1), class(0), 0x8).
factObjectInObject(class(1), class(0), 0x8).
factEmbeddedObject(class(1), class(0), 0xc).
factNOTDerivedClass(class(1), class(0), 0xc).
factObjectInObject(class(1), class(0), 0xc).
factEmbeddedObject(class(1), class(0), 0x10).
factNOTDerivedClass(class(1), class(0), 0x10).
factObjectInObject(class(1), class(0), 0x10).
factClassHasNoBase(class(0)).
factClassHasNoBase(class(1)).
factClassSizeGTE(class(0), 0x4).
factClassSizeLTE(class(0), 0x4).
factClassSizeGTE(class(1), 0x14).
factClassSizeLTE(class(1), 0x14).
factClassSizeGTE(class(2), 0x4).
factClassSizeLTE(class(2), 0x4).
factClassSizeGTE(class(3), 0x18).
factClassSizeLTE(class(3), 0x18).
findint(function(0), class(0)).
factMethod(function(0)).
factConstructor(function(0)).
factNOTRealDestructor(function(0)).
factNOTDeletingDestructor(function(0)).
findint(function(1), class(0)).
factMethod(function(1)).
factNOTConstructor(function(1)).
factNOTRealDestructor(function(1)).
factNOTDeletingDestructor(function(1)).
findint(function(2), class(0)).
factMethod(function(2)).
factNOTConstructor(function(2)).
factNOTRealDestructor(function(2)).
factNOTDeletingDestructor(function(2)).
findint(function(3), class(0)).
factMethod(function(3)).
factRealDestructor(function(3)).
factNOTConstructor(function(3)).
factNOTDeletingDestructor(function(3)).
findint(function(4), class(1)).
factMethod(function(4)).
factNOTConstructor(function(4)).
factNOTRealDestructor(function(4)).
factNOTDeletingDestructor(function(4)).
findint(function(5), class(1)).
factMethod(function(5)).
factNOTConstructor(function(5)).
factNOTRealDestructor(function(5)).
factNOTDeletingDestructor(function(5)).
findint(function(6), class(1)).
factMethod(function(6)).
factRealDestructor(function(6)).
factNOTConstructor(function(6)).
factNOTDeletingDestructor(function(6)).
findint(function(7), class(1)).
factMethod(function(7)).
factConstructor(function(7)).
factNOTRealDestructor(function(7)).
factNOTDeletingDestructor(function(7)).
findint(function(8), class(2)).
factMethod(function(8)).
factConstructor(function(8)).
factNOTRealDestructor(function(8)).
factNOTDeletingDestructor(function(8)).
findint(function(9), class(3)).
factMethod(function(9)).
factRealDestructor(function(9)).
factNOTConstructor(function(9)).
factNOTDeletingDestructor(function(9)).
findint(function(10), class(3)).
factMethod(function(10)).
factConstructor(function(10)).
factNOTRealDestructor(function(10)).
factNOTDeletingDestructor(function(10)).
findint(function(11), class(0)).
factMethod(function(11)).
factDeletingDestructor(function(11)).
factNOTRealDestructor(function(11)).
factNOTConstructor(function(11)).
findint(function(12), class(1)).
factMethod(function(12)).
factDeletingDestructor(function(12)).
factNOTRealDestructor(function(12)).
factNOTConstructor(function(12)).
findint(function(13), class(3)).
factMethod(function(13)).
factDeletingDestructor(function(13)).
factNOTRealDestructor(function(13)).
factNOTConstructor(function(13)).
% thisptr: GetArg{func0, [], 32, 0}
funcParameter(function(0), ecx, thisptr(0)).
% thisptr: GetArg{func1, [], 32, 0}
funcParameter(function(1), ecx, thisptr(18)).
% thisptr: GetArg{func2, [], 32, 0}
funcParameter(function(2), ecx, thisptr(19)).
% thisptr: GetArg{func3, [], 32, 0}
funcParameter(function(3), ecx, thisptr(1)).
% thisptr: GetArg{func4, [], 32, 0}
funcParameter(function(4), ecx, thisptr(20)).
% thisptr: GetArg{func5, [], 32, 0}
funcParameter(function(5), ecx, thisptr(21)).
% thisptr: GetArg{func5, [], 32, 1}
funcParameter(function(5), 1, thisptr(22)).
% thisptr: GetArg{func6, [], 32, 0}
funcParameter(function(6), ecx, thisptr(2)).
% thisptr: GetArg{func7, [], 32, 0}
funcParameter(function(7), ecx, thisptr(4)).
% thisptr: GetArg{func8, [], 32, 0}
funcParameter(function(8), ecx, thisptr(5)).
% thisptr: GetArg{func9, [], 32, 0}
funcParameter(function(9), ecx, thisptr(23)).
% thisptr: GetArg{func10, [], 32, 0}
funcParameter(function(10), ecx, thisptr(12)).
% thisptr: GetArg{func11, [], 32, 0}
funcParameter(function(11), ecx, thisptr(24)).
% thisptr: GetArg{func12, [], 32, 0}
funcParameter(function(12), ecx, thisptr(25)).
% thisptr: GetArg{func13, [], 32, 0}
funcParameter(function(13), ecx, thisptr(26)).
% thisptr: ThisPtrConstOffset{func6, [], 32, $11, 16}
callParameter(0x1600d, function(6), ecx, thisptr(27)).
% thisptr: ThisPtrConstOffset{func6, [], 32, $15, 12}
callParameter(0x16011, function(6), ecx, thisptr(28)).
% thisptr: ThisPtrConstOffset{func6, [], 32, $19, 8}
callParameter(0x16015, function(6), ecx, thisptr(29)).
% thisptr: ThisPtrConstOffset{func7, [], 32, $7, 4}
callParameter(0x17009, function(7), ecx, thisptr(30)).
% thisptr: ThisPtrConstOffset{func7, [], 32, $11, 8}
callParameter(0x1700d, function(7), ecx, thisptr(31)).
% thisptr: ThisPtrConstOffset{func7, [], 32, $15, 12}
callParameter(0x17011, function(7), ecx, thisptr(32)).
% thisptr: ThisPtrConstOffset{func7, [], 32, $19, 16}
callParameter(0x17015, function(7), ecx, thisptr(33)).
% thisptr: GetArg{func8, [], 32, 0}
callParameter(0x18003, function(8), ecx, thisptr(5)).
% thisptr: ThisPtrConstOffset{func9, [nullptr], 32, $40, 16}
callParameter(0x19037, function(9), ecx, thisptr(34)).
% thisptr: ThisPtrConstOffset{func9, [nullptr], 32, $40, 12}
callParameter(0x1903b, function(9), ecx, thisptr(35)).
% thisptr: ThisPtrConstOffset{func9, [nullptr], 32, $40, 8}
callParameter(0x1903f, function(9), ecx, thisptr(36)).
% thisptr: GetArg{func10, [], 32, 0}
callParameter(0x1a003, function(10), ecx, thisptr(12)).
% thisptr: ThisPtrConstOffset{func10, [], 32, $5, 20}
callParameter(0x1a007, function(10), ecx, thisptr(11)).
% thisptr: GetArg{func11, [], 32, 0}
callParameter(0x1b002, function(11), ecx, thisptr(24)).
% thisptr: GetArg{func12, [], 32, 0}
callParameter(0x1c002, function(12), ecx, thisptr(25)).
% thisptr: ThisPtrConstOffset{func13, [nullptr, nullptr], 32, $60, 16}
callParameter(0x1d03e, function(13), ecx, thisptr(37)).
% thisptr: ThisPtrConstOffset{func13, [nullptr, nullptr], 32, $64, 12}
callParameter(0x1d042, function(13), ecx, thisptr(38)).
% thisptr: ThisPtrConstOffset{func13, [nullptr, nullptr], 32, $68, 8}
callParameter(0x1d046, function(13), ecx, thisptr(39)).
callTarget(0x1600d, function(6), function(3)).
callTarget(0x16011, function(6), function(3)).
callTarget(0x16015, function(6), function(3)).
callTarget(0x17009, function(7), function(0)).
callTarget(0x1700d, function(7), function(0)).
callTarget(0x17011, function(7), function(0)).
callTarget(0x17015, function(7), function(0)).
callTarget(0x18003, function(8), function(0)).
callTarget(0x19037, function(9), function(3)).
callTarget(0x1903b, function(9), function(3)).
callTarget(0x1903f, function(9), function(3)).
callTarget(0x1a003, function(10), function(7)).
callTarget(0x1a007, function(10), function(0)).
callTarget(0x1b002, function(11), function(3)).
callTarget(0x1c002, function(12), function(6)).
callTarget(0x1d03e, function(13), function(3)).
callTarget(0x1d042, function(13), function(3)).
callTarget(0x1d046, function(13), function(3)).
thisPtrOffset(function(6), thisptr(2), 0x10, thisptr(27)).
thisPtrOffset(function(6), thisptr(2), 0xc, thisptr(28)).
thisPtrOffset(function(6), thisptr(2), 0x8, thisptr(29)).
thisPtrOffset(function(6), thisptr(2), 0x4, thisptr(3)).
thisPtrOffset(function(6), thisptr(2), 0x4, thisptr(3)).
thisPtrOffset(function(6), thisptr(2), 0x4, thisptr(3)).
thisPtrOffset(function(7), thisptr(4), 0x4, thisptr(30)).
thisPtrOffset(function(7), thisptr(4), 0x8, thisptr(31)).
thisPtrOffset(function(7), thisptr(4), 0xc, thisptr(32)).
thisPtrOffset(function(7), thisptr(4), 0x10, thisptr(33)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(7)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(7)).
thisPtrOffset(function(9), thisptr(7), 0x14, thisptr(6)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(7)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(7)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(7)).
thisPtrOffset(function(9), thisptr(7), 0x14, thisptr(8)).
thisPtrOffset(function(9), thisptr(7), 0x14, thisptr(8)).
thisPtrOffset(function(9), thisptr(7), 0x14, thisptr(8)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(9), 0x10, thisptr(34)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(9), 0xc, thisptr(35)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(9), 0x8, thisptr(36)).
thisPtrOffset(function(9), thisptr(23), -0x14, thisptr(9)).
thisPtrOffset(function(9), thisptr(9), 0x4, thisptr(10)).
thisPtrOffset(function(9), thisptr(9), 0x4, thisptr(10)).
thisPtrOffset(function(9), thisptr(9), 0x4, thisptr(10)).
thisPtrOffset(function(10), thisptr(12), 0x14, thisptr(11)).
thisPtrOffset(function(10), thisptr(12), 0x14, thisptr(11)).
thisPtrOffset(function(13), thisptr(26), -0x14, thisptr(40)).
thisPtrOffset(function(13), thisptr(40), 0x14, thisptr(41)).
thisPtrOffset(function(13), thisptr(40), 0x14, thisptr(41)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(14)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(14)).
thisPtrOffset(function(13), thisptr(14), 0x14, thisptr(13)).
thisPtrOffset(function(13), thisptr(40), 0x14, thisptr(41)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(14)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(14)).
thisPtrOffset(function(13), thisptr(40), 0x14, thisptr(41)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(14)).
thisPtrOffset(function(13), thisptr(14), 0x14, thisptr(15)).
thisPtrOffset(function(13), thisptr(14), 0x14, thisptr(15)).
thisPtrOffset(function(13), thisptr(14), 0x14, thisptr(15)).
thisPtrOffset(function(13), thisptr(40), 0x14, thisptr(41)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(16), 0x10, thisptr(37)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(16), 0xc, thisptr(38)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(16), 0x8, thisptr(39)).
thisPtrOffset(function(13), thisptr(41), -0x14, thisptr(16)).
thisPtrOffset(function(13), thisptr(16), 0x4, thisptr(17)).
thisPtrOffset(function(13), thisptr(16), 0x4, thisptr(17)).
thisPtrOffset(function(13), thisptr(16), 0x4, thisptr(17)).
thisPtrOffset(function(13), thisptr(26), -0x14, thisptr(40)).
insnCallsDelete(0x1b004, function(11), thisptr(24)).
insnCallsDelete(0x1c004, function(12), thisptr(25)).
insnCallsDelete(0x1d05b, function(13), thisptr(40)).
% Adapt to rules that assume thisptr is in ecx
% Assume thiscall
callingConvention(M, '__thiscall').
% Given a thisptr, try to do constant propagation as far back as we can to the oldest thisptr.
:- table goBack/4 as opaque.
goBack(F, Tnew, Tnew, 0) :- not(thisPtrOffset(F, _, _, Tnew)), !.
goBack(F, Tnew, Told, Offset) :- thisPtrOffset(F, Tmid, MidOffset, Tnew), goBack(F, Tmid, Told, OldOffset), Offset is MidOffset + OldOffset.
% Adapt to possibleVFTableWrite with offsets
possibleVFTableWrite(A, F, Told, O, Cond, V) :- possibleVFTableWriteHelper(A, F, T, Cond, V), goBack(F, T, Told, O), funcParameter(F, ecx, Told).
% Auto ignore the condition.
possibleVFTableWrite(A, F, T, O, V) :- possibleVFTableWrite(A, F, T, O, _Cond, V).
% Adapt thisPtrOffset
thisPtrOffset(A,B,C) :- thisPtrOffset(_F,A,B,C).
% Adapt to factVFTableWrite with offsets
factVFTableWrite(A, F, O, V) :- factVFTableWrite(A, F, V), possibleVFTableWrite(A, F, _, O, V).
% Adapt to possibleVBTableWrite with offsets
possibleVBTableWrite(A, F, Told, O, Cond, V) :- possibleVBTableWriteHelper(A, F, T, Cond, V), goBack(F, T, Told, O), funcParameter(F, ecx, Told).
% Auto ignore the condition.
possibleVBTableWrite(A, F, T, O, V) :- possibleVBTableWrite(A, F, T, O, _Cond, V).
% Adapt to factVBTableWrite with offsets
factVBTableWrite(A, F, O, V) :- factVBTableWrite(A, F, V), possibleVBTableWrite(A, F, _, O, V).
% Auto factNOTMergeClasses.
factNOTMergeClasses(A, B) :- class(A), class(B), iso_dif(A, B), not(ignorefactNOTMergeClasses(A, B)).
groundVFTableBelongsToClass(vftable(0), class(0)).
findint(vftable(0), class(0)).
groundVFTableBelongsToClass(vftable(2), class(2)).
findint(vftable(2), class(2)).
groundVFTableBelongsToClass(vftable(3), class(3)).
findint(vftable(3), class(3)).
groundVFTableBelongsToClass(vftable(1), class(1)).
findint(vftable(1), class(1)).
groundVFTableBelongsToClass(vftable(4), class(3)).
findint(vftable(4), class(3)).
groundConstructor(function(0)).
groundConstructor(function(7)).
groundConstructor(function(8)).
groundConstructor(function(10)).
groundDestructor(function(3)).
groundDestructor(function(6)).
groundDestructor(function(9)).
check_VftableBelongs_sound(Arg) :- forall((reasonVFTableBelongsToClass(VFTable, _, Class, _, _)), ((groundVFTableBelongsToClass(VFTable, Class)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])))).
check_VftableBelongs_complete(Arg) :- forall((groundVFTableBelongsToClass(VFTable, Class)), ((snapshot((true, reasonVFTableBelongsToClass(VFTable, _, Class, _, _)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','VftableBelongs','VftableBelongs',(VFTable, Class), Arg])))).
check_Method_sound(Arg) :- forall((reasonMethod(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','Method','Method',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','Method','Method',(M), Arg])))).
check_MethodB_sound(Arg) :- forall((reasonMethod_B(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodB','MethodB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodB','MethodB',(M), Arg])))).
check_MethodC_sound(Arg) :- forall((reasonMethod_C(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodC','MethodC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodC','MethodC',(M), Arg])))).
check_MethodD_sound(Arg) :- forall((reasonMethod_D(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodD','MethodD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodD','MethodD',(M), Arg])))).
check_MethodE_sound(Arg) :- forall((reasonMethod_E(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodE','MethodE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodE','MethodE',(M), Arg])))).
check_MethodF_sound(Arg) :- forall((reasonMethod_F(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodF','MethodF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodF','MethodF',(M), Arg])))).
check_MethodG_sound(Arg) :- forall((reasonMethod_G(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodG','MethodG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodG','MethodG',(M), Arg])))).
check_MethodH_sound(Arg) :- forall((reasonMethod_H(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodH','MethodH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodH','MethodH',(M), Arg])))).
check_MethodI_sound(Arg) :- forall((reasonMethod_I(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodI','MethodI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodI','MethodI',(M), Arg])))).
check_MethodJ_sound(Arg) :- forall((reasonMethod_J(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodJ','MethodJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodJ','MethodJ',(M), Arg])))).
check_MethodK_sound(Arg) :- forall((reasonMethod_K(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodK','MethodK',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodK','MethodK',(M), Arg])))).
check_MethodL_sound(Arg) :- forall((reasonMethod_L(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodL','MethodL',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodL','MethodL',(M), Arg])))).
check_MethodM_sound(Arg) :- forall((reasonMethod_M(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodM','MethodM',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodM','MethodM',(M), Arg])))).
check_MethodN_sound(Arg) :- forall((reasonMethod_N(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodN','MethodN',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodN','MethodN',(M), Arg])))).
check_MethodO_sound(Arg) :- forall((reasonMethod_O(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodO','MethodO',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodO','MethodO',(M), Arg])))).
check_MethodP_sound(Arg) :- forall((reasonMethod_P(M)), ((factMethod(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodP','MethodP',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MethodP','MethodP',(M), Arg])))).
check_Method_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','Method','Method',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','Method','Method',(M), Arg])))).
check_MethodB_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_B(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodB','MethodB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodB','MethodB',(M), Arg])))).
check_MethodC_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_C(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodC','MethodC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodC','MethodC',(M), Arg])))).
check_MethodD_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_D(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodD','MethodD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodD','MethodD',(M), Arg])))).
check_MethodE_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_E(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodE','MethodE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodE','MethodE',(M), Arg])))).
check_MethodF_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_F(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodF','MethodF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodF','MethodF',(M), Arg])))).
check_MethodG_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_G(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodG','MethodG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodG','MethodG',(M), Arg])))).
check_MethodH_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_H(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodH','MethodH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodH','MethodH',(M), Arg])))).
check_MethodI_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_I(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodI','MethodI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodI','MethodI',(M), Arg])))).
check_MethodJ_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_J(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodJ','MethodJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodJ','MethodJ',(M), Arg])))).
check_MethodK_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_K(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodK','MethodK',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodK','MethodK',(M), Arg])))).
check_MethodL_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_L(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodL','MethodL',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodL','MethodL',(M), Arg])))).
check_MethodM_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_M(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodM','MethodM',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodM','MethodM',(M), Arg])))).
check_MethodN_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_N(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodN','MethodN',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodN','MethodN',(M), Arg])))).
check_MethodO_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_O(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodO','MethodO',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodO','MethodO',(M), Arg])))).
check_MethodP_complete(Arg) :- forall((factMethod(M)), ((snapshot((retract(factMethod(M)), reasonMethod_P(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodP','MethodP',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MethodP','MethodP',(M), Arg])))).
check_NOTConstructor_sound(Arg) :- forall((reasonNOTConstructor(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructor','NOTConstructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructor','NOTConstructor',(M), Arg])))).
check_NOTConstructorB_sound(Arg) :- forall((reasonNOTConstructor_B(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorB','NOTConstructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorB','NOTConstructorB',(M), Arg])))).
check_NOTConstructorC_sound(Arg) :- forall((reasonNOTConstructor_C(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorC','NOTConstructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorC','NOTConstructorC',(M), Arg])))).
check_NOTConstructorD_sound(Arg) :- forall((reasonNOTConstructor_D(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorD','NOTConstructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorD','NOTConstructorD',(M), Arg])))).
check_NOTConstructorF_sound(Arg) :- forall((reasonNOTConstructor_F(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorF','NOTConstructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorF','NOTConstructorF',(M), Arg])))).
check_NOTConstructorG_sound(Arg) :- forall((reasonNOTConstructor_G(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorG','NOTConstructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorG','NOTConstructorG',(M), Arg])))).
check_NOTConstructorH_sound(Arg) :- forall((reasonNOTConstructor_H(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorH','NOTConstructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorH','NOTConstructorH',(M), Arg])))).
check_NOTConstructorI_sound(Arg) :- forall((reasonNOTConstructor_I(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorI','NOTConstructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorI','NOTConstructorI',(M), Arg])))).
check_NOTConstructorJ_sound(Arg) :- forall((reasonNOTConstructor_J(M)), ((factNOTConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorJ','NOTConstructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTConstructorJ','NOTConstructorJ',(M), Arg])))).
check_NOTConstructor_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructor','NOTConstructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructor','NOTConstructor',(M), Arg])))).
check_NOTConstructorB_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_B(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorB','NOTConstructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorB','NOTConstructorB',(M), Arg])))).
check_NOTConstructorC_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_C(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorC','NOTConstructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorC','NOTConstructorC',(M), Arg])))).
check_NOTConstructorD_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_D(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorD','NOTConstructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorD','NOTConstructorD',(M), Arg])))).
check_NOTConstructorF_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_F(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorF','NOTConstructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorF','NOTConstructorF',(M), Arg])))).
check_NOTConstructorG_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_G(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorG','NOTConstructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorG','NOTConstructorG',(M), Arg])))).
check_NOTConstructorH_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_H(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorH','NOTConstructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorH','NOTConstructorH',(M), Arg])))).
check_NOTConstructorI_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_I(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorI','NOTConstructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorI','NOTConstructorI',(M), Arg])))).
check_NOTConstructorJ_complete(Arg) :- forall((factNOTConstructor(M)), ((snapshot((retract(factNOTConstructor(M)), reasonNOTConstructor_J(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorJ','NOTConstructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTConstructorJ','NOTConstructorJ',(M), Arg])))).
check_Constructor_sound(Arg) :- forall((reasonConstructor(M)), ((factConstructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','Constructor','Constructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','Constructor','Constructor',(M), Arg])))).
check_Constructor_complete(Arg) :- forall((factConstructor(M)), ((snapshot((retract(factConstructor(M)), reasonConstructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','Constructor','Constructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','Constructor','Constructor',(M), Arg])))).
check_RealDestructor_sound(Arg) :- forall((reasonRealDestructor(M)), ((factRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','RealDestructor','RealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','RealDestructor','RealDestructor',(M), Arg])))).
check_RealDestructor_complete(Arg) :- forall((factRealDestructor(M)), ((snapshot((retract(factRealDestructor(M)), reasonRealDestructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','RealDestructor','RealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','RealDestructor','RealDestructor',(M), Arg])))).
check_NOTRealDestructor_sound(Arg) :- forall((reasonNOTRealDestructor(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructor','NOTRealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructor','NOTRealDestructor',(M), Arg])))).
check_NOTRealDestructorB_sound(Arg) :- forall((reasonNOTRealDestructor_B(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])))).
check_NOTRealDestructorC_sound(Arg) :- forall((reasonNOTRealDestructor_C(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])))).
check_NOTRealDestructorD_sound(Arg) :- forall((reasonNOTRealDestructor_D(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])))).
check_NOTRealDestructorE_sound(Arg) :- forall((reasonNOTRealDestructor_E(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])))).
check_NOTRealDestructorF_sound(Arg) :- forall((reasonNOTRealDestructor_F(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])))).
check_NOTRealDestructorG_sound(Arg) :- forall((reasonNOTRealDestructor_G(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])))).
check_NOTRealDestructorH_sound(Arg) :- forall((reasonNOTRealDestructor_H(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])))).
check_NOTRealDestructorI_sound(Arg) :- forall((reasonNOTRealDestructor_I(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])))).
check_NOTRealDestructorJ_sound(Arg) :- forall((reasonNOTRealDestructor_J(M)), ((factNOTRealDestructor(M)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])))).
check_NOTRealDestructor_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructor','NOTRealDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructor','NOTRealDestructor',(M), Arg])))).
check_NOTRealDestructorB_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_B(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorB','NOTRealDestructorB',(M), Arg])))).
check_NOTRealDestructorC_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_C(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorC','NOTRealDestructorC',(M), Arg])))).
check_NOTRealDestructorD_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_D(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorD','NOTRealDestructorD',(M), Arg])))).
check_NOTRealDestructorE_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_E(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorE','NOTRealDestructorE',(M), Arg])))).
check_NOTRealDestructorF_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_F(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorF','NOTRealDestructorF',(M), Arg])))).
check_NOTRealDestructorG_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_G(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorG','NOTRealDestructorG',(M), Arg])))).
check_NOTRealDestructorH_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_H(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorH','NOTRealDestructorH',(M), Arg])))).
check_NOTRealDestructorI_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_I(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorI','NOTRealDestructorI',(M), Arg])))).
check_NOTRealDestructorJ_complete(Arg) :- forall((factNOTRealDestructor(M)), ((snapshot((retract(factNOTRealDestructor(M)), reasonNOTRealDestructor_J(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTRealDestructorJ','NOTRealDestructorJ',(M), Arg])))).
check_VFTableSizeGTE_sound(Arg) :- forall((reasonVFTableSizeGTE(V, S), factVFTableSizeGTE(V, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeGTE','VFTableSizeGTE',(V, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeGTE','VFTableSizeGTE',(V, S, Sground), Arg])))).
check_VFTableSizeLTE_sound(Arg) :- forall((reasonVFTableSizeLTE(V, S), factVFTableSizeLTE(V, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeLTE','VFTableSizeLTE',(V, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','VFTableSizeLTE','VFTableSizeLTE',(V, S, Sground), Arg])))).
check_ClassSizeGTE_sound(Arg) :- forall((reasonClassSizeGTE(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTE','ClassSizeGTE',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTE','ClassSizeGTE',(C, S, Sground), Arg])))).
check_ClassSizeGTEB_sound(Arg) :- forall((reasonClassSizeGTE_B(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEB','ClassSizeGTEB',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEB','ClassSizeGTEB',(C, S, Sground), Arg])))).
check_ClassSizeGTEC_sound(Arg) :- forall((reasonClassSizeGTE_C(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEC','ClassSizeGTEC',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEC','ClassSizeGTEC',(C, S, Sground), Arg])))).
check_ClassSizeGTED_sound(Arg) :- forall((reasonClassSizeGTE_D(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTED','ClassSizeGTED',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTED','ClassSizeGTED',(C, S, Sground), Arg])))).
check_ClassSizeGTEF_sound(Arg) :- forall((reasonClassSizeGTE_F(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEF','ClassSizeGTEF',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEF','ClassSizeGTEF',(C, S, Sground), Arg])))).
check_ClassSizeGTEG_sound(Arg) :- forall((reasonClassSizeGTE_G(C, S), factClassSizeGTE(C, Sground)), ((Sground >= S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEG','ClassSizeGTEG',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeGTEG','ClassSizeGTEG',(C, S, Sground), Arg])))).
check_ClassSizeLTE_sound(Arg) :- forall((reasonClassSizeLTE(C, S), factClassSizeLTE(C, Sground)), ((Sground =< S) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTE','ClassSizeLTE',(C, S, Sground), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassSizeLTE','ClassSizeLTE',(C, S, Sground), Arg])))).
check_DerivedClass_sound(Arg) :- forall((reasonDerivedClass(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClass','DerivedClass',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClass','DerivedClass',(Outer, Inner, Offset), Arg])))).
check_DerivedClassB_sound(Arg) :- forall((reasonDerivedClass_B(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassB','DerivedClassB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassB','DerivedClassB',(Outer, Inner, Offset), Arg])))).
check_DerivedClassC_sound(Arg) :- forall((reasonDerivedClass_C(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassC','DerivedClassC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassC','DerivedClassC',(Outer, Inner, Offset), Arg])))).
check_DerivedClassD_sound(Arg) :- forall((reasonDerivedClass_D(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassD','DerivedClassD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassD','DerivedClassD',(Outer, Inner, Offset), Arg])))).
check_DerivedClassE_sound(Arg) :- forall((reasonDerivedClass_E(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassE','DerivedClassE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassE','DerivedClassE',(Outer, Inner, Offset), Arg])))).
check_DerivedClassF_sound(Arg) :- forall((reasonDerivedClass_F(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassF','DerivedClassF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassF','DerivedClassF',(Outer, Inner, Offset), Arg])))).
check_DerivedClass_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClass','DerivedClass',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClass','DerivedClass',(Outer, Inner, Offset), Arg])))).
check_DerivedClassB_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_B(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassB','DerivedClassB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassB','DerivedClassB',(Outer, Inner, Offset), Arg])))).
check_DerivedClassC_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_C(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassC','DerivedClassC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassC','DerivedClassC',(Outer, Inner, Offset), Arg])))).
check_DerivedClassD_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_D(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassD','DerivedClassD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassD','DerivedClassD',(Outer, Inner, Offset), Arg])))).
check_DerivedClassE_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_E(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassE','DerivedClassE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassE','DerivedClassE',(Outer, Inner, Offset), Arg])))).
check_DerivedClassF_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), retract(factObjectInObject(Outer, Inner, Offset)), reasonDerivedClass_F(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassF','DerivedClassF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassF','DerivedClassF',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIO_sound(Arg) :- forall((reasonDerivedClass(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOB_sound(Arg) :- forall((reasonDerivedClass_B(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOC_sound(Arg) :- forall((reasonDerivedClass_C(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOD_sound(Arg) :- forall((reasonDerivedClass_D(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOE_sound(Arg) :- forall((reasonDerivedClass_E(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOF_sound(Arg) :- forall((reasonDerivedClass_F(Outer, Inner, Offset)), ((factDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIO_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), reasonDerivedClass(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIO','DerivedClassOIO',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOB_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), reasonDerivedClass_B(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOB','DerivedClassOIOB',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOC_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), reasonDerivedClass_C(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOC','DerivedClassOIOC',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOD_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), reasonDerivedClass_D(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOD','DerivedClassOIOD',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOE_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), reasonDerivedClass_E(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOE','DerivedClassOIOE',(Outer, Inner, Offset), Arg])))).
check_DerivedClassOIOF_complete(Arg) :- forall((factDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factDerivedClass(Outer, Inner, Offset)), reasonDerivedClass_F(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','DerivedClassOIOF','DerivedClassOIOF',(Outer, Inner, Offset), Arg])))).
check_NOTDerivedClass_sound(Arg) :- forall((reasonNOTDerivedClass(Outer, Inner, Offset)), ((factNOTDerivedClass(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])))).
check_NOTDerivedClass_complete(Arg) :- forall((factNOTDerivedClass(Outer, Inner, Offset)), ((snapshot((retract(factNOTDerivedClass(Outer, Inner, Offset)), reasonNOTDerivedClass(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTDerivedClass','NOTDerivedClass',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObject_sound(Arg) :- forall((reasonEmbeddedObject(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectB_sound(Arg) :- forall((reasonEmbeddedObject_B(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectC_sound(Arg) :- forall((reasonEmbeddedObject_C(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectD_sound(Arg) :- forall((reasonEmbeddedObject_D(Outer, Inner, Offset)), ((factEmbeddedObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObject_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObject','EmbeddedObject',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectB_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject_B(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectB','EmbeddedObjectB',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectC_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject_C(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectC','EmbeddedObjectC',(Outer, Inner, Offset), Arg])))).
check_EmbeddedObjectD_complete(Arg) :- forall((factEmbeddedObject(Outer, Inner, Offset)), ((snapshot((retract(factEmbeddedObject(Outer, Inner, Offset)), reasonEmbeddedObject_D(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','EmbeddedObjectD','EmbeddedObjectD',(Outer, Inner, Offset), Arg])))).
check_ObjectInObject_sound(Arg) :- forall((reasonObjectInObject(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectB_sound(Arg) :- forall((reasonObjectInObject_B(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectC_sound(Arg) :- forall((reasonObjectInObject_C(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectD_sound(Arg) :- forall((reasonObjectInObject_D(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectE_sound(Arg) :- forall((reasonObjectInObject_E(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectF_sound(Arg) :- forall((reasonObjectInObject_F(Outer, Inner, Offset)), ((factObjectInObject(Outer, Inner, Offset)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])))).
check_ObjectInObject_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObject','ObjectInObject',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectB_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_B(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectB','ObjectInObjectB',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectC_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_C(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectC','ObjectInObjectC',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectD_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_D(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectD','ObjectInObjectD',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectE_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_E(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectE','ObjectInObjectE',(Outer, Inner, Offset), Arg])))).
check_ObjectInObjectF_complete(Arg) :- forall((factObjectInObject(Outer, Inner, Offset)), ((snapshot((retract(factObjectInObject(Outer, Inner, Offset)), reasonObjectInObject_F(Outer, Inner, Offset)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ObjectInObjectF','ObjectInObjectF',(Outer, Inner, Offset), Arg])))).
check_MergeClasses_sound(Arg) :- forall((reasonMergeClasses(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClasses','MergeClasses',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClasses','MergeClasses',(C, Class2), Arg])))).
check_MergeClassesB_sound(Arg) :- forall((reasonMergeClasses_B(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesB','MergeClassesB',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesB','MergeClassesB',(C, Class2), Arg])))).
check_MergeClassesC_sound(Arg) :- forall((reasonMergeClasses_C(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesC','MergeClassesC',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesC','MergeClassesC',(C, Class2), Arg])))).
check_MergeClassesE_sound(Arg) :- forall((reasonMergeClasses_E(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesE','MergeClassesE',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesE','MergeClassesE',(C, Class2), Arg])))).
check_MergeClassesG_sound(Arg) :- forall((reasonMergeClasses_G(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesG','MergeClassesG',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesG','MergeClassesG',(C, Class2), Arg])))).
check_MergeClassesH_sound(Arg) :- forall((reasonMergeClasses_H(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesH','MergeClassesH',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesH','MergeClassesH',(C, Class2), Arg])))).
check_MergeClassesJ_sound(Arg) :- forall((reasonMergeClasses_J(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesJ','MergeClassesJ',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesJ','MergeClassesJ',(C, Class2), Arg])))).
check_MergeClassesK_sound(Arg) :- forall((reasonMergeClasses_K(C, Class2)), ((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesK','MergeClassesK',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','MergeClassesK','MergeClassesK',(C, Class2), Arg])))).
check_MergeClasses_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClasses','MergeClasses',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClasses','MergeClasses',(C, Class2), Arg])))).
check_MergeClassesB_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_B(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesB','MergeClassesB',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesB','MergeClassesB',(C, Class2), Arg])))).
check_MergeClassesC_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_C(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesC','MergeClassesC',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesC','MergeClassesC',(C, Class2), Arg])))).
check_MergeClassesE_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_E(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesE','MergeClassesE',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesE','MergeClassesE',(C, Class2), Arg])))).
check_MergeClassesG_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_G(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesG','MergeClassesG',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesG','MergeClassesG',(C, Class2), Arg])))).
check_MergeClassesH_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_H(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesH','MergeClassesH',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesH','MergeClassesH',(C, Class2), Arg])))).
check_MergeClassesJ_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_J(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesJ','MergeClassesJ',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesJ','MergeClassesJ',(C, Class2), Arg])))).
check_MergeClassesK_complete(Arg) :- forall((find(Class1, C), find(Class2, C), iso_dif(Class1, Class2)), ((snapshot((retractall(classArgs(factNOTMergeClasses/2, _)), retract(findint(Class2, C)), assert(findint(Class2, Class2)), (forall(fixupClasses(C, Class2, _, NewFact), assert(NewFact)); true), reasonMergeClasses_K(C, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesK','MergeClassesK',(C, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','MergeClassesK','MergeClassesK',(C, Class2), Arg])))).
check_NOTMergeClasses_sound(Arg) :- forall((reasonNOTMergeClasses(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])))).
check_NOTMergeClassesJ_sound(Arg) :- forall((reasonNOTMergeClasses_J(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])))).
check_NOTMergeClassesC_sound(Arg) :- forall((reasonNOTMergeClasses_C(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])))).
check_NOTMergeClassesE_sound(Arg) :- forall((reasonNOTMergeClasses_E(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])))).
check_NOTMergeClassesF_sound(Arg) :- forall((reasonNOTMergeClasses_F(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])))).
check_NOTMergeClassesG_sound(Arg) :- forall((reasonNOTMergeClasses_G(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])))).
check_NOTMergeClassesI_sound(Arg) :- forall((reasonNOTMergeClasses_I(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])))).
check_NOTMergeClassesK_sound(Arg) :- forall((reasonNOTMergeClasses_K(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])))).
check_NOTMergeClassesL_sound(Arg) :- forall((reasonNOTMergeClasses_L(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])))).
check_NOTMergeClassesM_sound(Arg) :- forall((reasonNOTMergeClasses_M(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])))).
check_NOTMergeClassesO_sound(Arg) :- forall((reasonNOTMergeClasses_O(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])))).
check_NOTMergeClassesP_sound(Arg) :- forall((reasonNOTMergeClasses_P(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])))).
check_NOTMergeClassesQ_sound(Arg) :- forall((reasonNOTMergeClasses_Q(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])))).
check_NOTMergeClassesR_sound(Arg) :- forall((reasonNOTMergeClasses_R(Class1, Class2)), ((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])))).
check_NOTMergeClasses_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClasses','NOTMergeClasses',(Class1, Class2), Arg])))).
check_NOTMergeClassesJ_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_J(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesJ','NOTMergeClassesJ',(Class1, Class2), Arg])))).
check_NOTMergeClassesC_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_C(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesC','NOTMergeClassesC',(Class1, Class2), Arg])))).
check_NOTMergeClassesE_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_E(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesE','NOTMergeClassesE',(Class1, Class2), Arg])))).
check_NOTMergeClassesF_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_F(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesF','NOTMergeClassesF',(Class1, Class2), Arg])))).
check_NOTMergeClassesG_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_G(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesG','NOTMergeClassesG',(Class1, Class2), Arg])))).
check_NOTMergeClassesI_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_I(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesI','NOTMergeClassesI',(Class1, Class2), Arg])))).
check_NOTMergeClassesK_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_K(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesK','NOTMergeClassesK',(Class1, Class2), Arg])))).
check_NOTMergeClassesL_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_L(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesL','NOTMergeClassesL',(Class1, Class2), Arg])))).
check_NOTMergeClassesM_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_M(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesM','NOTMergeClassesM',(Class1, Class2), Arg])))).
check_NOTMergeClassesO_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_O(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesO','NOTMergeClassesO',(Class1, Class2), Arg])))).
check_NOTMergeClassesP_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_P(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesP','NOTMergeClassesP',(Class1, Class2), Arg])))).
check_NOTMergeClassesQ_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_Q(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesQ','NOTMergeClassesQ',(Class1, Class2), Arg])))).
check_NOTMergeClassesR_complete(Arg) :- forall((find(_, Class1), find(_, Class2), iso_dif(Class1, Class2)), ((snapshot((assert(ignorefactNOTMergeClasses(Class1, Class2)), assert(ignorefactNOTMergeClasses(Class2, Class1)), reasonNOTMergeClasses_R(Class1, Class2)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','NOTMergeClassesR','NOTMergeClassesR',(Class1, Class2), Arg])))).
check_ClassCallsMethod_sound(Arg) :- forall((reasonClassCallsMethod(Class, Method)), ((factClassCallsMethod(Class, Method)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethod','ClassCallsMethod',(Class, Method), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethod','ClassCallsMethod',(Class, Method), Arg])))).
check_ClassCallsMethodB_sound(Arg) :- forall((reasonClassCallsMethod_B(Class, Method)), ((factClassCallsMethod(Class, Method)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodB','ClassCallsMethodB',(Class, Method), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodB','ClassCallsMethodB',(Class, Method), Arg])))).
check_ClassCallsMethodC_sound(Arg) :- forall((reasonClassCallsMethod_C(Class, Method)), ((factClassCallsMethod(Class, Method)) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodC','ClassCallsMethodC',(Class, Method), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','ClassCallsMethodC','ClassCallsMethodC',(Class, Method), Arg])))).
check_ClassCallsMethod_complete(Arg) :- forall((factClassCallsMethod(Class, Method)), ((snapshot((retract(factClassCallsMethod(Class, Method)), reasonClassCallsMethod(Class, Method)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethod','ClassCallsMethod',(Class, Method), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethod','ClassCallsMethod',(Class, Method), Arg])))).
check_ClassCallsMethodB_complete(Arg) :- forall((factClassCallsMethod(Class, Method)), ((snapshot((retract(factClassCallsMethod(Class, Method)), reasonClassCallsMethod_B(Class, Method)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodB','ClassCallsMethodB',(Class, Method), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodB','ClassCallsMethodB',(Class, Method), Arg])))).
check_ClassCallsMethodC_complete(Arg) :- forall((factClassCallsMethod(Class, Method)), ((snapshot((retract(factClassCallsMethod(Class, Method)), reasonClassCallsMethod_C(Class, Method)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodC','ClassCallsMethodC',(Class, Method), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','ClassCallsMethodC','ClassCallsMethodC',(Class, Method), Arg])))).
check_CertainConstructorOrDestructor_sound(Arg) :- forall((certainConstructorOrDestructor(M)), (((factConstructor(M); factRealDestructor(M); factDeletingDestructor(M))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['sound','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['sound','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])))).
check_CertainConstructorOrDestructor_complete(Arg) :- forall(((factConstructor(M); factRealDestructor(M); factDeletingDestructor(M))), ((snapshot((ignore(retract(factConstructor(M))), ignore(retract(factRealDestructor(M))), ignore(retract(realDeletingDestructor(M))), certainConstructorOrDestructor(M)))) -> (format('RESULT,TRUE,~w,~w,"~w(~w)","~w"~n', ['complete','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])); (format('RESULT,FALSE,~w,~w,"~w(~w)","~w"~n', ['complete','CertainConstructorOrDestructor','CertainConstructorOrDestructor',(M), Arg])))).
