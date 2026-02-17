<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class CategoryController extends Controller
{
    public function index()
    {
        $user = Auth::user();
        $categories = Category::where('user_id', $user->id)->orWhereNull('user_id')->get(); 
        $data = array(
            "success" => true,
            "data" => $categories
        );
        return response()->json($data, 200);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required',
            'icon' => 'required',
        ]);

        if ($validator->passes()) {
            $category = new Category();
            $category->name = $request->name;
            $category->icon = $request->icon;
            $category->user_id = $request->user()->id; 
            $category->save();

            $data = array(
                "message" => "Category Created Successfully!",
                "success" => true,
                "data" => $category
            );

            return response()->json($data, 201);
        } else {
            return response()->json(array("success" => false, "type" => 'validation', 'errors' => $validator->messages()))
                ->setStatusCode(Response::HTTP_UNPROCESSABLE_ENTITY, Response::$statusTexts[Response::HTTP_UNPROCESSABLE_ENTITY]);
        }
    }

    public function show(string $id)
    {
        $user = Auth::user();
        $category = Category::where('id', $id)->where(function ($query) use ($user) {
            $query->where('user_id', $user->id)
                ->orWhereNull('user_id'); 
        })->first();

        if ($category) {
            $data = array(
                "success" => true,
                "data" => $category
            );
            return response()->json($data, 200);
        } else {
            return response()->json(array("success" => false, "message" => "Category not found"), 404);
        }
    }

    public function destroy(string $id)
    {
        $user = Auth::user();
        $category = Category::where('id', $id)->where('user_id', $user->id)->first(); 

        if ($category) {
            $category->delete();
            $data = array(
                "message" => "Category Deleted Successfully!",
                "success" => true
            );
            return response()->json($data, 200);
        } else {
            return response()->json(array("success" => false, "message" => "Category not found or cannot be deleted"), 404);
        }
    }
}
