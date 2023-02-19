from django.contrib import admin
from django.urls import path
from home import views

urlpatterns = [
    path('',views.index,name="index"),
    path('detect',views.detect,name="detect"),
    path('login',views.handleLogin,name="handleLogin"),
    path('logout',views.handleLogout,name="handleLogout"),
    path('home',views.home,name="home"),
    path('results',views.results,name="results"),
    path('signup',views.handleSignup,name="handleSignup"),
    path('search_phone',views.search_phone,name="search_phone"),
    path('output',views.output,name="output"),
]