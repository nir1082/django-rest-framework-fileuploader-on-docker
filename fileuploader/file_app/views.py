from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.response import Response
from rest_framework import status
from .serializers import FileSerializer
from fileuploader import settings
import os
import zipfile

class FileView(APIView):
  parser_classes = (MultiPartParser, FormParser)
  def post(self, request, *args, **kwargs):
    file_serializer = FileSerializer(data=request.data)
    if file_serializer.is_valid():
      file_name = str(request.data['file'])
      file_path = os.path.join(settings.MEDIA_ROOT, file_name)

      if os.path.exists(file_path):
        os.remove(file_path)

      file_serializer.save()
      splitext = os.path.splitext(file_name)
      if splitext[1] == '.zip':
        with zipfile.ZipFile(file_path, 'r') as zf:
          zf.extractall(path=os.path.join(settings.MEDIA_ROOT, splitext[0]))
      return Response(file_serializer.data, status=status.HTTP_201_CREATED)
    else:
      return Response(file_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
