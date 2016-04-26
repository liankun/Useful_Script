#! /bin/bash
#create the general Module for coding
#MpcEx sorftware framwork
Module_Name="mMpcExCentrality"
#foward declation of class
FD_Class="
  PHCompositeNode   
"
#forwerd declation of class of container in topNode
FD_Class_CON="
  ZdcOut
  BbcOut
"

#additional head file in sourece conde
Head_File="
  getClass
  Fun4AllReturnCodes
  Fun4AllServer
  stdlib
"

#name space
Name_Space="
  std
  findNode
"

echo "Create the head file"
echo "#ifndef __${Module_Name^^}_HH__"    >  ${Module_Name}.h
echo "#define __${Module_Name^^}_HH__"    >> ${Module_Name}.h
#nessary SubsysReco 
echo " "                                  >> ${Module_Name}.h
echo "#ifndef __CINT__"                   >> ${Module_Name}.h
echo "#include <SubsysReco.h>"            >> ${Module_Name}.h
echo "#endif"                             >> ${Module_Name}.h
echo " "                                  >> ${Module_Name}.h

#class predeclare part
for i in ${FD_Class}
  do echo "class $i;"                      >> ${Module_Name}.h
done

for i in ${FD_Class_CON}
  do echo "class $i;"                      >> ${Module_Name}.h
done

echo " "                                   >> ${Module_Name}.h

#class define
#commom part
echo "class ${Module_Name}:public SubsysReco{"                      >> ${Module_Name}.h
echo "  public:"                                                    >> ${Module_Name}.h
echo "    ${Module_Name}(const char* name = \"${Module_Name^^}\");" >> ${Module_Name}.h
echo "    virtual int Init(PHCompositeNode*);"                      >> ${Module_Name}.h
echo "    virtual int InitRun(PHCompositeNode*);"                   >> ${Module_Name}.h
echo "    virtual int process_event(PHCompositeNode*);"             >> ${Module_Name}.h
echo "    virtual ~${Module_Name}();"                               >> ${Module_Name}.h
echo "    virtual int End(PHCompositeNode*);"                       >> ${Module_Name}.h
echo "  private:"                                                   >> ${Module_Name}.h
echo "    void set_interface_ptrs(PHCompositeNode*);"               >> ${Module_Name}.h
#container declare
for i in ${FD_Class_CON}
  do echo "    ${i} _${i};"                                         >> ${Module_Name}.h
done

echo " "                                                            >> ${Module_Name}.h
echo "  protected:"                                                 >> ${Module_Name}.h
echo "};"                                                           >> ${Module_Name}.h

echo "#endif /*__${Module_Name^^}_HH__*/" >> ${Module_Name}.h

#source code part
#head file
echo "Create Source file"
echo "#include \"${Module_Name}.h\""                          >${Module_Name}.C

#FD_Class head
for i in ${FD_Class}
  do echo "#include \"${i}.h\""                                 >> ${Module_Name}.C
done

#FD_Class_CON head
for i in ${FD_Class_CON}
  do echo "#include \"${i}.h\""                                 >> ${Module_Name}.C
done

#additional head file
for i in ${Head_File}
  do echo "#include \"${i}.h\""                                 >> ${Module_Name}.C
done

echo " "                                                        >> ${Module_Name}.C

#name space file
for i in ${Name_Space}
  do echo "using namespace ${i};"                               >> ${Module_Name}.C          
done

#constructer
echo " "                                                      >>${Module_Name}.C
echo "${Module_Name}::${Module_Name}(const char* name) :"     >>${Module_Name}.C
echo "  SubsysReco(name)"                                     >>${Module_Name}.C
echo "{"                                                      >>${Module_Name}.C

#initial for container
for i in ${FD_Class_CON}
  do echo "  _${i} = NULL;"                                   >>${Module_Name}.C
done

echo "}"                                                      >>${Module_Name}.C

echo "int ${Module_Name}::End(PHCompositeNode* topNode){"     >>${Module_Name}.C
echo "  return EVENT_OK;"                                     >>${Module_Name}.C
echo "}"                                                      >>${Module_Name}.C
echo " "                                                      >>${Module_Name}.C

#destructor
echo "${Module_Name}::~${Module_Name}(){"                     >>${Module_Name}.C
echo "}"                                                      >>${Module_Name}.C
echo " "                                                      >>${Module_Name}.C

echo "int ${Module_Name}::Init(PHCompositeNode* topNode){"    >>${Module_Name}.C
echo "  return EVENT_OK;"                                     >>${Module_Name}.C
echo "}"                                                      >>${Module_Name}.C
echo " "                                                      >>${Module_Name}.C

echo "int ${Module_Name}::InitRun(PHCompositeNode* topNode){" >>${Module_Name}.C 
echo "  set_interface_ptrs(topNode);"                         >>${Module_Name}.C
echo "  return EVENT_OK;"                                     >>${Module_Name}.C
echo "}"                                                      >>${Module_Name}.C

echo "void ${Module_Name}::set_interface_ptrs(PHCompositeNode* topNode){" >>${Module_Name}.C
#get node in topnode
for i in ${FD_Class_CON}
  do 
   echo "  _${i} = getClass<${i}>(topNode,\"${i}\");"                    >>${Module_Name}.C
   echo "  if(!_${i}){"                                                  >>${Module_Name}.C
   echo "    cout <<\"No ${i} !!!\"<<endl;"                              >>${Module_Name}.C
   echo "    exit(1);"                                                   >>${Module_Name}.C
   echo "  }"                                                            >>${Module_Name}.C 
done

echo "}"                                                                 >>${Module_Name}.C

echo "int ${Module_Name}::process_event(PHCompositeNode* topNode){"  >>${Module_Name}.C
echo "  return EVENT_OK;"                                           >>${Module_Name}.C
echo "}"                                                            >>${Module_Name}.C


