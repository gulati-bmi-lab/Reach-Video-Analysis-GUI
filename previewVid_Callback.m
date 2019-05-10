function previewVid_Callback(hObject, eventdata)

global vid_fig_hand;

selected_file = get(vid_fig_hand.listFiles_handle,'Value');
vid_list = get(vid_fig_hand.listFiles_handle,'String');
vid_name = vid_list{selected_file};
implay(vid_name);

end