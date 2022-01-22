<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCommentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('comment', function (Blueprint $table) {
            $table->increments("id");
            $table->integer("account_id");
            $table->string("type_post");
            $table->integer("post_id");
            $table->string("content");
            $table->datetime("time");
            $table->timestamps();
        });
    }
    // int accountId=0;
    // String content="";
    // DateTime time =DateTime.now();
    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('comment');
    }
}
