<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Account;
use App\Models\Comment;
use App\Models\Place;
use App\Models\Post;
use App\Models\Status;
use App\Models\Cook;
use App\Models\Stay;
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
            "phone"     => "0833708166",
            "email"     =>"khang1@gmail.com",
            "avatar"    =>"https://taimienphi.vn/tmp/cf/aut/mAKI-top-anh-dai-dien-dep-chat-1.jpg",
            "background"=>"https://www.pcclean.io/wp-content/uploads/2022/01/2098712018385749387.jpg",
        ]);
        Account::insert([
            "username"=>"trung2",
            "password"=>"pass2",
            "name"=>"Trung",
            "birthday"=> new DateTime("2001-10-08T13:13:13"),
            "phone"=> "0833708177",
            "email"=>"trung2@gmail.com",
            "avatar"=>"https://thuthuatnhanh.com/wp-content/uploads/2018/07/anh-dai-dien-dep-652x580.jpg",
            "background"=>"https://www.pcclean.io/wp-content/uploads/2022/01/5192663260106856456.jpg",
        ]);
        Account::insert([
            "username"  =>"oanh3",
            "password"  =>"pass3",
            "name"      =>"Oanh",
            "birthday"  => new DateTime("2002-09-08T13:13:13"),
            "phone"     => "0833708888",
            "email"     =>"oanh3@gmail.com",
            "avatar"    =>"https://haycafe.vn/wp-content/uploads/2021/12/anh-dai-dien-con-gai-view-cuc-chill.jpg",
            "background"=>"https://www.pcclean.io/wp-content/uploads/2022/01/2082114608174207210.jpg",
        ]);       
        Account::insert([
            "username"  =>"khang4",
            "password"  =>"pass4",
            "name"      =>"Hoàng Khang",
            "birthday"  => new DateTime("2002-09-08T13:13:13"),
            "phone"     => "0833708199",
            "email"     =>"khang4@gmail.com",
            "avatar"    =>"https://thuthuatnhanh.com/wp-content/uploads/2021/02/Avatar-ngau-dep.jpg",
            "background"=>"https://www.pcclean.io/wp-content/uploads/2022/01/1331210308022202174.jpg",
        ]);
        Account::insert([
            "username"  =>"trung5",
            "password"  =>"pass5",
            "name"      =>"Trungg",
            "birthday"  => new DateTime("2002-09-08T13:13:13"),
            "phone"     => "0833708100",
            "email"     =>"trung5@gmail.com",
            "avatar"    =>"https://thuthuatnhanh.com/wp-content/uploads/2022/01/Hinh-anh-avatar-cute-nam.jpg",
            "background"=>"https://www.pcclean.io/wp-content/uploads/2022/01/843414300820608178.jpg",
        ]);
        //=================================================================================================================
        Place::insert([
            "name"          =>"Nha Trang",
            "area"          =>"Miền Trung",
            "region"        =>"Biển",
            "description"   =>"Khám phá ngay trung tâm thành phố Nha Trang có gì chơi:  ",
            "image_name"    =>"http://www.xaviahotel.com/vnt_upload/news/11_2017/nha-trang_1.jpg",
            "location_x"    =>12.242602598120262,
            "location_y"    =>109.19704465844295,
        ]);
        Place::insert([
            "name"          =>"Thừa Thiên Huế",
            "area"          =>"Miền Trung",
            "region"        =>"Biển",
            "description"   =>"Kiến trúc thời phong kiến , phong cảnh phong tục văn hóa dân tộc việt nam",
            "image_name"    =>"https://upload.wikimedia.org/wikipedia/commons/a/ab/Meridian_Gate%2C_Hue_%28I%29.jpg",
            "location_x"    =>16.47636243680624,
            "location_y"    =>107.57845933185345,
        ]);
        Place::insert([
            "name"          =>"Vịnh Hạ Long",
            "area"          =>"Miền Bắc",
            "region"        =>"Biển",
            "description"   =>"Có Nhiều bãi đẹp , phong phú về địa hình , các hòn đảo , đá san hô",
            "image_name"    =>"https://i0.wp.com/datvandon.net/wp-content/uploads/2019/11/vinh-ha-long-o-tinh-nao-viet-nam.jpeg?resize=768%2C576&ssl=1",
            "location_x"    =>20.84116717857313,
            "location_y"    =>107.16329982935363,
        ]);
        //=================================================================================================================
        Post::insert([
            "account_id"=>1,
            "place_id"  =>1,
            "time"      =>new DateTime("2022-1-13T5:33:22"),
            "content"   =>"Có nhiều bãi biển đẹp",
            "image_name"=>"https://img3.thuthuatphanmem.vn/uploads/2019/07/13/anh-bien-nha-trang-dep_085935625.jpg",
        ]);
        Post::insert([
            "account_id"=>1,
            "place_id"  =>2,
            "time"      =>new DateTime("2022-1-12T5:33:22"),
            "content"   =>"Cổ kính, hoài niệm",
            "image_name"=>"https://media.vneconomy.vn/w800/images/upload/2021/06/17/hue.png"
        ]);
        Post::insert([
            "account_id"=>2,
            "place_id"  =>3,
            "time"      =>new DateTime("2022-1-11T5:33:22"),
            "content"   =>"Nước biển trong xanh, cảnh đẹp.",
            "image_name"=>"https://www.seaplanes.vn/blog/wp-content/uploads/2016/08/1280px-Ha_Long_bay_The_Kissing_Rocks-hon-tr%E1%BB%91ng-m%C3%A1i-696x522.jpg"
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
        //===================================================================================================================
        Cook::insert([
            "place_id"=>"1",
            "name"=>"Bánh bèo",
            "description"=>"Bánh bèo là một món bánh rất thịnh hành ở miền Trung, món bánh ngon lành không thể bỏ lỡ.",
            "image_name"=>"https://cdn.tgdd.vn/Files/2017/03/21/963426/cach-lam-banh-beo-thom-ngon-202110041645542724.jpg",
        ]);
        Cook::insert([
            "place_id"=>"1",
            "name"=>"Bún sứa",
            "description"=>"Bún sứa Nha Trang là một trong những món ăn ngon ở Nha Trang thuộc hàng top phải kể đến trong danh sách này. Sứa tươi được đánh bắt hàng ngày trên biển và đã được làm sạch, cắt nhỏ thành miếng vừa ăn.",
            "image_name"=>"http://bietthubiennhatrang.net/wp-content/uploads/2021/05/15-mon-an-dac-san-nha-trang-ngon-nhat-khong-the-bo-qua-5eb127f97de5b.jpg",
        ]);
        Cook::insert([
            "place_id"=>"1",
            "name"=>"Bánh căn hải sản",
            "description"=>"ánh căn là món ăn quen thuộc được mang từ Đà Lạt về Nha Trang, tuy không phải là món đặc sản chính gốc nhưng bán căn Nha Trang là món ăn bạn nhất định phải thử khi đến với TP biển.",
            "image_name"=>"http://bietthubiennhatrang.net/wp-content/uploads/2021/05/15-mon-an-dac-san-nha-trang-ngon-nhat-khong-the-bo-qua-5eb128aae5ed2.jpg",
        ]);
        
        Cook::insert([
            "place_id"=>"2",
            "name"=>"Cơm hến",
            "description"=>"Nói đến món ngon ở Huế không thể không nhắc đến Cơm hến. Là một trong những món ăn ngon ở huế với sự kết hợp hoàn hảo giữa ẩm thực cung đình Huế và ẩm thực dân gian tạo nên hương vị vừa riêng, vừa độc đáo, vừa lạ lẫm của món ăn.",
            "image_name"=>"https://statics.vinpearl.com/hinh-anh-mon-ngon-o-hue-4.jpg",
        ]);
        Cook::insert([
            "place_id"=>"2",
            "name"=>"Bún thịt nướng",
            "description"=>"Là món ăn không chỉ có ở Huế mà còn xuất hiện ở nhiều tỉnh thành khác trên đất nước. Nhưng bún Huế lại mang 1 màu sắc và hương vị khác mang theo cái hồn, cái đẹp của vùng đất kinh thành xưa.",
            "image_name"=>"https://statics.vinpearl.com/mon-ngon-o-hue.jpg",
        ]);
        Cook::insert([
            "place_id"=>"2",
            "name"=>"Bánh nậm",
            "description"=>"Bánh nậm là sự kết hợp của bột gạo, bột năng, gói trong bánh là nhân tôn trộn thịt lợn ăn kèm với nướng chấm chua chua mặn mặn. Món bánh là say lòng biết bao du khách khi ghé thăm Huế. ",
            "image_name"=>"https://statics.vinpearl.com/hinh-anh-mon-ngon-o-hue-6.jpg",
        ]);

        Cook::insert([
            "place_id"=>"3",
            "name"=>"Chả mực",
            "description"=>"Chả mực là món ăn được làm từ nguyên liệu chính là thịt mực giã hoặc xay nhuyễn, tạo hình bánh tròn rồi chiên chín. Hạ Long là nơi có nhiều loại hải sản vô cùng hấp dẫn, đặc biệt là mực ở nơi đây có vị ngọt hơn so với những vùng khác.",
            "image_name"=>"https://file.hstatic.net/1000030244/file/cha-muc-bao-nhieu-tien-1kg-1_005bad596a4b47b1bad2a5e4717a5f3f_grande.jpg",
        ]);
        Cook::insert([
            "place_id"=>"3",
            "name"=>"Sam",
            "description"=>"Sam biển cùng dòng họ với nhà cua, cũng có mai và càng nhưng to hơn. Điều thú vị là những con sam thường đi thành cặp, con cái cõng con đực trên lưng nên khi đánh bắt, người ta thường bắt được một cặp.",
            "image_name"=>"https://www.vietfuntravel.com.vn/image/data/Blog/dac-san/sam-bien/sam-bien-h3.jpg",
        ]);
        Cook::insert([
            "place_id"=>"3",
            "name"=>"Bún bề bề",
            "description"=>"Sau khi sơ chế, người ta lấy vỏ bề bề nấu cùng với xương ống làm nước dùng. Trong một tô bún bề bề còn có các nguyên liệu khác như cải ngọt, cà chua, tôm sắt nõn và các loại rau thơm khác giúp làm tăng hương vị của món ăn. ",
            "image_name"=>"https://ik.imagekit.io/tvlk/blog/2017/02/am-thuc-ha-long-top-10-mon-an-ngon-o-ha-long-7-1024x1024.jpg?tr=dpr-1,w-675",
        ]);
        //===================================================================================================================

    }
}
