<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;

class UploadFile extends Controller
{
    public function index()
    {
        return view('app');
    }

    public function upload(Request $request)
    {
        if (!$request->hasFile('image')) {
            return Response::json(['error' => 'No image found!'], 400);
        }

        $uploadedImage = $request->file('image');
        $imageData = [
            'name' => $uploadedImage->getClientOriginalName(),
            'type' => $uploadedImage->getMimeType(),
            'size' => $uploadedImage->getSize(),
        ];

        return Response::json($imageData);
    }
}
