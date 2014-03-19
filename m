From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/3] Input: synaptics-rmi4 - add capabilities for touchpads
Date: Wed, 19 Mar 2014 10:29:34 -0400
Message-ID: <5329A9CE.1080504@redhat.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933739AbaCSOba (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2014 10:31:30 -0400
In-Reply-To: <1395191031-3144-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi Chris,

On 03/18/2014 09:03 PM, Christopher Heiny wrote:
> When the device is a touchpad additional capabilities need to
> be set and reported.
>

We have a problem here. While this patch would have been fine in the 
pre-v3.8 era, it is not true anymore.
However, the current branch where synaptics-rmi4 is attached is v3.4.

So if you use the right API (the current one), it will not compile :(

Dmitry, would it be possible to update the branch to at least v3.8 to 
get the new input-mt API? (if the Synaptics guys are ok).

> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Acked-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
>
> ---
>   drivers/input/rmi4/rmi_f11.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 8709abe..07044d79 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -688,6 +688,9 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
>   	/* MT sync between fingers */
>   	if (sensor->type_a)
>   		input_mt_sync(sensor->input);
> +
> +	if (sensor->sensor_type == rmi_f11_sensor_touchpad)
> +		input_mt_report_pointer_emulation(sensor->input, true);

In recent kernels, you just need to set the input mt flags 
INPUT_MT_POINTER when initializing the slots, and you just need to call 
input_mt_sync_frame at the end of the report. The mt lib will take care 
of the pointer emulation, finger count, etc...

(see commit 55e49089f4589908eb688742d2d7eff33b74ac78)

>   }
>
>   static void rmi_f11_finger_handler(struct f11_data *f11,
> @@ -717,7 +720,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
>   		if (sensor->data.rel_pos)
>   			rmi_f11_rel_pos_report(sensor, i);
>   	}
> -	input_mt_sync(sensor->input);

This particular line is a bug in the current implementation. Only 
multitouch protocol A devices should use input_mt_sync.

> +	input_report_key(sensor->input, BTN_TOUCH, finger_pressed_count);

This is already handled by input_mt_sync_frame.

>   	input_sync(sensor->input);
>   }
>
> @@ -1137,6 +1140,9 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
>   	dev_dbg(&fn->dev, "Set ranges X=[%d..%d] Y=[%d..%d].",
>   			x_min, x_max, y_min, y_max);
>
> +	input_set_abs_params(input, ABS_X, x_min, x_max, 0, 0);
> +	input_set_abs_params(input, ABS_Y, y_min, y_max, 0, 0);
> +

There is no need (and it's not the way you should do) to setup the ABS_X 
and ABS_Y (and ABS_PRESSURE) axis if you call input_mt_init_slot after 
having set all the input mt axis.

As a general rule, set all the mt axis, then call input_mt_init_slot. It 
will handle the single touch emulation for you in a better way (like 
fuzz should not be set for ABS_X|Y otherwise it will be called twice).

>   	input_set_abs_params(input, ABS_MT_PRESSURE, 0,
>   			DEFAULT_MAX_ABS_MT_PRESSURE, 0, 0);
>   	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
> @@ -1374,6 +1380,15 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
>   		set_bit(BTN_RIGHT, input_dev_mouse->keybit);
>   	}
>
> +	if (sensor->sensor_type == rmi_f11_sensor_touchpad) {
> +		set_bit(BTN_TOOL_FINGER, input_dev->keybit);
> +		set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
> +		set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
> +		set_bit(BTN_TOOL_QUADTAP, input_dev->keybit);
> +		set_bit(BTN_TOOL_QUINTTAP, input_dev->keybit);
> +	}
> +

This is already handled by input_mt_init_slot with the flag 
INPUT_MT_POINTER.

Cheers,
Benjamin

> +
>   	return 0;
>
>   error_unregister:
>
