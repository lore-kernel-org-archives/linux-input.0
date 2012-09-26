From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] atmel_mxt: simplify mxt_dump_message
Date: Wed, 26 Sep 2012 22:18:20 +0800
Message-ID: <CAGS+omCi2o0GJzxjEYfuyvBpDLXnomxPgW==u6Hg5etpCSm34A@mail.gmail.com>
References: <1348657555-8226-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42676 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2IZOSl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 26 Sep 2012 10:18:41 -0400
Received: by qchd3 with SMTP id d3so147967qch.19
        for <linux-input@vger.kernel.org>; Wed, 26 Sep 2012 07:18:41 -0700 (PDT)
In-Reply-To: <1348657555-8226-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Sep 26, 2012 at 7:05 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This patch applies %*ph to print small buffer and marks function as inline.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |   10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index e92615d..211bfb4 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -317,13 +317,11 @@ static bool mxt_object_writable(unsigned int type)
>         }
>  }
>
> -static void mxt_dump_message(struct device *dev,
> -                            struct mxt_message *message)
> +static inline void mxt_dump_message(struct device *dev,
> +                                   struct mxt_message *message)
>  {
> -       dev_dbg(dev, "reportid: %u\tmessage: %02x %02x %02x %02x %02x %02x %02x\n",
> -               message->reportid, message->message[0], message->message[1],
> -               message->message[2], message->message[3], message->message[4],
> -               message->message[5], message->message[6]);
> +       dev_dbg(dev, "reportid: %u\tmessage: %*ph\n",
> +               message->reportid, 7, message->message);
>  }
>
>  static int mxt_check_bootloader(struct i2c_client *client,
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
