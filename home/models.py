from django.db import models

# Create your models here.
class Detect(models.Model):
    name=models.CharField(max_length=50)
    age=models.CharField(max_length=5)
    gender=models.CharField(max_length=10)
    email=models.CharField(max_length=50)
    phone=models.CharField(max_length=20)
    right_eye=models.ImageField(upload_to='images/')
    left_eye=models.ImageField(upload_to='images/')
    right_result=models.CharField(max_length=20)
    left_result=models.CharField(max_length=20)
    def __str__(self):
        return self.name
