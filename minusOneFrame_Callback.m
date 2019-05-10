function plusOneFrame_Callback(hObject, eventdata)

global vid_fig_hand;
global vid_obj;

curr_frame = get(vid_fig_hand.frameEdithandle, 'String');
curr_frame = str2num(curr_frame);

frameMinusOne = curr_frame -1;
updateFrameFunction(frameMinusOne, vid_obj);


end