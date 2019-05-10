function placeVid_Callback(hObject, eventdata)

global vid_fig_hand;
global vid_obj;

selected_file = get(vid_fig_hand.listFiles_handle,'Value');
vid_list = get(vid_fig_hand.listFiles_handle,'String');
vid_name = vid_list{selected_file};
set(vid_fig_hand.RowEditHd, 'String', str2double(vid_name(end-4)));
set(vid_fig_hand.RowEditHdDOOROPEN, 'String', (1));
set(vid_fig_hand.RowEditHdRCHONSET, 'String', (1));
set(vid_fig_hand.RowEditHdTRLOUTCOME, 'String', (1));



try
    vid_obj.obj = VideoReader(vid_name);
catch
    warning( 'File named in edit box does not appear to be a usable movie file');
    return
end

time_to_remember = vid_obj.obj.CurrentTime;
vidnumFrames = 0;
while hasFrame(vid_obj.obj)
    readFrame(vid_obj.obj);
    vidnumFrames = vidnumFrames + 1;
end
vid_obj.obj.CurrentTime = time_to_remember;
vid_obj.vidnumFrames = vidnumFrames;

vidHeight = vid_obj.obj.Height;
vidWidth = vid_obj.obj.Width;

% Create a MATLAB� movie structure array, s.

vid_obj.structure = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'),...
    'colormap',[]);

k = 1;
while hasFrame(vid_obj.obj)
    vid_obj.structure(k).cdata = readFrame(vid_obj.obj);
    k = k+1;
end

set(vid_fig_hand.frameEdithandle, 'String', 1);
set(vid_fig_hand.vid_ax, 'XTick', []);
set(vid_fig_hand.vid_ax, 'YTick', []);


updateFrameFunction(1, vid_obj);


end

