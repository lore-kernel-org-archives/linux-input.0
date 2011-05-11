From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: [PATCH 5/5] input: misc: AD714x: Fix captouch wheel option algorithm
Date: Wed, 11 May 2011 14:30:44 -0400
Message-ID: <4DC93A51-2EB5-44B1-9AB3-DC80810D843A@gmail.com>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com> <1305027309-17637-5-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57311 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab1EKSaf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 14:30:35 -0400
Received: by qwk3 with SMTP id 3so399749qwk.19
        for <linux-input@vger.kernel.org>; Wed, 11 May 2011 11:30:34 -0700 (PDT)
In-Reply-To: <1305027309-17637-5-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, "Getz, Robin" <Robin.Getz@analog.com>

I confirm that this patchset works well with my setup. Good job! Nice touch for the irq flags, allows platform independence.

My setup is as follows:
Patched kernel 2.6.39-rc7
AD7147A connected using VGA port i2c bus and the INTA pin of a PCI card for the AD7147A INT line.

I am using this single wheel config:
static struct ad714x_wheel_plat wheel_platform_data = {
	.start_stage = 0, // int start_stage;
	.end_stage = 7, // int end_stage;
	.max_coord = 1024,  // int max_coord;
};

static struct ad714x_platform_data wheel_dev_platform_data = {
	.irqflags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
	.slider_num = 0,
	.wheel_num = 1,
	.touchpad_num = 0,
	.button_num = 0,
	.slider = 0,
	.wheel = &wheel_platform_data, // struct ad714x_wheel_plat *wheel;
	.touchpad = 0, // struct ad714x_touchpad_plat *touchpad;
	.button = 0, // struct ad714x_button_plat *button;
	.stage_cfg_reg =  { /* unsigned short stage_cfg_reg[STAGE_NUM][STAGE_CFGREG_NUM] */
		{0xfffe, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xfffb, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xffef, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xffbf, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xfeff, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xfbff, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xefff, 0x3fff, 0, 0x2626, 5664, 5664, 7080, 7080 },
		{0xffff, 0x3ffe, 0, 0x2626, 5664, 5664, 7080, 7080 },

		{0xffff, 0x3fff, 0, 0x0606, 0x01f4, 0x01f4, 0x0320, 0x0320},
		{0xffff, 0x3fff, 0, 0x0606, 0x01f4, 0x01f4, 0x0320, 0x0320},
		{0xffff, 0x3fff, 0, 0x0606, 0x01f4, 0x01f4, 0x0320, 0x0320},
		{0xffff, 0x3fff, 0, 0x0606, 0x01f4, 0x01f4, 0x0320, 0x0320},
	},
	.sys_cfg_reg = {0x027e, 0x0000, 0x3233, 0x0819, 0x0832, 0x0000, 0x00ff, 0x0000}, /* unsigned short sys_cfg_reg[SYS_CFGREG_NUM] */
	//.sys_cfg_reg = {0x2b2, 0xfff, 0x3233, 0x819, 0x832, 0xcff, 0xcff, 0x0}, /* unsigned short sys_cfg_reg[SYS_CFGREG_NUM] */
};



On May 10, 2011, at 7:35, <michael.hennerich@analog.com> <michael.hennerich@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> As reported by Jean-Francois Dagenais, the wheel algorithm caused a
> divide by zero exception due to missing variable pre-initialization.
> In fact it turned out that the whole algorithm had several problems.
> It is therefore replaced with something that is known working.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
> drivers/input/misc/ad714x.c |  109 ++++++++-----------------------------------
> 1 files changed, 19 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
> index 3e97879..bcc6c9b 100644
> --- a/drivers/input/misc/ad714x.c
> +++ b/drivers/input/misc/ad714x.c
> @@ -79,13 +79,7 @@ struct ad714x_slider_drv {
> struct ad714x_wheel_drv {
> 	int abs_pos;
> 	int flt_pos;
> -	int pre_mean_value;
> 	int pre_highest_stage;
> -	int pre_mean_value_no_offset;
> -	int mean_value;
> -	int mean_value_no_offset;
> -	int pos_offset;
> -	int pos_ratio;
> 	int highest_stage;
> 	enum ad714x_device_state state;
> 	struct input_dev *input;
> @@ -408,7 +402,6 @@ static void ad714x_slider_state_machine(struct ad714x_chip *ad714x, int idx)
> 				ad714x_slider_cal_highest_stage(ad714x, idx);
> 				ad714x_slider_cal_abs_pos(ad714x, idx);
> 				ad714x_slider_cal_flt_pos(ad714x, idx);
> -
> 				input_report_abs(sw->input, ABS_X, sw->flt_pos);
> 				input_report_key(sw->input, BTN_TOUCH, 1);
> 			} else {
> @@ -474,104 +467,41 @@ static void ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
> /*
>  * When the scroll wheel is activated, we compute the absolute position based
>  * on the sensor values. To calculate the position, we first determine the
> - * sensor that has the greatest response among the 8 sensors that constitutes
> - * the scrollwheel. Then we determined the 2 sensors on either sides of the
> + * sensor that has the greatest response among the sensors that constitutes
> + * the scrollwheel. Then we determined the sensors on either sides of the
>  * sensor with the highest response and we apply weights to these sensors. The
> - * result of this computation gives us the mean value which defined by the
> - * following formula:
> - * For i= second_before_highest_stage to i= second_after_highest_stage
> - *         v += Sensor response(i)*WEIGHT*(i+3)
> - *         w += Sensor response(i)
> - * Mean_Value=v/w
> - * pos_on_scrollwheel = (Mean_Value - position_offset) / position_ratio
> + * result of this computation gives us the mean value.
>  */
> 
> -#define WEIGHT_FACTOR 30
> -/* This constant prevents the "PositionOffset" from reaching a big value */
> -#define OFFSET_POSITION_CLAMP	120
> static void ad714x_wheel_cal_abs_pos(struct ad714x_chip *ad714x, int idx)
> {
> 	struct ad714x_wheel_plat *hw = &ad714x->hw->wheel[idx];
> 	struct ad714x_wheel_drv *sw = &ad714x->sw->wheel[idx];
> 	int stage_num = hw->end_stage - hw->start_stage + 1;
> -	int second_before, first_before, highest, first_after, second_after;
> +	int first_before, highest, first_after;
> 	int a_param, b_param;
> 
> -	/* Calculate Mean value */
> -
> -	second_before = (sw->highest_stage + stage_num - 2) % stage_num;
> 	first_before = (sw->highest_stage + stage_num - 1) % stage_num;
> 	highest = sw->highest_stage;
> 	first_after = (sw->highest_stage + stage_num + 1) % stage_num;
> -	second_after = (sw->highest_stage + stage_num + 2) % stage_num;
> -
> -	if (((sw->highest_stage - hw->start_stage) > 1) &&
> -	    ((hw->end_stage - sw->highest_stage) > 1)) {
> -		a_param = ad714x->sensor_val[second_before] *
> -			(second_before - hw->start_stage + 3) +
> -			ad714x->sensor_val[first_before] *
> -			(second_before - hw->start_stage + 3) +
> -			ad714x->sensor_val[highest] *
> -			(second_before - hw->start_stage + 3) +
> -			ad714x->sensor_val[first_after] *
> -			(first_after - hw->start_stage + 3) +
> -			ad714x->sensor_val[second_after] *
> -			(second_after - hw->start_stage + 3);
> -	} else {
> -		a_param = ad714x->sensor_val[second_before] *
> -			(second_before - hw->start_stage + 1) +
> -			ad714x->sensor_val[first_before] *
> -			(second_before - hw->start_stage + 2) +
> -			ad714x->sensor_val[highest] *
> -			(second_before - hw->start_stage + 3) +
> -			ad714x->sensor_val[first_after] *
> -			(first_after - hw->start_stage + 4) +
> -			ad714x->sensor_val[second_after] *
> -			(second_after - hw->start_stage + 5);
> -	}
> -	a_param *= WEIGHT_FACTOR;
> 
> -	b_param = ad714x->sensor_val[second_before] +
> +	a_param = ad714x->sensor_val[highest] *
> +		(highest - hw->start_stage) +
> +		ad714x->sensor_val[first_before] *
> +		(highest - hw->start_stage - 1) +
> +		ad714x->sensor_val[first_after] *
> +		(highest - hw->start_stage + 1);
> +	b_param = ad714x->sensor_val[highest] +
> 		ad714x->sensor_val[first_before] +
> -		ad714x->sensor_val[highest] +
> -		ad714x->sensor_val[first_after] +
> -		ad714x->sensor_val[second_after];
> -
> -	sw->pre_mean_value = sw->mean_value;
> -	sw->mean_value = a_param / b_param;
> -
> -	/* Calculate the offset */
> -
> -	if ((sw->pre_highest_stage == hw->end_stage) &&
> -			(sw->highest_stage == hw->start_stage))
> -		sw->pos_offset = sw->mean_value;
> -	else if ((sw->pre_highest_stage == hw->start_stage) &&
> -			(sw->highest_stage == hw->end_stage))
> -		sw->pos_offset = sw->pre_mean_value;
> -
> -	if (sw->pos_offset > OFFSET_POSITION_CLAMP)
> -		sw->pos_offset = OFFSET_POSITION_CLAMP;
> -
> -	/* Calculate the mean value without the offset */
> -
> -	sw->pre_mean_value_no_offset = sw->mean_value_no_offset;
> -	sw->mean_value_no_offset = sw->mean_value - sw->pos_offset;
> -	if (sw->mean_value_no_offset < 0)
> -		sw->mean_value_no_offset = 0;
> -
> -	/* Calculate ratio to scale down to NUMBER_OF_WANTED_POSITIONS */
> -
> -	if ((sw->pre_highest_stage == hw->end_stage) &&
> -			(sw->highest_stage == hw->start_stage))
> -		sw->pos_ratio = (sw->pre_mean_value_no_offset * 100) /
> -			hw->max_coord;
> -	else if ((sw->pre_highest_stage == hw->start_stage) &&
> -			(sw->highest_stage == hw->end_stage))
> -		sw->pos_ratio = (sw->mean_value_no_offset * 100) /
> -			hw->max_coord;
> -	sw->abs_pos = (sw->mean_value_no_offset * 100) / sw->pos_ratio;
> +		ad714x->sensor_val[first_after];
> +
> +	sw->abs_pos = ((hw->max_coord / (hw->end_stage - hw->start_stage)) *
> +			a_param) / b_param;
> +
> 	if (sw->abs_pos > hw->max_coord)
> 		sw->abs_pos = hw->max_coord;
> +	else if (sw->abs_pos < 0)
> +		sw->abs_pos = 0;
> }
> 
> static void ad714x_wheel_cal_flt_pos(struct ad714x_chip *ad714x, int idx)
> @@ -645,9 +575,8 @@ static void ad714x_wheel_state_machine(struct ad714x_chip *ad714x, int idx)
> 				ad714x_wheel_cal_highest_stage(ad714x, idx);
> 				ad714x_wheel_cal_abs_pos(ad714x, idx);
> 				ad714x_wheel_cal_flt_pos(ad714x, idx);
> -
> 				input_report_abs(sw->input, ABS_WHEEL,
> -					sw->abs_pos);
> +					sw->flt_pos);
> 				input_report_key(sw->input, BTN_TOUCH, 1);
> 			} else {
> 				/* When the user lifts off the sensor, configure
> -- 
> 1.6.0.2
> 
> 

