<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Account;
use App\Models\Comment;
use App\Models\Place;
use App\Models\Post;
use App\Models\Status;
use DateTime;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {

        Account::insert([
            "username"  =>"khang1",
            "password"  =>"pass1",
            "name"      =>"Khang",
            "birthday"  => new DateTime("2021-05-04T12:12:12"),
            "email"     =>"khang1@gmail.com",
            "avatar"    =>"avatar1.jpg",
            "background"=>"background1.jpg",
        ]);
        Account::insert([
            "username"=>"trung2",
            "password"=>"pass2",
            "name"=>"Trung",
            "birthday"=> new DateTime("2001-10-08T13:13:13"),
            "email"=>"trung2@gmail.com",
            "avatar"=>"avatar2.jpg",
            "background"=>"background2.jpg",
        ]);
        Account::insert([
            "username"  =>"oanh3",
            "password"  =>"pass3",
            "name"      =>"Oanh",
            "birthday"  => new DateTime("2002-09-08T13:13:13"),
            "email"     =>"oanh3@gmail.com",
            "avatar"    =>"avatar3.jpg",
            "background"=>"background3.jpg",
        ]);       
        Account::insert([
            "username"  =>"khang4",
            "password"  =>"pass4",
            "name"      =>"Hoàng Khang",
            "birthday"  => new DateTime("2002-09-08T13:13:13"),
            "email"     =>"khang4@gmail.com",
            "avatar"    =>"avatar4.jpg",
            "background"=>"background4.jpg",
        ]);
        Account::insert([
            "username"  =>"trung5",
            "password"  =>"pass5",
            "name"      =>"Trungg",
            "birthday"  => new DateTime("2002-09-08T13:13:13"),
            "email"     =>"trung5@gmail.com",
            "avatar"    =>"avatar5.jpg",
            "background"=>"background5.jpg",
        ]);
        //=================================================================================================================
        Place::insert([
            "name"          =>"Nha Trang",
            "area"          =>"Miền Trung",
            "region"        =>"Khu Vực Trung Bộ",
            "description"   =>"Khám phá ngay trung tâm thành phố Nha Trang có gì chơi:  ",
            "image_name"    =>"place1.jpg"
        ]);
        Place::insert([
            "name"          =>"Thừa Thiên Huế",
            "area"          =>"Miền Trung",
            "region"        =>"Khu Vực Trung Bộ",
            "description"   =>"Kiến trúc thời phong kiến , phong cảnh phong tục văn hóa dân tộc việt nam",
            "image_name"    =>"place2.jpg"
        ]);
        Place::insert([
            "name"          =>"Vịnh Hạ Long",
            "area"          =>"Miền Bắc",
            "region"        =>"Khu Vực Bắc Bộ",
            "description"   =>"Có Nhiều bãi đẹp , phong phú về địa hình , các hòn đảo , đá san hô",
            "image_name"    =>"place3.jpg"
        ]);
        //=================================================================================================================
        Post::insert([
            "account_id"=>1,
            "place_id"  =>1,
            "time"      =>new DateTime("2022-1-13T5:33:22"),
            "content"   =>"Có nhiều bãi biển đẹp",
            "image_name"=>"place1.jpg"
        ]);
        Post::insert([
            "account_id"=>1,
            "place_id"  =>2,
            "time"      =>new DateTime("2022-1-12T5:33:22"),
            "content"   =>"Cổ kính, hoài niệm",
            "image_name"=>"place2.jpg"
        ]);
        Post::insert([
            "account_id"=>2,
            "place_id"  =>3,
            "time"      =>new DateTime("2022-1-11T5:33:22"),
            "content"   =>"Nước biển trong xanh, cảnh đẹp.",
            "image_name"=>"place3.jpg"
        ]);
        //==================================================================================================================
        Comment::insert([
            "account_id"=>1,
            "type_post" =>"post",
            "post_id"   =>1,
            "content"   =>"Phong cảnh đẹp",
            "time"      =>new DateTime("2022-1-14T5:33:22"),
        ]);
        Comment::insert([
            "account_id"=>2,
            "type_post" =>"post",
            "post_id"   =>1,
            "content"   =>"Mát mẻ",
            "time"      =>new DateTime("2022-1-14T7:44:15"),
        ]);
    }
}
