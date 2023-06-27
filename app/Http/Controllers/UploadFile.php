<?php

namespace App\Http\Controllers;

use DateTime;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Response;
use Illuminate\Support\Facades\Validator;

class UploadFile extends Controller
{
    public function index()
    {
        return view('app');
    }

    public function upload(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'number' => 'required',
            'name' => 'required',
            'type' => 'required',
            'channel' => 'required',
            'image' => 'required|mimes:pdf,gif,jpeg,jpg,png|max:10000',
        ], [
            'required' => 'Invalid Request. Missing required parameter.',
            'mimes' => 'Images must be of type gif,jpeg,jpg,png or pdf.',
            'max' => 'Images must not be bigger than 10MB.',
        ]);

        if ($validator->fails()) {
            return Response::json(['error' => $validator->errors()->first()]);
        }

        $uploadedImage = $request->file('image');
        $imageData = [
            'time' => (new DateTime())->getTimestamp(),
            'name' => $uploadedImage->getClientOriginalName(),
            'type' => $uploadedImage->getMimeType(),
            'size' => $uploadedImage->getSize(),
        ];

        return Response::json($imageData);
    }
}
