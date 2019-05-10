function plusOneFrame_Callback(hObject, eventdata)

global vid_fig_hand;
global vid_obj;

curr_frame = get(vid_fig_hand.frameEdithandle, 'String');
curr_frame = str2num(curr_frame);

framePlusTen = curr_frame +10;
updateFrameFunction(framePlusTen, vid_obj);


end