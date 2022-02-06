function plot_policy(act,grid_size)

axis([1 grid_size 1 grid_size]);
axis ij;
for k=1:(grid_size-1)/grid_size:grid_size
    gridxy([1 k]);
    gridxy([],[1 k]);
end
hold on

k=1:(grid_size-1)/grid_size:grid_size;
arrow_len = (grid_size-1)/(2*grid_size);
a=k+arrow_len;
b=k+arrow_len;

for i=1:grid_size
    for j=1:grid_size        
        if act(j,i)==1
            plot_arrow(a(i),b(j),a(i),b(j)-arrow_len,'linewidth',2,'headwidth',0.25,'headheight',0.33 );            
            hold on
        elseif act(j,i)==2
            plot_arrow(a(i),b(j),a(i),b(j)+arrow_len,'linewidth',2,'headwidth',0.25,'headheight',0.33 );
            hold on
        elseif act(j,i)==3
            plot_arrow(a(i),b(j),a(i)+arrow_len,b(j),'linewidth',2,'headwidth',0.25,'headheight',0.33 );
            hold on
        elseif act(j,i)==4
            plot_arrow(a(i),b(j),a(i)-arrow_len,b(j),'linewidth',2,'headwidth',0.25,'headheight',0.33 );
            hold on
        elseif act(j,i)==5
            plot(a(i),b(j),'r*');
            hold on
        end
    end
end
