function saveTable_Callback(hObject, eventdata)

global vid_fig_hand;

vid_dir = get(vid_fig_hand.VID_DIR_handle, 'String');

selected_file = get(vid_fig_hand.listFiles_handle,'Value');
vid_list = get(vid_fig_hand.listFiles_handle,'String');
vid_name = vid_list{selected_file};
fileFirstString = (vid_name(1:end-5));
todayDateString = date;
s = strcat(vid_dir,'\',fileFirstString,'man_vid_outcomes',todayDateString ,'.mat');

data = get(vid_fig_hand.uit,'Data');

save(s,'data')


end