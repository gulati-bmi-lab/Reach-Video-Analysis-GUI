function plusOneFrame_Callback(hObject, eventdata)

global vid_fig_hand;
global vid_obj;

curr_frame = get(vid_fig_hand.frameEdithandle, 'String');
curr_frame = str2num(curr_frame);

framePlusOne = curr_frame +1;
updateFrameFunction(framePlusOne, vid_obj);


end