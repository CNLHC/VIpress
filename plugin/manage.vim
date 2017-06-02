python <<EOF
#coding:u8
import os
def Is_Formatted_file(fp):
    '''
    To judge whether a File is fomatted blog file or not
    TIPS:Change This Function if the format changed
    '''
    t_page=fp.readlines()
    try:
        if not 'Meta' in t_page[0]:
            return False
        else:
            return True
    except:
        return False
def Blogart_get_artinfo(fp):
    '''
    get the str id from a formatted file
    TIPS:Change This Function if the format changed
    '''
    out=[]
    t_page=fp.readlines()
    ID=(t_page[1].split(':'))[-1].replace(' ','').replace('\n','')
    Title=(t_page[2].split(':'))[-1].replace(' ','').replace('\n','')
    cat=(t_page[3].split(':'))[-1].replace(' ','').replace('\n','')
    out.append(ID)
    out.append(Title)
    out.append(cat)
    return out
def Blogm_Clean():
    '''
    整理文件夹内的文件:
    '''
    for Dir in File_List:
        if not os.path.isdir(Path_Root+Dir):
            continue
        else:  
           t_Path_Art=Path_Root+Dir+'/'
           t_Art_List=os.listdir(t_Path_Art)
           for Title in t_Art_List:
               t_fp=open(t_Path_Art+Title,'r')
               if not Is_Formatted_file(t_fp):
                   os.rename(t_Path_Art+Title,Path_Root+'Unclassified/'+Title)
               t_fp=open(t_Path_Art+Title,'r')
               info=Blogart_get_artinfo(t_fp)
               t_name='%s-%s'%(info[0],info[1])
               os.rename(t_Path_Art+Title,t_Path_Art+t_name)
def Blogm_reClassify():
    t_workpath=Path_Root+'Unclassified/'
    t_File_List=os.listdir(t_workpath)
    for Title in t_File_List:
        t_fp=open(t_workpath+Title,'r')
        if not Is_Formatted_file(t_fp):
            t_fp.close()
            continue
        t_fp=open(t_workpath+Title,'r')
        info=Blogart_get_artinfo(t_fp)
        if len(info[2])>0:
            if os.path.isdir(Path_Root+info[2]):
                os.rename(t_workpath+Title,Path_Root+info[2]+'/'+Title)
            print info[0],info[1],info[2]
			#Path_Root=os.getcwd()+'/'
			#File_List=os.listdir(Path_Root)
			#File_List=list(File_List)
			#try:
			#    File_List.remove('Unclassified')
			#    File_List.remove('IMG')
			#except:
			#    os.mkdir(Path_Root+'Unclassified')
EOF


           
            
