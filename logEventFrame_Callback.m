function logEventFrame_Callback(hObject, eventdata)

global vid_fig_hand;

trial_row = get(vid_fig_hand.RowEditHd, 'String');
trial_row = num2str(trial_row);

rchonset = get(vid_fig_hand.RowEditHdRCHONSET, 'String');
rchonset = num2str(rchonset);

trlOutcome = get(vid_fig_hand.RowEditHdTRLOUTCOME, 'String');
trlOutcome = num2str(trlOutcome);

oldData = get(vid_fig_hand.uit,'Data');
[D1, D2]=size(oldData);
if D1 == 1
    if D2 == 1
        oldData = {-1,-1};
    end
end

newRow = {trial_row, rchonset, trlOutcome};
newData = [oldData; newRow];
set(vid_fig_hand.uit,'Data',newData)


end