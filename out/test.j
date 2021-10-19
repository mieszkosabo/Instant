.class public Inc 
.super java/lang/Object

.method public <init>()V
   aload_0
   invokespecial java/lang/Object/<init>()V
   return
.end method

.method public static main([Ljava/lang/String;)V
.limit stack 1
    invokestatic Inc/test1()V
    return
.end method

.method public static test1()V
.limit stack 3
    getstatic java/lang/System/out Ljava/io/PrintStream;
    iconst_4
    iconst_3
    iadd
    iconst_2
    iadd
    iconst_1
    iadd
    
    invokevirtual java/io/PrintStream/println(I)V
    return
.end method
