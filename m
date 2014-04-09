From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 1/3] Input: synaptics-rmi4 - add F11 capabilities for touchpads
Date: Wed, 9 Apr 2014 14:13:16 -0400
Message-ID: <CAN+gG=GC352rASHvqGgjPXNJEmgnnFKzfoMBMXhEeM4k28amMg@mail.gmail.com>
References: <1396300267-5108-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:65042 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933291AbaDISNT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Apr 2014 14:13:19 -0400
Received: by mail-la0-f46.google.com with SMTP id hr17so1460255lab.33
        for <linux-input@vger.kernel.org>; Wed, 09 Apr 2014 11:13:17 -0700 (PDT)
In-Reply-To: <1396300267-5108-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Mar 31, 2014 at 5:11 PM, Christopher Heiny <cheiny@synaptics.com> wrote:
> When the device is a touchpad additional capabilities need to
> be set and reported.
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
>  drivers/input/rmi4/rmi_f11.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
> index 8709abe..92eac8a 100644
> --- a/drivers/input/rmi4/rmi_f11.c
> +++ b/drivers/input/rmi4/rmi_f11.c
> @@ -717,7 +717,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
>                 if (sensor->data.rel_pos)
>                         rmi_f11_rel_pos_report(sensor, i);
>         }
> -       input_mt_sync(sensor->input);
> +       input_mt_sync_frame(sensor->input);

Small nitpicking here: I think we should add an if (!sensor->type_a)
before this statement.
However, it should still be harmless for protocol A device because
input->mt is null.

So Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com> for this one.

Also I wanted to apologize regarding the rebase I asked for in the v1,
it looks like I hallucinated because the synaptics-rmi4 branch is
plugged to a v3.7-rc+ and contains the multitouch changes I said that
were not in.

Cheers,
Benjamin

>         input_sync(sensor->input);
>  }
>
> @@ -1104,13 +1104,10 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
>         /* We assume touchscreen unless demonstrably a touchpad or specified
>          * as a touchpad in the platform data
>          */
> -       if (sensor->sensor_type == rmi_f11_sensor_touchpad ||
> -                       (sensor->sens_query.has_info2 &&
> -                               !sensor->sens_query.is_clear))
> -               input_flags = INPUT_PROP_POINTER;
> +       if (sensor->sensor_type == rmi_f11_sensor_touchpad)
> +               input_flags = INPUT_MT_POINTER;
>         else
> -               input_flags = INPUT_PROP_DIRECT;
> -       set_bit(input_flags, input->propbit);
> +               input_flags = INPUT_MT_DIRECT;
>
>         if (sensor->axis_align.swap_axes) {
>                 int temp = device_x_max;
> @@ -1220,11 +1217,20 @@ static int rmi_f11_initialize(struct rmi_function *fn)
>                 return rc;
>         }
>
> +       if (sensor->sens_query.has_info2) {
> +               if (sensor->sens_query.is_clear)
> +                       sensor->sensor_type = rmi_f11_sensor_touchscreen;
> +               else
> +                       sensor->sensor_type = rmi_f11_sensor_touchpad;
> +       }
> +
>         if (pdata->f11_sensor_data) {
>                 sensor->axis_align =
>                         pdata->f11_sensor_data->axis_align;
>                 sensor->type_a = pdata->f11_sensor_data->type_a;
> -               sensor->sensor_type =
> +
> +               if (sensor->sensor_type == rmi_f11_sensor_default)
> +                       sensor->sensor_type =
>                                 pdata->f11_sensor_data->sensor_type;
>         }
>
> @@ -1490,6 +1496,7 @@ static struct rmi_function_handler rmi_f11_handler = {
>  module_rmi_driver(rmi_f11_handler);
>
>  MODULE_AUTHOR("Christopher Heiny <cheiny@synaptics.com");
> +MODULE_AUTHOR("Andrew Duggan <aduggan@synaptics.com");
>  MODULE_DESCRIPTION("RMI F11 module");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(RMI_DRIVER_VERSION);
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
