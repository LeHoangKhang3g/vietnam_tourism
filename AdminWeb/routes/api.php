<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\Account;
use App\Models\Place;
use App\Models\Post;
use App\Models\Comment;
use App\Models\Status;
use App\Models\Cook;
use App\Models\Stay;

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
    $posts=Post::orderBy('id','DESC')->get();
    return json_encode($posts);
});

Route::get("/places",function(){
    $places=Place::orderBy('id','DESC')->get();
    return json_encode($places);
});

Route::get("/accounts",function(){
    $accounts=Account::all();
    return json_encode($accounts);
});

Route::get("/comments",function(){
    $comments=Comment::orderBy('id','DESC')->get();
    return json_encode($comments);
});

Route::get("/status",function(){
    $status=Status::all();
    return json_encode($status);
});

Route::get("/cooks",function(){
    $cooks=Cook::all();
    return json_encode($cooks);
});

Route::get("/stays",function(){
    $stays=Stay::all();
    return json_encode($stays);
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

    $statuss=Status::where("account_id",$data["account_id"])->where("type_post",$data["type_post"])
    ->where("post_id",$data["post_id"]);
    $statuss->delete();

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
        return json_encode([
            "success"=>true,
            "check"=>"false",
        ]);
    }
    

});

Route::post("/add-post-share",function(Request $request){
    try{

        $data=(array)json_decode($request->data);

        $post = new Post();
        $post->account_id=$data["account_id"];
        $post->place_id=$data["place_id"];
        $post->time=$data["time"];
        $post->content=$data["content"];
        $post->image_name="";
        $post->save();

        $id = Post::max("id");
        $post=Post::find($id);

        $image = $request->file("picture");
        $ex = $image->extension();
        $imageName = "post".$id.".".$ex;
        $storePath = $image->storeAs("images/posts",$imageName);

        $post->image_name="http://127.0.0.1:8000/images/posts/".$imageName;
        $post->save();
        
        $posts=Post::orderBy('id','DESC')->get();
        return json_encode([
            "success"=>true,  
            "data"=>json_encode($posts),
        ]);
    }
    catch(Exception $e)
    {
        return json_encode([
            "success"=>false,
            "error" =>$e,
        ]);
    }
});

Route::post("/add-comment",function(Request $request){
    try{
        $data=(array)json_decode($request->data);
        $comment = new Comment();
        $comment->account_id=$data["account_id"];
        $comment->type_post=$data["type_post"];
        $comment->post_id=$data["post_id"];
        $comment->content=$data["content"];
        $comment->time=$data["time"];
        $comment->save();
        
        $comments=Comment::orderBy('id','DESC')->get();
        return json_encode([
            "success"=>true,  
            "data"=>json_encode($comments),

        ]);
    }
    catch(Exception $e)
    {
        return json_encode([
            "success"=>false,
            "error" =>$e,
        ]);
    }
    
});

Route::post("/delete-comment",function(Request $request){
    try{
        $data=(array)json_decode($request->data);
        
        $comment=Comment::find($data["id"]);
        $comment->delete();
        
        $comments=Comment::orderBy('id','DESC')->get();
        return json_encode([
            "success"=>true,  
            "data"=>json_encode($comments),

        ]);
    }
    catch(Exception $e)
    {
        return json_encode([
            "success"=>false,
            "error" =>$e,
        ]);
    }
    
});

Route::post("/sign-up",function(Request $request){
    //try{
        $data=(array)json_decode($request->data);
        $account = new Account();
        $account->username=$data["username"];
        $account->password=$data["password"];
        $account->name=$data["name"];
        $account->birthday=$data["birthday"];
        $account->phone=$data["phone"];
        $account->email=$data["email"];
        $account->avatar=$data["avatar"];
        $account->background=$data["background"];
        $account->save();

        $id = Account::max("id");
        $account = Account::find($id);


        $image = $request->file("avatar");
        $ex = $image->extension();
        $imageName = "avatar".$id.".".$ex;
        $storePath = $image->storeAs("images/avatars",$imageName);
        $account->avatar="http://127.0.0.1:8000/images/avatars/".$imageName;
        
        $image = $request->file("background");
        $ex = $image->extension();
        $imageName = "background".$id.".".$ex;
        $storePath = $image->storeAs("images/backgrounds",$imageName);
        $account->background="http://127.0.0.1:8000/images/backgrounds/".$imageName;

        $account->save();
        
        return json_encode([
            "success"=>true,  
        ]);
    //}
    // catch(Exception $e)
    // {
    //     return json_encode([
    //         "success"=>false,
    //         "error" =>$request->data,
    //     ]);
    // }
});

