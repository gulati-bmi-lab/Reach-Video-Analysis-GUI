function findFiles_Callback(hObject, eventdata)

global vid_fig_hand;

vid_dir = get(vid_fig_hand.VID_DIR_handle, 'String');
% get what is inside the folder
Infolder = dir(vid_dir);
video_files_cellArr = {Infolder(~[Infolder.isdir]).name}.';

indexed_by_movies = contains(video_files_cellArr, '.avi');
video_files_cellArr = video_files_cellArr(indexed_by_movies);

% shortlisting by rat ID
vid_ratID = get(vid_fig_hand.NAME_handle, 'String');
indexed_by_ratID = contains(video_files_cellArr, vid_ratID);
video_files_cellArr = video_files_cellArr(indexed_by_ratID);

% shortlisting by date
vid_date = get(vid_fig_hand.dateEditBoxHandle, 'String');
[y,m,d]=ymd(datetime(vid_date));
vid_date = [num2str(y),...
    '_',num2str(m),...
    '_',num2str(d)];

indexed_by_date = contains(video_files_cellArr, vid_date);
video_files_cellArr = video_files_cellArr(indexed_by_date);

% update the listbox with the result
set(vid_fig_hand.listFiles_handle,'Value',1); % Add this line so that the list can be changed
set(vid_fig_hand.listFiles_handle,'String',video_files_cellArr)

end