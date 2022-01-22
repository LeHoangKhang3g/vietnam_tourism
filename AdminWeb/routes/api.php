<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\Account;
use App\Models\Place;
use App\Models\Post;
use App\Models\Comment;
use App\Models\Status;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::get("/posts",function(){
    $posts=Post::all();
    return json_encode($posts);
});

Route::get("/places",function(){
    $places=Place::all();
    return json_encode($places);
});

Route::get("/accounts",function(){
    $accounts=Account::all();
    return json_encode($accounts);
});

Route::get("/comments",function(){
    $comments=Comment::all();
    return json_encode($comments);
});

Route::get("/status",function(){
    $status=Status::all();
    return json_encode($status);
});

Route::post("/sign-in",function(Request $request){
    $data=(array)json_decode($request->data);
    $account = Account::where("username",$data["username"])->where("password",$data["password"])->first();
    if(empty($account)){
        return json_encode([
            "success"=>false,
            "username"=>$data["username"],
            "password"=>$data["password"],
        ]);
    }
    return json_encode([
        "success"   =>true,
        "data"      =>$account,
    ]);
});

Route::post("/change-status",function(Request $request){
    $data=(array)json_decode($request->data);
    if($request->check=="true"){
        $status = new Status();
        $status->account_id=$data["account_id"];
        $status->type_post=$data["type_post"];
        $status->post_id=$data["post_id"];
        $status->type_status=$data["type_status"];
        $status->save();
        return json_encode([
            "success"=>true,
            "check"=>"true",
        ]);
    }
    else if($request->check=="false"){
        $status = Status::find($data["id"]);
        $status->delete();
        return json_encode([
            "success"=>true,
            "check"=>"false",
        ]);
    }
    else{
        $status = new Status();
        $status->account_id=$data["account_id"];
        $status->type_post=$data["type_post"];
        $status->post_id=$data["post_id"];
        $status->type_status=$data["type_status"];
        $status->save();

        $type_status = "like";
        if($type_status==$data["type_status"])
            $type_status="unlike";

        $status = Status::where("account_id",$data["account_id"])->where("type_post",$data["type_post"])
        ->where("post_id",$data["post_id"])->where("type_status",$type_status);
        $status->delete();

        return json_encode([
            "success"=>true,
            "check"=>"double",
        ]); 
    }

});

// Route::post("/add-post-share",function(){
    
// });
// Route::post("/add-comment",function(){

// });

// Route::post("/post-status",function(){

// });

