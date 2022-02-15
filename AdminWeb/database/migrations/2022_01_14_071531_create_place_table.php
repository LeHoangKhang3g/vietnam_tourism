<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlaceTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('place', function (Blueprint $table) {
            $table->increments("id");
            $table->string("name");
            $table->string("area");
            $table->string("region");
            $table->string("description");
            $table->string("image_name");
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
        Schema::dropIfExists('place');
    }
}
