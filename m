From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 3/3] Input: synaptics-rmi4 - report sensor resolution
Date: Wed, 19 Mar 2014 11:11:20 -0400
Message-ID: <5329B398.4070005@redhat.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com> <1395191031-3144-3-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63595 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933897AbaCSPMI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2014 11:12:08 -0400
In-Reply-To: <1395191031-3144-3-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>



On 03/18/2014 09:03 PM, Christopher Heiny wrote:
> Reports the sensor resolution by reading the size of the sensor
> from F11 query registers or from the platform data if the firmware
> does not contain the appropriate query registers.

Hehe, nice, I was just wondering if it was possible to retrieve this 
info from the FW. :)

>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> Acked-by: Christopher Heiny <cheiny@synaptics.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Linux Walleij <linus.walleij@linaro.org>
> Cc: David Herrmann <dh.herrmann@gmail.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
>
> ---
>   drivers/input/rmi4/rmi_f11.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/rmi.h          |  2 ++
>   2 files changed, 54 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index f5b8b71..f2a6f5f 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -408,6 +408,10 @@ struct f11_2d_sensor_queries {
>   	u8 clickpad_props;
>   	u8 mouse_buttons;
>   	bool has_advanced_gestures;
> +
> +	/* Query 15 - 18 */
> +	u16 x_sensor_size_mm;
> +	u16 y_sensor_size_mm;
>   };
>
>   /* Defs for Ctrl0. */
> @@ -520,6 +524,8 @@ struct f11_2d_sensor {
>   	struct rmi_function *fn;
>   	char input_phys[NAME_BUFFER_SIZE];
>   	char input_phys_mouse[NAME_BUFFER_SIZE];
> +	u8 x_mm;
> +	u8 y_mm;
>   	u8 report_abs;
>   	u8 report_rel;
>   };
> @@ -1098,6 +1104,20 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
>   		query_size++;
>   	}
>
> +	if (f11->has_query12 && sensor_query->has_physical_props) {

sensor->has_physical_props is only set to true if f11->has_query12 is 
true (the initial struct is zero-allocated).

So we can safely skip the test against f11->has_query12

> +		rc = rmi_read_block(rmi_dev, query_base_addr
> +			+ query_size, query_buf, ARRAY_SIZE(query_buf));
> +		if (rc < 0)
> +			return rc;
> +
> +		sensor_query->x_sensor_size_mm =
> +			(query_buf[0] | (query_buf[1] << 8)) / 10;
> +		sensor_query->y_sensor_size_mm =
> +			(query_buf[2] | (query_buf[3] << 8)) / 10;
> +
> +		query_size += 4;

should be ARRAY_SIZE(query_buf). Or maybe we should use 4 in the 
rmi_read_block call (jsut in case someone changes the size of buf).

> +	}
> +
>   	return query_size;
>   }
>
> @@ -1119,6 +1139,7 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
>   			((f11->dev_controls.ctrl0_9[9] & 0x0F) << 8);
>   	u16 x_min, x_max, y_min, y_max;
>   	unsigned int input_flags;
> +	int res_x, res_y;
>
>   	/* We assume touchscreen unless demonstrably a touchpad or specified
>   	 * as a touchpad in the platform data
> @@ -1175,6 +1196,18 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
>   			x_min, x_max, 0, 0);
>   	input_set_abs_params(input, ABS_MT_POSITION_Y,
>   			y_min, y_max, 0, 0);
> +
> +	if (sensor->x_mm && sensor->y_mm) {
> +		res_x = (x_max - x_min) / sensor->x_mm;
> +		res_y = (y_max - y_min) / sensor->y_mm;
> +
> +		input_abs_set_res(input, ABS_X, res_x);
> +		input_abs_set_res(input, ABS_Y, res_y);
> +
> +		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
> +		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
> +	}
> +
>   	if (!sensor->type_a)
>   		input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
>   	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) && sensor->sens_query.has_pen)
> @@ -1261,8 +1294,26 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>   		sensor->axis_align =
>   			pdata->f11_sensor_data->axis_align;
>   		sensor->type_a = pdata->f11_sensor_data->type_a;
> -		sensor->sensor_type =
> +
> +		if (sensor->sens_query.has_info2) {
> +			if (sensor->sens_query.is_clear)
> +				sensor->sensor_type =
> +					rmi_f11_sensor_touchscreen;
> +			else
> +				sensor->sensor_type = rmi_f11_sensor_touchpad;
> +		} else {
> +			sensor->sensor_type =
>   				pdata->f11_sensor_data->sensor_type;

These few lines above are not related to the current commit. Please 
split this.

> +		}
> +
> +		if (f11->has_query12
> +			&& sensor->sens_query.has_physical_props) {

again, f11->has_query12 can be skipped

> +			sensor->x_mm = sensor->sens_query.x_sensor_size_mm;
> +			sensor->y_mm = sensor->sens_query.y_sensor_size_mm;
> +		} else {
> +			sensor->x_mm = pdata->f11_sensor_data->x_mm;
> +			sensor->y_mm = pdata->f11_sensor_data->y_mm;

there is a test regarding pdata->f11_sensor_data in 
rmi_f11_initialize(). So I guess this pointer might be null, and you 
will get an oops.

Cheers,
Benjamin

> +		}
>
>   		if (sensor->sens_query.has_abs)
>   			sensor->report_abs = sensor->report_abs
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index a0d0187..9139873 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -96,6 +96,8 @@ struct rmi_f11_sensor_data {
>   	struct rmi_f11_2d_axis_alignment axis_align;
>   	bool type_a;
>   	enum rmi_f11_sensor_type sensor_type;
> +	int x_mm;
> +	int y_mm;
>   	int disable_report_mask;
>   };
>
>
