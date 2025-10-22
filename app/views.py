from django.http import JsonResponse
from .models import Employee

def employee_list(request):
    employees = list(Employee.objects.values())
    return JsonResponse({"employees": employees})
