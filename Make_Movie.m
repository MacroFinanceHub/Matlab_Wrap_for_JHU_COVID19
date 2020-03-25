function Make_Movie(app)
% Make_Movie(app)
% This function makes a movie of the spatial JHU data selected in the
% COVID19_Matlab_App (app).

Nt = size(app.DATA,2);

% Creates and opens a new movie file
k = 1;
while exist(['movies/',app.RegionDropDown.Value,'_',num2str(k),'.mp4'],'file')
    k=k+1;
end
vidObj = VideoWriter(['movies/',app.RegionDropDown.Value,'_',num2str(k),'.mp4'],'MPEG-4');
open(vidObj);

% Iterate through time
for j = Nt-30:Nt
    
    [~,cblab,ticklabs,K] = pop_out_map(app,j);

    hcb2 = colorbar('east');
    hcb2.Position([2,4]) = [0.6,0.3];
    set(get(hcb2,'Xlabel'),'String',cblab)
    set(hcb2,'Ticks',linspace(0,1,length(K)),'TickLabels',ticklabs)
    title(['Map of Pandemic (',app.map_what.Value,') on ',app.dates{j}]);

    drawnow
    currFrame = getframe(gcf);
    writeVideo(vidObj,currFrame);
end
close(vidObj);

