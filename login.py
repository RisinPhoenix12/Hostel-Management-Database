import tkinter as tk
from tkinter import *
from tkinter import ttk
from hostel import *

class login:
    u='admin'
    p='qwerty1234'
    def __init__(self,rt):
        
        self.rt=rt
        self.rt.geometry('500x500')
        self.rt.title("Login Page")
       
        frame= LabelFrame(self.rt,width=200,bd=5,height=200)
        frame.pack(side=TOP,fill=BOTH,expand=TRUE)

        Label1=tk.Label(frame, text='Username:')
        Label2=tk.Label(frame, text='Password:')

        self.f1=tk.Entry(frame)
        self.f2=tk.Entry(frame,show='*')

        b1=Button(frame,text="Login",width=6,bg='#abcfd9',command=self.login_user)
        
        Label1.place(anchor=CENTER,relx=0.4,rely=0.3)
        Label2.place(anchor=CENTER,relx=0.4,rely=0.4)

        self.f1.place(anchor=CENTER,relx=0.6,rely=0.3)
        self.f2.place(anchor=CENTER,relx=0.6,rely=0.4)

        b1.place(anchor=CENTER,relx=0.5,rely=0.6)

    def login_user(self):
        if (self.f1.get() == self.u and self.f2.get() == self.p): #or (self.f1.get() == '' and self.f2.get() == ''):

            rt.destroy()
            nrt = tk.Tk()
            obj = hostels(nrt)
            nrt.mainloop()
        
        else:
            print('Wrong Credentials')
       
    
rt=tk.Tk()
rt.geometry("200x200")
obj= login(rt)
rt.mainloop()