function updateFrameFunction(FRAME, vid_obj)

global vid_fig_hand;


A = (vid_obj.structure(FRAME).cdata);

Aim = image(vid_fig_hand.vid_ax, A);
Aim.AlphaData = 0.90;

set(vid_fig_hand.frameEdithandle, 'String', num2str(FRAME));

title(vid_fig_hand.vid_ax, strcat('Frame Control: # ',num2str(FRAME)));

set(vid_fig_hand.vid_ax, 'XTick', []);
set(vid_fig_hand.vid_ax, 'YTick', []);


end