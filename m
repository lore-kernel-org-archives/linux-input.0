From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: RMI4 F12 clipping issues
Date: Fri, 23 Dec 2016 11:28:20 -0800
Message-ID: <1482521300.29856.17.camel@synaptics.com>
References: <20161220212957.GA19338@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam03on0085.outbound.protection.outlook.com ([104.47.42.85]:39838
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941785AbcLWT22 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 23 Dec 2016 14:28:28 -0500
In-Reply-To: <20161220212957.GA19338@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org

On Tue, 2016-12-20 at 21:29 +0000, Nick Dyer wrote:
> Hi Christopher-
> 
> I wonder if you could comment on an issue we've seen with the
> mainline
> RMI4 driver code?
> 
> We've discovered that the code where the driver adjusts the positions
> reported to the input layer, according to Low/High
> Transmitter/Receiver
> clip values read out of F12 ctrl register 08, doesn't seem to work
> properly. It ends up with a stripe of co-ordinates down one side of
> the
> screen which is inaccessible to input touches.
> 
> The below patch shows the lines causing the proble. It does fix our
> issue, although obviously it's not a proper fix. I suspect the root
> cause is that clipping as set in F12 ctrl register 08 has a different
> use case (and units) to clipping as defined via device tree, so we
> shouldn't be reading these values into clip_x_low etc in rmi_f12.c in
> the first place. Do you agree?

Hi Nick,

Sorry for the delay in getting back on this - year end crunch time ate
up a lot of cycles.

Anyway, I'm inclined to agree with you that there is a unit mixup.
 There's several F12 Control registers under Crtl8, and for no apparent
good reason (well, as far as I can see), none of them use the same
units & formatting.  Here's what I've got in my copy of the spec (which
is labeled as a draft, and so might not match the firmware 100%):

coordinate limits: 16 bit fields in integer reported coordinate values.

sensor pitch: 16 bit fields, tx and rx pitch in millimenters in Q4.12
fixed point.

inactive border width (clipping values):
    - if registers are 1 byte, they are in units of 1/128th of the
corresponding tx/rx sensor pitch.
    - if registers are 2 bytes, they are width in millimeters in 8.8
fixed point.

This last one is rather confusing, and quite probably the result of the
issue you're seeing.  My spec has markup consistent with this being
changed in that draft, but changed from what to what isn't exactly
clear.  Unfortunately, it's a day off and the spec author isn't
available at the moment as is the rest of the firmware team, so there's
no-one to ask for clarification.

If you can send me a firmware build ID for the sensor or sensors that
are displaying this issue, I can check the sources and try to verify
what the units in question are.

> 
> I think there's another minor issue in that we should be passing
> sensor->min_x to input_set_abs_params(ABS_MT_POSITION_X).

Yes, that's definitely a good idea :-)

					Chris


> 
> cheers
> 
> Nick
> 
> ---
>  drivers/input/rmi4/rmi_2d_sensor.c | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_2d_sensor.c
> b/drivers/input/rmi4/rmi_2d_sensor.c
> index e97bd7f..5f474b4 100644
> --- a/drivers/input/rmi4/rmi_2d_sensor.c
> +++ b/drivers/input/rmi4/rmi_2d_sensor.c
> @@ -52,15 +52,6 @@ void rmi_2d_sensor_abs_process(struct
> rmi_2d_sensor *sensor,
>  	obj->x += axis_align->offset_x;
>  	obj->y += axis_align->offset_y;
>  
> -	obj->x =  max(axis_align->clip_x_low, obj->x);
> -	obj->y =  max(axis_align->clip_y_low, obj->y);
> -
> -	if (axis_align->clip_x_high)
> -		obj->x = min(sensor->max_x, obj->x);
> -
> -	if (axis_align->clip_y_high)
> -		obj->y =  min(sensor->max_y, obj->y);
> -
>  	sensor->tracking_pos[slot].x = obj->x;
>  	sensor->tracking_pos[slot].y = obj->y;
>  }
> @@ -147,16 +138,6 @@ static void
> rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
>  		if (sensor->axis_align.swap_axes)
>  			swap(sensor->max_x, sensor->max_y);
>  
> -		sensor->min_x = sensor->axis_align.clip_x_low;
> -		if (sensor->axis_align.clip_x_high)
> -			sensor->max_x = min(sensor->max_x,
> -				sensor->axis_align.clip_x_high);
> -
> -		sensor->min_y = sensor->axis_align.clip_y_low;
> -		if (sensor->axis_align.clip_y_high)
> -			sensor->max_y = min(sensor->max_y,
> -				sensor->axis_align.clip_y_high);
> -
>  		set_bit(EV_ABS, input->evbit);
>  		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
> sensor->max_x,
>  					0, 0);

