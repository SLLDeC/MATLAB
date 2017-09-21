function f_CierraIngka( ingka )

fprintf(ingka,'#0019\n')
fgetl(ingka);
fprintf(ingka,'#0003\n');
fgetl(ingka);
fprintf(ingka,'#0019\n')
fgetl(ingka);
fprintf(ingka,'#0011 0 \n')
fgetl(ingka);
fprintf(ingka,'#0011 2 \n')
fgetl(ingka);

fclose(ingka)
delete(ingka)
clear ingka

end

