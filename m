From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/3] Input: synaptics-rmi4 - report sensor resolution
Date: Wed, 9 Apr 2014 14:21:14 -0400
Message-ID: <CAN+gG=G74ESnt_qwiKyBWWoEm3uUB6Ly==1NfHc1wE2zpkm87Q@mail.gmail.com>
References: <1396300267-5108-1-git-send-email-cheiny@synaptics.com>
	<1396300267-5108-3-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:51322 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847AbaDISVQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 14:21:16 -0400
Received: by mail-lb0-f169.google.com with SMTP id q8so1458966lbi.14
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 11:21:14 -0700 (PDT)
In-Reply-To: <1396300267-5108-3-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 31, 2014 at 5:11 PM, Christopher Heiny <cheiny@synaptics.com> wrote:
> Reports the sensor resolution by reading the size of the sensor
> from F11 query registers or from the platform data if the firmware
> does not contain the appropriate query registers.
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

Looks fine to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_f11.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
>  include/linux/rmi.h          |  2 ++
>  2 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index ee47b7e..9c682f0 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -408,6 +408,10 @@ struct f11_2d_sensor_queries {
>         u8 clickpad_props;
>         u8 mouse_buttons;
>         bool has_advanced_gestures;
> +
> +       /* Query 15 - 18 */
> +       u16 x_sensor_size_mm;
> +       u16 y_sensor_size_mm;
>  };
>
>  /* Defs for Ctrl0. */
> @@ -518,6 +522,8 @@ struct f11_2d_sensor {
>         char input_phys[NAME_BUFFER_SIZE];
>         u8 report_abs;
>         u8 report_rel;
> +       u8 x_mm;
> +       u8 y_mm;
>  };
>
>  /** Data pertaining to F11 in general.  For per-sensor data, see struct
> @@ -1064,7 +1070,7 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
>                 query_size++;
>         }
>
> -       if (f11->has_query12 && sensor_query->has_info2) {
> +       if (sensor_query->has_info2) {
>                 rc = rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
>                 if (rc < 0)
>                         return rc;
> @@ -1085,6 +1091,20 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
>                 query_size++;
>         }
>
> +       if (sensor_query->has_physical_props) {
> +               rc = rmi_read_block(rmi_dev, query_base_addr
> +                       + query_size, query_buf, 4);
> +               if (rc < 0)
> +                       return rc;
> +
> +               sensor_query->x_sensor_size_mm =
> +                       (query_buf[0] | (query_buf[1] << 8)) / 10;
> +               sensor_query->y_sensor_size_mm =
> +                       (query_buf[2] | (query_buf[3] << 8)) / 10;
> +
> +               query_size += 4;
> +       }
> +
>         return query_size;
>  }
>
> @@ -1106,6 +1126,7 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
>                         ((f11->dev_controls.ctrl0_9[9] & 0x0F) << 8);
>         u16 x_min, x_max, y_min, y_max;
>         unsigned int input_flags;
> +       int res_x, res_y;
>
>         /* We assume touchscreen unless demonstrably a touchpad or specified
>          * as a touchpad in the platform data
> @@ -1156,6 +1177,18 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
>                         x_min, x_max, 0, 0);
>         input_set_abs_params(input, ABS_MT_POSITION_Y,
>                         y_min, y_max, 0, 0);
> +
> +       if (sensor->x_mm && sensor->y_mm) {
> +               res_x = (x_max - x_min) / sensor->x_mm;
> +               res_y = (y_max - y_min) / sensor->y_mm;
> +
> +               input_abs_set_res(input, ABS_X, res_x);
> +               input_abs_set_res(input, ABS_Y, res_y);
> +
> +               input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
> +               input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
> +       }
> +
>         if (!sensor->type_a)
>                 input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
>         if (IS_ENABLED(CONFIG_RMI4_F11_PEN) && sensor->sens_query.has_pen)
> @@ -1252,6 +1285,14 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>                         pdata->f11_sensor_data->axis_align;
>                 sensor->type_a = pdata->f11_sensor_data->type_a;
>
> +               if (sensor->sens_query.has_physical_props) {
> +                       sensor->x_mm = sensor->sens_query.x_sensor_size_mm;
> +                       sensor->y_mm = sensor->sens_query.y_sensor_size_mm;
> +               } else if (pdata->f11_sensor_data) {
> +                       sensor->x_mm = pdata->f11_sensor_data->x_mm;
> +                       sensor->y_mm = pdata->f11_sensor_data->y_mm;
> +               }
> +
>                 if (sensor->sensor_type == rmi_f11_sensor_default)
>                         sensor->sensor_type =
>                                 pdata->f11_sensor_data->sensor_type;
> diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> index 164b813..ca35b2f 100644
> --- a/include/linux/rmi.h
> +++ b/include/linux/rmi.h
> @@ -95,6 +95,8 @@ struct rmi_f11_sensor_data {
>         struct rmi_f11_2d_axis_alignment axis_align;
>         bool type_a;
>         enum rmi_f11_sensor_type sensor_type;
> +       int x_mm;
> +       int y_mm;
>         int disable_report_mask;
>  };
>
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
