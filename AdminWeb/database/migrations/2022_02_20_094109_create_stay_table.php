<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateStayTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('stay', function (Blueprint $table) {
            $table->id();
            $table->integer("place_id");
            $table->string("name");
            $table->string("image_name");
            $table->string("description");
            $table->double("location_x");
            $table->double("location_y");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('stay');
    }
}
