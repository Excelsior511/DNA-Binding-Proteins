
outfile='div_pssm_example.txt';
num=2;
k=2;
aa='ARNDCQEGHILKMFPSTWYV';
fid1=fopen(outfile,'w');

for i=1:num
    
    seqfile=['.\seqs\','gi_',num2str(i),'.fa'];
    fid2=fopen(seqfile,'r');
    seqname=fgetl(fid2);
    seq=fgetl(fid2);
    len=length(seq);
    fclose(fid2);
    
    pssmfile=['.\pssm_files\','gi_',num2str(i),'.pssm'];
    
    indata=importdata(pssmfile);
    data1=indata.data;
    [p,q]=size(data1);
    pssm=data1(1:(p-5),1:20);
    
    output1=[];
    de=floor(len/k);
    for ii=1:k
        output = [];
        if(ii==k)
            str_cell{ii}=seq((ii-1)*de+1:end);
            dev_cell{ii}=pssm((ii-1)*de+1:end,:);
        else
            str_cell{ii}=seq((ii-1)*de+1:ii*de);
            dev_cell{ii}=pssm((ii-1)*de+1:ii*de,:);
        end 
        dev_cell{ii}=1./(1+exp(-dev_cell{ii}));
        dd=length(str_cell{ii});
        for j=1:20
            pos=strfind(str_cell{ii}(1:dd),aa(j));
            posdata=dev_cell{ii}(pos,:);
            if length(pos)==1
                d(1:20)=0;
                posdata=[posdata;d];   
            end
            t=sum(posdata);
            
            if length(pos)==0
                t(1:20)=0;
            end
            output=[output,t];
        end
        output1=[output1 output];   
    end
    
    fprintf(fid1,'%f ',output1);
    fprintf(fid1,'\n');
    
end
fclose(fid1);
