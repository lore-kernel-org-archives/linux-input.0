From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] HID: wacom - PAD is independent with pen/touch
Date: Tue, 25 Nov 2014 11:11:24 -0800
Message-ID: <CAF8JNh+MrEPKLQ9-KPW3T25zT_AFs9jh2F1+d9ba=xWFxwsF6Q@mail.gmail.com>
References: <1416529872-3128-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:60906 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbaKYTLZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 14:11:25 -0500
Received: by mail-lb0-f169.google.com with SMTP id p9so1168077lbv.0
        for <linux-input@vger.kernel.org>; Tue, 25 Nov 2014 11:11:24 -0800 (PST)
In-Reply-To: <1416529872-3128-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi Jiri,

Please don't forget to merge this patch. It fixes a bad pointer issue...

Thanks,

Ping

On Thu, Nov 20, 2014 at 4:31 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> PAD can be on pen interface (Intuos Pro and Cintiq series) or touch
> interface (Bamboo PT and Intuos PT series) or its own interface
> (Bamboo pen-only and Intuos Pen M/S). We need to mark it independently.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by:  Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/hid/wacom_sys.c | 8 +++++---
>  drivers/hid/wacom_wac.h | 1 +
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 68b6cd6..eb55316 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -1135,7 +1135,7 @@ static void wacom_clean_inputs(struct wacom *wacom)
>                         input_free_device(wacom->wacom_wac.input);
>         }
>         if (wacom->wacom_wac.pad_input) {
> -               if (wacom->wacom_wac.input_registered)
> +               if (wacom->wacom_wac.pad_registered)
>                         input_unregister_device(wacom->wacom_wac.pad_input);
>                 else
>                         input_free_device(wacom->wacom_wac.pad_input);
> @@ -1162,6 +1162,7 @@ static int wacom_register_inputs(struct wacom *wacom)
>                 error = input_register_device(input_dev);
>                 if (error)
>                         return error;
> +               wacom_wac->input_registered = true;
>         }
>
>         error = wacom_setup_pad_input_capabilities(pad_input_dev, wacom_wac);
> @@ -1174,22 +1175,23 @@ static int wacom_register_inputs(struct wacom *wacom)
>                 error = input_register_device(pad_input_dev);
>                 if (error)
>                         goto fail_register_pad_input;
> +               wacom_wac->pad_registered = true;
>
>                 error = wacom_initialize_leds(wacom);
>                 if (error)
>                         goto fail_leds;
>         }
>
> -       wacom_wac->input_registered = true;
> -
>         return 0;
>
>  fail_leds:
>         input_unregister_device(pad_input_dev);
>         pad_input_dev = NULL;
> +       wacom_wac->pad_registered = false;
>  fail_register_pad_input:
>         input_unregister_device(input_dev);
>         wacom_wac->input = NULL;
> +       wacom_wac->input_registered = false;
>         return error;
>  }
>
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 0f0b85e..128cbb3 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -183,6 +183,7 @@ struct wacom_wac {
>         struct input_dev *input;
>         struct input_dev *pad_input;
>         bool input_registered;
> +       bool pad_registered;
>         int pid;
>         int battery_capacity;
>         int num_contacts_left;
> --
> 1.9.1
>
