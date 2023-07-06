from django.shortcuts import render, HttpResponse ,redirect
from home.models import Detect
from django.contrib.auth.models import User
from django.contrib.auth import login,logout,authenticate,get_user_model
from django.contrib import messages
from django.core.files.storage import FileSystemStorage

import tensorflow as tf
import tensorflow_hub as hub
import cv2
import numpy as np
# Create your views here.


path = 'model\dr_model.h5'
model = tf.keras.models.load_model((path),custom_objects={'KerasLayer':hub.KerasLayer})

def index(request):
    return render(request,'index.html')
def detect(request):
    return render(request,'detect.html')

def handleLogin(request):
    if request.method=='POST':
        loginusername=request.POST['loginusername']
        loginpass=request.POST['loginpass']

        user= authenticate(username=loginusername,password=loginpass)
        if user is not None:
            login(request,user)
            
            return redirect('home')
        else:
            messages.error(request,"Invalid Credentials! Please try again")
            return redirect('/')


        

    else:
        return render(request,'index.html')
    


def handleLogout(request):
    logout(request)
    messages.success(request,"Successfully Logged out")
    return redirect('/')

def home(request):
    return render(request,'home.html')

def results(request):
    info=Detect.objects.all()
    context={'info':info}
    return render(request,'results.html',context)


def handleSignup(request):
    
    if request.method=='POST':
        username=request.POST['username']
        fname=request.POST['fname']
        lname=request.POST['lname']
        email=request.POST['email']
        phone=request.POST['phone']
        pass1=request.POST['pass1']
        pass2=request.POST['pass2']

        User = get_user_model()
        users = User.objects.values()
        
        for i in range(0,len(users)):
            if users[i]['username']==username:
                messages.error(request,"Username Already Exists")
                return redirect('/')


        if len(username)>15:
            messages.error(request,"Username must be under 15 Characters")
            return redirect('/')

        if pass1!=pass2:
            messages.error(request,"Passwords do not match")
            return redirect('/')
        
        if len(phone)!=10:
            messages.error(request,"Phone number must contain 10 digits")
            return redirect('/')
        
        if not username.isalnum():
            messages.error(request,"Username must contain Numbers and Letters")


        newuser=User.objects.create_user(username,email,pass1)
        newuser.first_name=fname
        newuser.last_name=lname
        newuser.save()
        messages.success(request,"New User Created")

        return redirect('/')


    else:
        return render(request,'index.html')


def search_phone(request):
    if request.method=='POST':
        search=request.POST.get('search')
        info=Detect.objects.filter(phone__contains=search)
        return render(request,'search_phone.html',{'search':search,'info':info})

def output(request):
    if request.method=='POST':

        name=request.POST.get('name')
        age=request.POST.get('age')
        gender=request.POST.get('gender')
        email=request.POST.get('email')
        phone=request.POST.get('phone')
        right_eye=request.FILES['right_eye']
        left_eye=request.FILES['left_eye']
        # obj=Detect(name=name,age=age,gender=gender,email=email,phone=phone,right_eye=right_eye,left_eye=left_eye)
        # obj.save()
        fs=FileSystemStorage()
        
        filename1=fs.save(right_eye.name,right_eye)
        filename1=fs.url(right_eye)
        filename2=fs.save(left_eye.name,left_eye)
        filename2=fs.url(left_eye)

        
        input_image_path = "."+filename1
        # input_image_path=input_image_path[:7]+"/images/"+input_image_path[8:]
        print(input_image_path)
        input_image = cv2.imread(input_image_path)
        
        # input_image = input_image.reshape((224,224)).astype('float32')
        input_image_resize = cv2.resize(input_image, (224,224))

        input_image_scaled = input_image_resize/255

        image_reshaped = np.reshape(input_image_scaled, [1,224,224,3])

        input_prediction = model.predict(image_reshaped)



        input_pred_label = np.argmax(input_prediction)


        result=""
        if input_pred_label == 0:
            result='No DR(0)'
        elif input_pred_label == 1:
            result='Mild DR(1)'
        elif input_pred_label == 2:
            result='Moderate DR(2)'
        elif input_pred_label == 3:
            result='Severe DR(3)'
        elif input_pred_label == 4:
            result='Proliferative DR(4)'
        

        input_image_path2 = "."+filename2
        # input_image_path2=input_image_path2[:7]+"/images/"+input_image_path2[8:]
        # print(input_image_path2)
        # print(input_image_path)
        input_image = cv2.imread(input_image_path2)
        # input_image = input_image.reshape((224,224)).astype('float32')
        input_image_resize = cv2.resize(input_image, (224,224))

        input_image_scaled = input_image_resize/255

        image_reshaped = np.reshape(input_image_scaled, [1,224,224,3])
        

        input_prediction = model.predict(image_reshaped)



        input_pred_label = np.argmax(input_prediction)


        result2=""
        if input_pred_label == 0:
            result2='No DR(0)'
        elif input_pred_label == 1:
            result2='Mild DR(1)'
        elif input_pred_label == 2:
            result2='Moderate DR(2)'
        elif input_pred_label == 3:
            result2='Severe DR(3)'
        elif input_pred_label == 4:
            result2='Proliferative DR(4)'

        right_result=result
        left_result=result2
        obj=Detect(name=name,age=age,gender=gender,email=email,phone=phone,right_eye=right_eye,left_eye=left_eye,right_result=right_result,left_result=left_result)
        obj.save()
        context={'result':result,'result2':result2,'img_right':input_image_path,'img_left':input_image_path2,'name':name,'age':age,'gender':gender,'email':email,'phone':phone}
        return render(request,'output.html',context)