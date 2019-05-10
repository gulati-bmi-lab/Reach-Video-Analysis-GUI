function lastFrame_Callback(hObject, eventdata)

global vid_obj;

lastFrame = vid_obj.vidnumFrames-1;

updateFrameFunction(lastFrame, vid_obj);


end