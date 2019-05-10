%% VIDEO ANALYSIS GUI
% Shakthi Visagan
% This script and GUI was designed for the larger laptops.

clc; clear; close all;

%% FIGURE WINDOW

% need to clear pre-existing objects (if any)
clear screen_info screen_width screen_height white_space_prop;
clear vid_fig_hand
clear vid_fig_pos;

global vid_fig_hand;

% left	 Distance from the left edge of the primary display to the inner left edge of the window. This value can be negative on systems that have more than one monitor.
% bottom Distance from the bottom edge of the primary display to the inner bottom edge of the window. This value can be negative on systems that have more than one monitor.
% width	 Distance between the right and left inner edges of the figure.
% height Distance between the top and bottom inner edges of the window.

left = 10;
bottom = 10;
width =  1500;
height = 750;
clear screen_width screen_height white_space_prop;

vid_fig_pos=[left bottom width height];
clear left bottom width height;

vid_fig_hand.fig = figure('Position',vid_fig_pos,...
    'MenuBar','none',...
    'NumberTitle','off',...
    'CloseRequestFcn',@vid_fig_close_Callback,...
    'Name','Video Analysis by SHAKTHI VISAGAN');

set(vid_fig_hand.fig, 'WindowKeyPressFcn', @vid_fig_hand_fig_WindowKeyPressFcn);

%% Notes about GUI

% for Positions:
% [left bottom width height]
% left	 Distance from the inner left edge of the parent container to the outer left edge of the user interface control
% bottom Distance from the inner bottom edge of the parent container to the outer bottom edge of the user interface control
% width	 Distance between the right and left outer edges of the user interface control
% height Distance between the top and bottom outer edges of the user interface control

%% GET VID_DIR and VID_DIR

clear VID_DIR;

addpath(pwd);
cd('../')

VID_DIR = pwd;
addpath(VID_DIR); % add to the path the directory of the videos

vid_fig_hand.VID_DIR_txt_handle = uicontrol(vid_fig_hand.fig,...
    'Style','text',...
    'Position',[10 650 190 40],...
    'String','Video Directory:');

set(vid_fig_hand.VID_DIR_txt_handle,'FontSize',20);
set(vid_fig_hand.VID_DIR_txt_handle, 'TooltipString', 'Enter the name of the directory in which the videos are saved.')


vid_fig_hand.VID_DIR_handle = uicontrol(vid_fig_hand.fig,...
    'Style','edit',...
    'Position',[200 655 850 30]);

set(vid_fig_hand.VID_DIR_handle,'String',VID_DIR);
set(vid_fig_hand.VID_DIR_handle,'FontSize',12);
set(vid_fig_hand.VID_DIR_handle,'BackgroundColor',[0.4 0.7 0.6 ]);
set(vid_fig_hand.VID_DIR_handle, 'TooltipString', 'Enter the name of the directory in which the videos are saved.')

clear VID_DIR;
clear VID_DIR_cell;

%% RAT ID

vid_fig_hand.NAME_txt_handle = uicontrol(vid_fig_hand.fig,...
    'Style','text',...
    'Position',[10 615 175 40],...
    'String','Subject Name:');

set(vid_fig_hand.NAME_txt_handle,'FontSize',20);
set(vid_fig_hand.NAME_txt_handle, 'TooltipString', 'Enter the name of the rat of interest.')

vid_fig_hand.NAME_handle = uicontrol(vid_fig_hand.fig,...
    'Style','edit',...
    'Position',[185 620 175 30]);

set(vid_fig_hand.NAME_handle,'String','Txxx');
set(vid_fig_hand.NAME_handle,'FontSize',20);
set(vid_fig_hand.NAME_handle,'BackgroundColor',[0 0.7 1 ]);
set(vid_fig_hand.NAME_handle,'String','Txxx');
set(vid_fig_hand.NAME_handle, 'TooltipString', 'Enter the name of the rat here. This is usually in the form of Txxx. For example T003 is a a valid example, if that rat exists.')

%% Date

clear todayDateString;

vid_fig_hand.dateTextHandle = uicontrol(vid_fig_hand.fig, 'Style', 'Text', ...
    'FontSize', 20,...
    'String', 'Date:', ...
    'TooltipString', 'Enter the date of the trials which you would like to analyze. For example, 03-Apr-2019 is a valid date, if trials were conducted on that day.',...
    'Horizontalalignment', 'left', ...
    'Position', [10 580 66 40]);

vid_fig_hand.dateEditBoxHandle = uicontrol(vid_fig_hand.fig, 'Style', 'Edit', ...
    'Position', [76 585 150 30], ...
    'TooltipString', 'Date in the format of two number day, three letter month, four number year. For example, 14-Mar-2015 and 25-Nov-2019 are both valid.',...
    'BackgroundColor', [0.8 0.2 0.5 ]);

todayDateString = date;
set(vid_fig_hand.dateEditBoxHandle,'String',todayDateString);
set(vid_fig_hand.dateEditBoxHandle,'FontSize',20);
clear todayDateString;

%%

vid_fig_hand.listFiles_handle = uicontrol(vid_fig_hand.fig,...
    'Style','listbox',...
    'Position',[10 340 260 200],...
    'String',{'Welcome...'},...
    'FontSize',9);

%%

vid_fig_hand.findFiles = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','FIND FILES',...
    'Position',[10 545 66 30],...
    'Callback',@findFiles_Callback);


%%

vid_fig_hand.previewVid = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','PREVIEW',...
    'Position',[10 305 66 30],...
    'Callback',@previewVid_Callback);

%%

% ax = axes('Position', [left bottom width height])
% Note that the values are specified in normalized units, 
% i.e. the position values can change from 0 to 1.

vid_fig_hand.vid_ax=axes('Position',[0.1825 0.18 1.1/2.75 (1.2*640/480/2.75)]);
set(vid_fig_hand.vid_ax, 'XTick', []);
set(vid_fig_hand.vid_ax, 'YTick', []);
set(vid_fig_hand.vid_ax, 'Xcolor', 'k');
set(vid_fig_hand.vid_ax, 'Ycolor', 'k');
set(vid_fig_hand.vid_ax, 'Color', 'k');
title(vid_fig_hand.vid_ax, 'Frame Control');


%%

vid_fig_hand.placeVid = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','PLACE',...
    'Position',[76 305 66 30],...
    'Callback',@placeVid_Callback);

%%

vid_fig_hand.frameEdithandle = uicontrol(vid_fig_hand.fig, 'Style', 'Edit', ...
    'Position', [511 85 150 30], ...
    'BackgroundColor', [0.2 0.9 0.5 ]);

set(vid_fig_hand.frameEdithandle,'String',1);
set(vid_fig_hand.frameEdithandle,'FontSize',20);

%%

vid_fig_hand.plusOneFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','(+1 Frame) >',...
    'Position',[665 85 66 30],...
    'Callback',@plusOneFrame_Callback);

set(vid_fig_hand.plusOneFrame, 'TooltipString', 'Enter just <up arrow> to move up 1 (one) frame.')

%%

vid_fig_hand.minusOneFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','< (-1 Frame)',...
    'Position',[441 85 66 30],...
    'Callback',@minusOneFrame_Callback);

set(vid_fig_hand.minusOneFrame, 'TooltipString', 'Enter just <down arrow> to move down 1 (one) frame.')

%%

vid_fig_hand.plusTenFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','(+10 Frame) >>',...
    'Position',[734 85 78 30],...
    'Callback',@plusTenFrame_Callback);

set(vid_fig_hand.plusTenFrame, 'TooltipString', 'Enter <Shift> and <up arrow> to move up 10 (ten) frames.')

%%

vid_fig_hand.minusTenFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','<< (-10 Frame)',...
    'Position',[360 85 78 30],...
    'Callback',@minusTenFrame_Callback);

set(vid_fig_hand.minusTenFrame, 'TooltipString', 'Enter <Shift> and <down arrow> to move down 10 (ten) frames.')
%%

vid_fig_hand.lastFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','(Last Frame) >|',...
    'Position',[815 85 78 30],...
    'Callback',@lastFrame_Callback);

set(vid_fig_hand.lastFrame, 'TooltipString', 'Click to go to the last frame.')

%%

vid_fig_hand.firstFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','|< (First Frame)',...
    'Position',[278 85 78 30],...
    'Callback',@firstFrame_Callback);

set(vid_fig_hand.firstFrame, 'TooltipString', 'Click to go the first frame.')
%%

vid_fig_hand.goToFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','Go to Frame #',...
    'Position',[545 52 78 30],...
    'Callback',@goToFrame_Callback);

set(vid_fig_hand.goToFrame, 'TooltipString', 'Click to go the frame written in the box above.')

%%

vid_fig_hand.uit = uitable(vid_fig_hand.fig,...
    'Position',[906 370 410 204]);
vid_fig_hand.uit.ColumnName = {'Trial', 'Frame of Door Open', 'Frame of Reach Onset', 'Trial Outcome'};
vid_fig_hand.uit.ColumnEditable = true;



%%

vid_fig_hand.logEventFrame = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','Log Events',...
    'Position',[1322 315 110 30],...
    'Callback',@logEventFrame_Callback);

%%

vid_fig_hand.RowEditHd = uicontrol(vid_fig_hand.fig, 'Style', 'Edit', ...
    'Position', [1125 315 85 30], ...
    'BackgroundColor', [0.8 0.2 0.86 ]);

set(vid_fig_hand.RowEditHd,'String',1);
set(vid_fig_hand.RowEditHd,'FontSize',20);

%%

vid_fig_hand.saveTable = uicontrol(vid_fig_hand.fig,...
    'Style','pushbutton',...
    'String','Save Table',...
    'Position',[1322 515 110 30],...
    'Callback',@saveTable_Callback);

%%

vid_fig_hand.RowEditHdDOOROPEN = uicontrol(vid_fig_hand.fig, 'Style', 'Edit', ...
    'Position', [1125 285 85 30], ...
    'BackgroundColor', [0.4 0.4 0.86 ]);

set(vid_fig_hand.RowEditHdDOOROPEN,'String',1);
set(vid_fig_hand.RowEditHdDOOROPEN,'FontSize',20);

%%

vid_fig_hand.RowEditHdRCHONSET = uicontrol(vid_fig_hand.fig, 'Style', 'Edit', ...
    'Position', [1125 254 85 30], ...
    'BackgroundColor', [0.7 0.99 0.6 ]);

set(vid_fig_hand.RowEditHdRCHONSET,'String',1);
set(vid_fig_hand.RowEditHdRCHONSET,'FontSize',20);

%%

vid_fig_hand.RowEditHdTRLOUTCOME = uicontrol(vid_fig_hand.fig, 'Style', 'Edit', ...
    'Position', [1125 223 85 30], ...
    'BackgroundColor', [0.6 0.99 1 ]);

set(vid_fig_hand.RowEditHdTRLOUTCOME,'String',1);
set(vid_fig_hand.RowEditHdTRLOUTCOME,'FontSize',20);

%%

vid_fig_hand.TRIALNO_TextHandle = uicontrol(vid_fig_hand.fig, 'Style', 'Text', ...
    'FontSize', 20,...
    'String', 'Trial: ', ...
    'Horizontalalignment', 'left', ...
    'Position', [1030 315 85 30]);

%%

vid_fig_hand.DRFRAMENO_TextHandle = uicontrol(vid_fig_hand.fig, 'Style', 'Text', ...
    'FontSize', 20,...
    'String', 'Door Opened: ', ...
    'Horizontalalignment', 'left', ...
    'Position', [925 285 185 30]);

%%

vid_fig_hand.RCHFRAMENO_TextHandle = uicontrol(vid_fig_hand.fig, 'Style', 'Text', ...
    'FontSize', 20,...
    'String', 'Reach Onset: ', ...
    'Horizontalalignment', 'left', ...
    'Position', [927 254 185 30]);

%%

vid_fig_hand.TRIALOT_TextHandle = uicontrol(vid_fig_hand.fig, 'Style', 'Text', ...
    'FontSize', 20,...
    'String', 'Trial Outcome: ', ...
    'Horizontalalignment', 'left', ...
    'Position', [915 223 185 30]);



