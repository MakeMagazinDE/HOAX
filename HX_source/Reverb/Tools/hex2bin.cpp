
Area : �奬�

Date : Sat May 29, 21:14                                                       
From : Valery Grazdankin                                       2:5058/41
To   : Nikolai Chernomorov                 
Subj : bidipro                                                               
��������������������������������������������������������������������������������

* ⠪�� ��᫠�� � VG.ARCHIVE
�p���� Nikolai!

28 ��� 99 10:50, Nikolai Chernomorov -> Eduard Panchenko:

 NC>  � ����⢥ ���� - ������� �뫮 �� ᤥ���� �����p�p HEX -> BIN �
 NC> ��p�⭮.

�y���, ᮡ�p���, ��� ���p�� ����. � ���� ᮡp�� ��� DOS,WIN32,OS2,Linux
��室��� ���� �y�� ����p�����?
========================================================================
/*
     �p���p�������� 䠩�� �p��� HEX � ������ 䠩� ��p��� �p�訢�� ���
     �᫨ ��室��� 䠩� �� �y���y�� -- �� ᮧ������,
     �᫨ �y���y�� - �� ��pp���py���� �� ᮮ⢥���y�騬 ��p�ᠬ �
ᮮ⢥��⢨�
     � ᮤ�p���� �室���� 䠩��

     (c) V.Grazdankin, 1999
 */

#ifndef OS
#  define OS "DOS"
#endif

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>


#define  EXIT_FAIL 255

char
     IName[256],       /* ��� �室���� 䠩�� */
     OName[256];       /* ��� ��室���� 䠩�� */
long Addr=0;

/*
 * �����p �p�y���⮢ ��������� ��p���
 */
void ParseArgs(int argc, char * argv[]){
    int i=0;

    while (i<argc){
       if (argv[i][0]=='-' || argv[i][0]=='/'){
          switch (tolower(argv[i][1])){
          case '?':printf("Parameters:\n"
                          "-? Help screen\n"
                          "-i input .HEX file\n"
                          "-o output patched .BIN ROM dump\n"
                          "-a begin address of ROM (0x???? - hex value)\n"
                          );
                   exit(EXIT_FAIL);
                   break;
          case 'i':i++;
                   if (i<argc) {
                       strcpy(IName, argv[i]);
                   }
                   break;
          case 'o':i++;
                   if (i<argc) {
                       strcpy(OName, argv[i]);
                   }
                   break;
          case 'a':i++;
                   if (i<argc) {
                       sscanf(argv[i],"%i",&Addr);
                   }
                   break;
          default: printf("Unknown option: '%s'\n", argv[i]);
                   exit(EXIT_FAIL);
          }
       }
       i++;
    }
    return;
}


/*
 *  ������� ����
 */


int main (int argc, char *argv[])
{
   long i, i1;
   long b;
   FILE *fi, *fo;
   char s[256];
   long cnt,adr,tr;

   printf("hex2rom v.1.0 for "OS", compiled "__DATE__", "__TIME__"\n"
          "dump .Hex file to binary ROM image or \n"
          "update ROM image by .Hex dump (if -o file exist)\n"
          "(c) V.Grazdankin, Orenburg, Russia, 1999\n");
   if (argc<=1) {
      printf("use -? for help\n");
   } else {
      ParseArgs(argc, argv);
      fi=fopen(IName,"r");
      if (fi!=NULL){
          fo=fopen(OName,"r+b");
          if (fo==NULL) {fo=fopen(OName,"w+b");}
          if (fo!=NULL){
             while (!feof(fi)){
                fscanf(fi,":%02lX%04lX%02lX%s\n",&cnt,&adr,&tr,s);
                if (tr==0){
                   if (adr<Addr) {
                       printf("!error offset %04X\n",adr);
                   } else {
                      i1=fseek(fo, (adr-Addr), SEEK_SET);
                      for (i=1;i<=cnt;i++){
                         b=0;
                         sscanf(s,"%02lX%s",&b,s);
                         i1=fwrite(&b, 1, 1, fo);
/*                         printf("%i ",i1);*/
                      }
                   }
                }
             }
             fclose(fo);
             printf("OK\n");
          } else printf("!error open %s\n",OName);
          fclose(fi);
      } else printf("!error open %s\n",IName);
   }
   return 0;
}


========================================================================

 NC>            �� ᨬ �p�����. ��p����p�� ������.


� y��������, _���p�_VAG_.

--- GoldED/2 3.0.1
 * Origin: White Hole (2:5058/41)
