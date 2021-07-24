import tkinter as tk
import mysql.connector
from tkinter import *
from tkinter import ttk

class hostels:

    def __init__(self,root):
        self.root=root
        self.root.geometry('500x500')
        self.root.title('Hostel Management')

        b1 = Button(self.root, text="Student",width=20,height=5,bg='#abcfd9', command=self.istud)
        b2 = Button(self.root, text="Employee",width=20,height=5,bg='#abcfd9', command=self.iemp)
        b3 = Button(self.root, text="Complaint",width=20,height=5,bg='#abcfd9', command=self.icomp)
        b4 = Button(self.root, text="Gate Record",width=20,height=5,bg='#abcfd9', command=self.igr)

        b1.place(anchor=CENTER,relx=0.3,rely=0.3)
        b2.place(anchor=CENTER,relx=0.7,rely=0.3)
        b3.place(anchor=CENTER,relx=0.3,rely=0.6)
        b4.place(anchor=CENTER,relx=0.7,rely=0.6)

        config = {
        'user': 'root',
        'password': 'qwerty1234',
        'host': 'localhost',
        'database': 'hosteldb',
        'raise_on_warnings': True,
        }
        self.cnx = mysql.connector.connect(**config)

        self.root.mainloop()

    ####################  STUDENT  #################### 
    def istud(self):

        def add_stud():
            
            name=f1.get()
            rn=f2.get()
            dob=f3.get()
            g=f4.get()
            add=f5.get()
            mbno=f6.get()
            yr=f7.get()
            br=f8.get()
            hid=f9.get()
            ft=f10.get()
            rm=f11.get()
            c=self.cnx.cursor()
            c.execute('INSERT INTO `student` VALUES(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)',
            (name,rn,dob,g,add,mbno,yr,br,hid,ft,rm))
            c.close()
            self.cnx.commit()
            
        def search_stud():

            if (len(f1.get())!=0):
                nm=f1.get()
                # print(nm)
                c=self.cnx.cursor()
                q="SELECT * FROM STUDENT WHERE name='"+nm+"';"
                c.execute(q)
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()
                
            elif(len(f2.get())!=0):
                nm=f2.get()
                # print(nm)
                c=self.cnx.cursor()
                q="SELECT * FROM STUDENT WHERE roll_no="+nm+";"
                c.execute(q)
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()
                
            elif(len(f9.get())!=0):
                nm=f9.get()
                # print(nm)
                c=self.cnx.cursor()
                q="SELECT * FROM STUDENT WHERE hostel_id="+nm+";"
                c.execute(q)
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()

        def show_stud():
            if (len(f12.get())==0):
                c=self.cnx.cursor()
                c.execute("SELECT * FROM student")
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()
            elif(f12.get()=='Yes'):
                c=self.cnx.cursor()
                c.execute("SELECT * FROM failed_student")
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()
          
        def update_stud():

            if(f12.get()=='Yes'):
                rn=f2.get()
                c=self.cnx.cursor()
                c.callproc("fail",(rn,))
                c.close()
                self.cnx.commit()

            elif(f12.get()=="No"):
                c=self.cnx.cursor()
                c.callproc("forward",(1,))
                c.close()
                self.cnx.commit()
    
        def clear_stud():
            for i in tree.get_children():
                tree.delete(i)
            l=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11]
            for i in l:
                i.delete(0,END)

        def delete_stud():
            rn=f2.get()
            c=self.cnx.cursor()
            q="DELETE FROM STUDENT WHERE roll_no="+rn+";"
            c.execute(q)
            c.close()
            self.cnx.commit()

        def getvalue(event):
            l=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11]
            for i in l:
                i.delete(0,END)
            s=tree.selection()
            #print(s)
            # l1=[]
            a=tree.item(s)
            #print(a)
            l1=a['values']
            #print(l1)
            for i in range(len(l)):
                l[i].insert(0,l1[i])

        #New window
        nw=tk.Tk()
        nw.geometry('750x750')
        nw.title("Student")
        upperframe=Frame(nw,width=500,bd=5,height=80)
        lowerframe=Frame(nw,width=200,bd=5,height=445)
        upperframe.pack(side=TOP,fill=BOTH,expand=TRUE)
        lowerframe.pack(side=TOP,fill=BOTH,expand=TRUE)
        
        #Tree
        tree=ttk.Treeview(lowerframe)
        tree.pack(side=TOP)
        tree['columns']=("name","roll_no","dob","gender","address","contact_no","year","branch","hostel_id","flat","room")
        tree.column("#0",width=0)
        tree.column("name",anchor=CENTER,width="120")
        tree.column("roll_no",anchor=CENTER,width="100")
        tree.column("dob",anchor=CENTER,width="100")
        tree.column("gender",anchor=CENTER,width="100")
        tree.column("address",anchor=CENTER,width="120")
        tree.column("contact_no",anchor=CENTER,width="100")
        tree.column("year",anchor=CENTER,width="100")
        tree.column("branch",anchor=CENTER,width="100")
        tree.column("hostel_id",anchor=CENTER,width="100")
        tree.column("flat",anchor=CENTER,width="80")
        tree.column("room",anchor=CENTER,width="120")
        tree.heading("#0",text='')
        tree.heading("name",text="Name",anchor=CENTER)
        tree.heading("roll_no",text="Roll No",anchor=CENTER)
        tree.heading("dob",text="DOB",anchor=CENTER)
        tree.heading("gender",text="Gender",anchor=CENTER)
        tree.heading("address",text="Address",anchor=CENTER)
        tree.heading("contact_no",text="Contact No",anchor=CENTER)
        tree.heading("year",text="Year",anchor=CENTER)
        tree.heading("branch",text="Branch",anchor=CENTER)
        tree.heading("hostel_id",text="Hostel ID",anchor=CENTER)
        tree.heading("flat",text="Flat",anchor=CENTER)
        tree.heading("room",text="Room",anchor=CENTER)
        
        #tree.insert(parent='',index='end',iid=0,text='',values=('a',1,'1990-01-01','f','a',1,'1','cse',1,101,'a'))

        tree.bind('<Double-Button-1>',getvalue)

        #labels
        label1 = tk.Label(upperframe, text="Name: ")
        label2 = tk.Label(upperframe, text="Roll no: ")
        label3 = tk.Label(upperframe, text="DOB: ")
        label4 = tk.Label(upperframe,text="Gender:")
        label5 = tk.Label(upperframe,text="Address:")
        label6 = tk.Label(upperframe,text="Contact number:")
        label7 = tk.Label(upperframe,text="Year:")
        label8 = tk.Label(upperframe, text="Branch:")
        label9 = tk.Label(upperframe,text="Hostel ID:")
        label10 = tk.Label(upperframe,text="Flat:")
        label11 = tk.Label(upperframe,text="Room:")
        label12 = tk.Label(upperframe,text="Fail*:")

        #entries
        f1 = tk.Entry(upperframe)
        f2 = tk.Entry(upperframe)
        f3 = tk.Entry(upperframe)
        f4 = tk.Entry(upperframe)
        f5 = tk.Entry(upperframe)
        f6 = tk.Entry(upperframe)
        f7 = tk.Entry(upperframe)
        f8 = tk.Entry(upperframe)
        f9 = tk.Entry(upperframe)
        f10 = tk.Entry(upperframe)
        f11 = tk.Entry(upperframe)
        f12 = tk.Entry(upperframe)
        
        #Buttons
        b1 = Button(upperframe, text="Add",width=6, command=add_stud)
        b2 = Button(upperframe, text="Search",width=6, command=search_stud)
        b3 = Button(upperframe, text="Show",width=6, command=show_stud)
        b4 = Button(upperframe, text="Update",width=6, command=update_stud)
        b5 = Button(upperframe, text="Clear",width=6, command=clear_stud)
        b6 = Button(upperframe, text="Delete",width=6, command=delete_stud)
        
        #Grid
        label1.place(anchor=CENTER,relx=0.2,rely=0.125)
        label2.place(anchor=CENTER,relx=0.6,rely=0.125)
        label3.place(anchor=CENTER,relx=0.2,rely=0.25)
        label4.place(anchor=CENTER,relx=0.6,rely=0.25)
        label5.place(anchor=CENTER,relx=0.2,rely=0.375)
        label6.place(anchor=CENTER,relx=0.6,rely=0.375)
        label7.place(anchor=CENTER,relx=0.2,rely=0.5)
        label8.place(anchor=CENTER,relx=0.6,rely=0.5)
        label9.place(anchor=CENTER,relx=0.2,rely=0.625)
        label10.place(anchor=CENTER,relx=0.6,rely=0.625)
        label11.place(anchor=CENTER,relx=0.2,rely=0.75)
        label12.place(anchor=CENTER,relx=0.6,rely=0.75)

        f1.place(anchor=CENTER,relx=0.4,rely=0.125)
        f2.place(anchor=CENTER,relx=0.8,rely=0.125)
        f3.place(anchor=CENTER,relx=0.4,rely=0.25)
        f4.place(anchor=CENTER,relx=0.8,rely=0.25)
        f5.place(anchor=CENTER,relx=0.4,rely=0.375)
        f6.place(anchor=CENTER,relx=0.8,rely=0.375)
        f7.place(anchor=CENTER,relx=0.4,rely=0.5)
        f8.place(anchor=CENTER,relx=0.8,rely=0.5)
        f9.place(anchor=CENTER,relx=0.4,rely=0.625)
        f10.place(anchor=CENTER,relx=0.8,rely=0.625)
        f11.place(anchor=CENTER,relx=0.4,rely=0.75)
        f12.place(anchor=CENTER,relx=0.8,rely=0.75)

        b1.place(anchor=CENTER,relx=0.25,rely=0.875)
        b2.place(anchor=CENTER,relx=0.5,rely=0.875)
        b3.place(anchor=CENTER,relx=0.75,rely=0.875)
        b4.place(anchor=CENTER,relx=0.25,rely=0.97)
        b5.place(anchor=CENTER,relx=0.5,rely=0.97)
        b6.place(anchor=CENTER,relx=0.75,rely=0.97)

        nw.mainloop()
    



    ####################  EMPLOYEE  #################### 
    def iemp(self):

        def add_emp():

            name=f1.get()
            eid=f2.get()
            dob=f3.get()
            g=f4.get()
            add=f5.get()
            mbno=f6.get()
            dsg=f7.get()
            hid=f8.get()

            c=self.cnx.cursor()
            c.execute("""INSERT INTO employee (`name`, `employee_id`, `dob`, `gender`, `address`,`contact_no`,  `designation`, `hostel_id`) 
                VALUES (""" + "%s,"*7 +"%s);",
            (name,eid,dob,g,add,mbno,dsg,hid))
            c.close()
            self.cnx.commit()

        def search_emp():

            if (len(f1.get())!=0):
                nm=f1.get()
                # print(nm)
                c=self.cnx.cursor()
                q="SELECT * FROM EMPLOYEE WHERE name='"+nm+"';"
                c.execute(q)
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()
                
            elif(len(f2.get())!=0):
                eid=f2.get()
                # print(nm)
                c=self.cnx.cursor()
                q="SELECT * FROM EMPLOYEE WHERE employee_id="+eid+";"
                c.execute(q)
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()
                
            elif(len(f8.get())!=0):
                hid=f8.get()
                # print(nm)
                c=self.cnx.cursor()
                q="SELECT * FROM EMPLOYEE WHERE hostel_id="+hid+";"
                c.execute(q)
                f=c.fetchall()
                for i in tree.get_children():
                    tree.delete(i)
                for i in range(len(f)):
                    tree.insert(parent='',index='end',iid=i,text='',values=f[i])
                nw.mainloop()

        def show_emp():
            c=self.cnx.cursor()
            c.execute("SELECT * FROM employee")
            f=c.fetchall()
            for i in tree.get_children():
                tree.delete(i)
            for i in range(len(f)):
                tree.insert(parent='',index='end',iid=i,text='',values=f[i])
            c.close()
            nw.mainloop()

        def update_emp():
            if(len(f9.get())!=0):
                eid=f2.get()
                dt=f9.get()
                c=self.cnx.cursor()
                q="UPDATE EMPLOYEE SET termination_date='"+dt+"' WHERE employee_id="+eid+";"
                c.execute(q)
                self.cnx.commit()
            else:
                name=f1.get()
                eid=f2.get()
                dob=f3.get()
                g=f4.get()
                add=f5.get()
                mbno=f6.get()
                dsg=f7.get()
                hid=f8.get()
                c=self.cnx.cursor()
                c.execute("UPDATE EMPLOYEE SET name=%s,dob=%s,gender=%s,address=%s,contact_no=%s,designation=%s,hostel_id=%s WHERE employee_id=%s",
                (name,dob,g,add,mbno,dsg,hid,eid))
                self.cnx.commit()

        def clear_emp():
            for i in tree.get_children():
                tree.delete(i)
            l=[f1,f2,f3,f4,f5,f6,f7,f8,f9]
            for i in l:
                i.delete(0,END)
            nw.mainloop()

        def delete_emp():
            eid=f2.get()
            c=self.cnx.cursor()
            q="DELETE FROM EMPLOYEE WHERE employee_id="+eid+";"
            c.execute(q)
            c.close()
            self.cnx.commit()

        def getvalue(event):
            l=[f1,f2,f3,f4,f5,f6,f7,f8,f9]
            for i in l:
                i.delete(0,END)
            s=tree.selection()
            #print(s)
            # l1=[]
            a=tree.item(s)
            #print(a)
            l1=a['values']
            #print(l1)
            l[0].insert(0,l1[0])
            l[1].insert(0,l1[1])
            l[2].insert(0,l1[2])
            l[3].insert(0,l1[3])
            l[4].insert(0,l1[4])
            l[5].insert(0,l1[5])
            l[6].insert(0,l1[8])
            l[7].insert(0,l1[9])
            l[8].insert(0,l1[7])


        #New window
        nw=tk.Tk()
        nw.geometry('900x900')
        nw.title("Employee")
        upperframe=Frame(nw,width=500,bd=5,height=80)
        lowerframe=Frame(nw,width=200,bd=5,height=445)
        upperframe.pack(side=TOP,fill=BOTH,expand=TRUE)
        lowerframe.pack(side=TOP,fill=BOTH,expand=TRUE)

        #Tree
        tree=ttk.Treeview(lowerframe)
        tree.pack(side=TOP)
        tree['columns']=("name","eid","dob","gender","address","contact_no","doj","td","designation","hostel_id","salary")
        tree.column("#0",width=0)
        tree.column("name",anchor=CENTER,width="120")
        tree.column("eid",anchor=CENTER,width="100")
        tree.column("dob",anchor=CENTER,width="100")
        tree.column("gender",anchor=CENTER,width="100")
        tree.column("address",anchor=CENTER,width="120")
        tree.column("contact_no",anchor=CENTER,width="100")
        tree.column("doj",anchor=CENTER,width="100")
        tree.column("td",anchor=CENTER,width="100")
        tree.column("designation",anchor=CENTER,width="100")
        tree.column("hostel_id",anchor=CENTER,width="100")
        tree.column("salary",anchor=CENTER,width="100")
        tree.heading("#0",text='')
        tree.heading("name",text="Name",anchor=CENTER)
        tree.heading("eid",text="Employee ID",anchor=CENTER)
        tree.heading("dob",text="DOB",anchor=CENTER)
        tree.heading("gender",text="Gender",anchor=CENTER)
        tree.heading("address",text="Address",anchor=CENTER)
        tree.heading("contact_no",text="Contact No",anchor=CENTER)
        tree.heading("doj",text="Date of joining",anchor=CENTER)
        tree.heading("td",text="Termination date",anchor=CENTER)
        tree.heading("designation",text="designation",anchor=CENTER)
        tree.heading("hostel_id",text="Hostel ID",anchor=CENTER)
        tree.heading("salary",text="Salary",anchor=CENTER)
        tree.bind('<Double-Button-1>',getvalue)
        #tree.insert(parent='',index='end',iid=0,text='',values=('a',1,'1990-01-01','f','a',1,'1990-02-03','2020-12-06','warden',1,1500))
       
        #labels
        label1 = tk.Label(upperframe, text="Name: ")
        label2 = tk.Label(upperframe, text="Employee ID: ")
        label3 = tk.Label(upperframe, text="DOB: ")
        label4 = tk.Label(upperframe,text="Gender:")
        label5 = tk.Label(upperframe,text="Address:")
        label6 = tk.Label(upperframe,text="Contact number:")
        label7 = tk.Label(upperframe,text="Designation:")
        label8 = tk.Label(upperframe,text="Hostel ID:")
        label9 = tk.Label(upperframe,text="Termination Date*:")

        #entries
        f1 = tk.Entry(upperframe)
        f2 = tk.Entry(upperframe)
        f3 = tk.Entry(upperframe)
        f4 = tk.Entry(upperframe)
        f5 = tk.Entry(upperframe)
        f6 = tk.Entry(upperframe)
        f7 = tk.Entry(upperframe)
        f8 = tk.Entry(upperframe)
        f9 = tk.Entry(upperframe)
        
        #Buttons
        b1 = Button(upperframe, text="Add",width=6,command=add_emp)
        b2 = Button(upperframe, text="Search",width=6,command=search_emp)
        b3 = Button(upperframe, text="Show",width=6,command=show_emp)
        b4 = Button(upperframe, text="Update",width=6,command=update_emp)
        b5 = Button(upperframe, text="Clear",width=6,command=clear_emp)
        b6 = Button(upperframe, text="Delete",width=6,command=delete_emp)
        
        #Grid
        label1.place(anchor=CENTER,relx=0.2,rely=0.125)
        label2.place(anchor=CENTER,relx=0.6,rely=0.125)
        label3.place(anchor=CENTER,relx=0.2,rely=0.25)
        label4.place(anchor=CENTER,relx=0.6,rely=0.25)
        label5.place(anchor=CENTER,relx=0.2,rely=0.375)
        label6.place(anchor=CENTER,relx=0.6,rely=0.375)
        label7.place(anchor=CENTER,relx=0.2,rely=0.5)
        label8.place(anchor=CENTER,relx=0.6,rely=0.5)
        label9.place(anchor=CENTER,relx=0.2,rely=0.625)

        f1.place(anchor=CENTER,relx=0.4,rely=0.125)
        f2.place(anchor=CENTER,relx=0.8,rely=0.125)
        f3.place(anchor=CENTER,relx=0.4,rely=0.25)
        f4.place(anchor=CENTER,relx=0.8,rely=0.25)
        f5.place(anchor=CENTER,relx=0.4,rely=0.375)
        f6.place(anchor=CENTER,relx=0.8,rely=0.375)
        f7.place(anchor=CENTER,relx=0.4,rely=0.5)
        f8.place(anchor=CENTER,relx=0.8,rely=0.5)
        f9.place(anchor=CENTER,relx=0.4,rely=0.625)

        b1.place(anchor=CENTER,relx=0.25,rely=0.75)
        b2.place(anchor=CENTER,relx=0.5,rely=0.75)
        b3.place(anchor=CENTER,relx=0.75,rely=0.75)
        b4.place(anchor=CENTER,relx=0.25,rely=0.875)
        b5.place(anchor=CENTER,relx=0.5,rely=0.875)
        b6.place(anchor=CENTER,relx=0.75,rely=0.875)

        nw.mainloop()

    ####################  COMPLAINT #################### 
    def icomp(self):

        def add_comp():
        
            rn=f2.get()
            dsc=f3.get()
            c=self.cnx.cursor()
            c.execute('INSERT INTO complaint(roll_no,description) VALUES(%s,%s)',
            (rn,dsc))
            c.close()
            self.cnx.commit()
            #print('Value Inserted')
        
        def search_comp():

            rn=f2.get()
            # print(nm)
            c=self.cnx.cursor()
            q="SELECT * FROM COMPLAINT WHERE roll_no='"+rn+"';"
            c.execute(q)
            f=c.fetchall()
            for i in tree.get_children():
                tree.delete(i)
            for i in range(len(f)):
                tree.insert(parent='',index='end',iid=i,text='',values=f[i])
            nw.mainloop()

        def show_comp():

            c=self.cnx.cursor()
            c.execute("SELECT * FROM complaint")
            f=c.fetchall()
            for i in tree.get_children():
                tree.delete(i)
            for i in range(len(f)):
                tree.insert(parent='',index='end',iid=i,text='',values=f[i])
            c.close()
            nw.mainloop()

        def update_comp():
            if(len(f5.get())!=0):
                cid=f1.get()
                rn=f2.get()
                dt=f5.get()
                c=self.cnx.cursor()
                q="UPDATE COMPLAINT SET resolved_date='"+dt+"' WHERE complaint_id="+cid+" AND roll_no="+rn+";"
                c.execute(q)
                self.cnx.commit()

        def clear_comp():
            for i in tree.get_children():
                tree.delete(i)
            l=[f1,f2,f3,f4,f5]
            for i in l:
                i.delete(0,END)
            nw.mainloop()

        def delete_comp():
            cid=f1.get()
            rn=f2.get()
            c=self.cnx.cursor()
            q="DELETE FROM COMPLAINT WHERE complaint_id="+cid+" AND roll_no="+rn+";"
            #print(q)
            c.execute(q)
            c.close()
            self.cnx.commit()

        def getvalue(event):
            l=[f1,f2,f3,f4,f5]
            for i in l:
                i.delete(0,END)
            s=tree.selection()
            #print(s)
            # l1=[]
            a=tree.item(s)
            #print(a)
            l1=a['values']
            #print(l1)
            for i in range(len(l)):
                l[i].insert(0,l1[i])

        #New window
        nw=tk.Tk()
        nw.geometry('900x900')
        nw.title("Complaint")
        upperframe=Frame(nw,width=500,bd=5,height=80)
        lowerframe=Frame(nw,width=200,bd=5,height=445)
        upperframe.pack(side=TOP,fill=BOTH,expand=TRUE)
        lowerframe.pack(side=TOP,fill=BOTH,expand=TRUE)

        #Tree
        tree=ttk.Treeview(lowerframe)
        tree.pack(side=TOP)
        tree['columns']=("cid","roll_no","description","registered_date","resolved_date")
        tree.column("#0",width=0)
        tree.column("cid",anchor=CENTER,width="120")
        tree.column("roll_no",anchor=CENTER,width="100")
        tree.column("description",anchor=CENTER,width="100")
        tree.column("registered_date",anchor=CENTER,width="100")
        tree.column("resolved_date",anchor=CENTER,width="120")
        tree.heading("#0",text='')
        tree.heading("cid",text="Complaint ID",anchor=CENTER)
        tree.heading("roll_no",text="Roll No",anchor=CENTER)
        tree.heading("description",text="Description",anchor=CENTER)
        tree.heading("registered_date",text="Registered Date",anchor=CENTER)
        tree.heading("resolved_date",text="Resolved Date",anchor=CENTER)
        tree.bind('<Double-Button-1>',getvalue)
        #tree.insert(parent='',index='end',iid=0,text='',values=(1,5,'Housekeeping','2017-11-21',None))
       
        #labels
        label1 = tk.Label(upperframe, text="Complaint ID*: ")
        label2 = tk.Label(upperframe, text="Roll No: ")
        label3 = tk.Label(upperframe, text="Description: ")
        label4 = tk.Label(upperframe,text="Registered Date*:")
        label5 = tk.Label(upperframe,text="Resolved Date*:")

        #entries
        f1 = tk.Entry(upperframe)
        f2 = tk.Entry(upperframe)
        f3 = tk.Entry(upperframe)
        f4 = tk.Entry(upperframe)
        f5 = tk.Entry(upperframe)
        
        #Buttons
        b1 = Button(upperframe, text="Add",width=6,command=add_comp)
        b2 = Button(upperframe, text="Search",width=6,command=search_comp)
        b3 = Button(upperframe, text="Show",width=6,command=show_comp)
        b4 = Button(upperframe, text="Update",width=6,command=update_comp)
        b5 = Button(upperframe, text="Clear",width=6,command=clear_comp)
        b6 = Button(upperframe, text="Delete",width=6,command=delete_comp)
        
        #Grid
        label1.place(anchor=CENTER,relx=0.2,rely=0.125)
        label2.place(anchor=CENTER,relx=0.6,rely=0.125)
        label3.place(anchor=CENTER,relx=0.2,rely=0.25)
        label4.place(anchor=CENTER,relx=0.6,rely=0.25)
        label5.place(anchor=CENTER,relx=0.2,rely=0.375)

        f1.place(anchor=CENTER,relx=0.4,rely=0.125)
        f2.place(anchor=CENTER,relx=0.8,rely=0.125)
        f3.place(anchor=CENTER,relx=0.4,rely=0.25)
        f4.place(anchor=CENTER,relx=0.8,rely=0.25)
        f5.place(anchor=CENTER,relx=0.4,rely=0.375)

        b1.place(anchor=CENTER,relx=0.25,rely=0.625)
        b2.place(anchor=CENTER,relx=0.5,rely=0.625)
        b3.place(anchor=CENTER,relx=0.75,rely=0.625)
        b4.place(anchor=CENTER,relx=0.25,rely=0.75)
        b5.place(anchor=CENTER,relx=0.5,rely=0.75)
        b6.place(anchor=CENTER,relx=0.75,rely=0.75)

        nw.mainloop()
    
    ####################  GATE RECORD #################### 
    def igr(self):

        def add_gr():

            rn=f1.get()
            prp=f2.get()

            c=self.cnx.cursor()
            c.execute('INSERT INTO gate_record(roll_no,purpose) VALUES(%s,%s)',
            (rn,prp))
            c.close()
            self.cnx.commit()
            #print('Value Inserted')

        def search_gr():

            rn=f1.get()
            # print(nm)
            c=self.cnx.cursor()
            q="SELECT * FROM GATE_RECORD WHERE roll_no='"+rn+"';"
            c.execute(q)
            f=c.fetchall()
            for i in tree.get_children():
                tree.delete(i)
            for i in range(len(f)):
                tree.insert(parent='',index='end',iid=i,text='',values=f[i])
            nw.mainloop()

        def show_gr():

            c=self.cnx.cursor()
            c.execute("SELECT * FROM gate_record;")
            f=c.fetchall()
            for i in tree.get_children():
                tree.delete(i)
            for i in range(len(f)):
                tree.insert(parent='',index='end',iid=i,text='',values=f[i])
            c.close()
            nw.mainloop()

        def update_gr():
            
            rn=f1.get()
            c=self.cnx.cursor()
            c.callproc("gate_record_in",(rn,))
            self.cnx.commit()

        def clear_gr():
            for i in tree.get_children():
                tree.delete(i)
            l=[f1,f2,f3,f4]
            for i in l:
                i.delete(0,END)
            nw.mainloop()

        def delete_gr():
            rn=f1.get()
            et=f4.get()
            c=self.cnx.cursor()
            q="DELETE FROM GATE_RECORD WHERE roll_no="+rn+" AND exit_time='"+et+"';"
            #print(q)
            c.execute(q)
            c.close()
            self.cnx.commit()

        def getvalue(event):
            l=[f1,f2,f3,f4]
            for i in l:
                i.delete(0,END)
            s=tree.selection()
            #print(s)
            # l1=[]
            a=tree.item(s)
            #print(a)
            l1=a['values']
            #print(l1)
            for i in range(len(l)):
                l[i].insert(0,l1[i])

        #New window
        nw=tk.Tk()
        nw.geometry('900x900')
        nw.title("Gate Record")
        upperframe=Frame(nw,width=500,bd=5,height=80)
        lowerframe=Frame(nw,width=200,bd=5,height=445)
        upperframe.pack(side=TOP,fill=BOTH,expand=TRUE)
        lowerframe.pack(side=TOP,fill=BOTH,expand=TRUE)

        #Tree
        tree=ttk.Treeview(lowerframe)
        tree.pack(side=TOP)
        tree['columns']=("roll_no","purpose","entry_time","exit_time")
        tree.column("#0",width=0)
        tree.column("roll_no",anchor=CENTER,width="100")
        tree.column("purpose",anchor=CENTER,width="120")
        tree.column("entry_time",anchor=CENTER,width="200")
        tree.column("exit_time",anchor=CENTER,width="200")
        tree.heading("#0",text='')
        tree.heading("roll_no",text="Roll No",anchor=CENTER)
        tree.heading("purpose",text="Purpose",anchor=CENTER)
        tree.heading("entry_time",text="Entry Time",anchor=CENTER)
        tree.heading("exit_time",text="Leaving Time",anchor=CENTER)
        tree.bind('<Double-Button-1>',getvalue)
        #tree.insert(parent='',index='end',iid=0,text='',values=(3,'Fun','2018-11-01 12:45:10','2017-11-21 15:48:10'))
       
        #labels
        label1 = tk.Label(upperframe, text="Roll No: ")
        label2 = tk.Label(upperframe, text="Purpose: ")
        label3 = tk.Label(upperframe, text="Entry Time*: ")
        label4 = tk.Label(upperframe,text="Leaving Time*:")
        #entries
        f1 = tk.Entry(upperframe)
        f2 = tk.Entry(upperframe)
        f3 = tk.Entry(upperframe)
        f4 = tk.Entry(upperframe)
        
        #Buttons
        b1 = Button(upperframe, text="Add",width=6,command=add_gr)
        b2 = Button(upperframe, text="Search",width=6,command=search_gr)
        b3 = Button(upperframe, text="Show",width=6,command=show_gr)
        b4 = Button(upperframe, text="Update",width=6,command=update_gr)
        b5 = Button(upperframe, text="Clear",width=6,command=clear_gr)
        b6 = Button(upperframe, text="Delete",width=6,command=delete_gr)
        
        #Grid
        label1.place(anchor=CENTER,relx=0.2,rely=0.25)
        label2.place(anchor=CENTER,relx=0.6,rely=0.25)
        label3.place(anchor=CENTER,relx=0.2,rely=0.375)
        label4.place(anchor=CENTER,relx=0.6,rely=0.375)

        f1.place(anchor=CENTER,relx=0.4,rely=0.25)
        f2.place(anchor=CENTER,relx=0.8,rely=0.25)
        f3.place(anchor=CENTER,relx=0.4,rely=0.375)
        f4.place(anchor=CENTER,relx=0.8,rely=0.375)

        b1.place(anchor=CENTER,relx=0.25,rely=0.625)
        b2.place(anchor=CENTER,relx=0.5,rely=0.625)
        b3.place(anchor=CENTER,relx=0.75,rely=0.625)
        b4.place(anchor=CENTER,relx=0.25,rely=0.75)
        b5.place(anchor=CENTER,relx=0.5,rely=0.75)
        b6.place(anchor=CENTER,relx=0.75,rely=0.75)

        nw.mainloop()