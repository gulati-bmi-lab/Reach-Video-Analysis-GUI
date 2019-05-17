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
vid_index = [];

% shortlisting by time
vid_hr = get(vid_fig_hand.timeEditBoxHandle, 'String');
if ~strcmp(vid_hr,'00h00m')
    indexed_by_time = contains(video_files_cellArr, vid_hr);
    video_files_cellArr = video_files_cellArr(indexed_by_time); 
end

for filename = 1:length(video_files_cellArr)
    vid_name_no = char(video_files_cellArr(filename));
    vid_name = vid_name_no;
    vid_name_no = vid_name_no(end-4);
    if vid_name(end-5) ~= '-'
        vid_name_no = strcat(vid_name(end-5), vid_name_no);
        if vid_name(end-6) ~= '-'
            vid_name_no = strcat(vid_name(end-6),vid_name(end-5), vid_name_no);
        end
    end
   vid_index(filename) =  str2double(vid_name_no);
end
[d, i] = sort(vid_index);
clear d



% update the listbox with the result
set(vid_fig_hand.listFiles_handle,'Value',1); % Add this line so that the list can be changed
set(vid_fig_hand.listFiles_handle,'String',video_files_cellArr(i))

end