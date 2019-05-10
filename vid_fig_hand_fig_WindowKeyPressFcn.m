function vid_fig_hand_fig_WindowKeyPressFcn(hObject, eventdata)

global vid_fig_hand

if strcmp(eventdata.Key,'uparrow')
    if isempty(eventdata.Modifier)
        % set focus to the button
        uicontrol(vid_fig_hand.plusOneFrame);
        % call the callback
        plusOneFrame_Callback(vid_fig_hand.plusOneFrame,[]);
    elseif strcmp(eventdata.Modifier{:},'shift')
        % set focus to the button
        uicontrol(vid_fig_hand.plusTenFrame);
        % call the callback
        plusTenFrame_Callback(vid_fig_hand.plusTenFrame,[]);    end
end

if strcmp(eventdata.Key,'downarrow')
    if isempty(eventdata.Modifier)
        % set focus to the button
        uicontrol(vid_fig_hand.minusOneFrame);
        % call the callback
        minusOneFrame_Callback(vid_fig_hand.minusOneFrame,[]);
    elseif strcmp(eventdata.Modifier{:},'shift')
        % set focus to the button
        uicontrol(vid_fig_hand.minusTenFrame);
        % call the callback
        minusTenFrame_Callback(vid_fig_hand.minusTenFrame,[]);   end
end

curr_frame = get(vid_fig_hand.frameEdithandle, 'String');

if strcmp(eventdata.Key,'r')
    if isempty(eventdata.Modifier)
        % do nothing
    elseif strcmp(eventdata.Modifier{:},'shift')
        % call the callback
        set(vid_fig_hand.RowEditHdRCHONSET, 'String', curr_frame);   end
end

if strcmp(eventdata.Key,'s')
    if isempty(eventdata.Modifier)
        % do nothing
    elseif strcmp(eventdata.Modifier{:},'shift')
        % set focus to the button
        uicontrol(vid_fig_hand.logEventFrame);
        % call the callback
        logEventFrame_Callback(vid_fig_hand.logEventFrame,[]);   end
end

set(vid_fig_hand.vid_ax, 'XTick', []);
set(vid_fig_hand.vid_ax, 'YTick', []);

end

