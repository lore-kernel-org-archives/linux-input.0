From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] drivers: hid: hid-wiimote-modules: fixed code style errors
Date: Wed, 5 Feb 2014 01:18:58 +0100
Message-ID: <CANq1E4SZz3oUmOqoN7iqF4+gdMDCAf_jwOK8smbS2+vUh51Brg@mail.gmail.com>
References: <1391558068-10715-1-git-send-email-sebastiankeller@fastmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:57632 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbaBEAS6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Feb 2014 19:18:58 -0500
Received: by mail-ig0-f181.google.com with SMTP id j1so370838iga.2
        for <linux-input@vger.kernel.org>; Tue, 04 Feb 2014 16:18:58 -0800 (PST)
In-Reply-To: <1391558068-10715-1-git-send-email-sebastiankeller@fastmail.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Keller <sebastiankeller@fastmail.net>
Cc: David Herrmann <dh.herrmann@googlemail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Wed, Feb 5, 2014 at 12:54 AM, Sebastian Keller
<sebastiankeller@fastmail.net> wrote:
> Realigned the switch case blocks
> Added a space to an (void *) cast
>
> Signed-off-by: Sebastian Keller <sebastiankeller@fastmail.net>
> ---
>  drivers/hid/hid-wiimote-modules.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
> index 6b61f01..1882bce 100644
> --- a/drivers/hid/hid-wiimote-modules.c
> +++ b/drivers/hid/hid-wiimote-modules.c
> @@ -353,7 +353,7 @@ static int wiimod_led_probe(const struct wiimod_ops *ops,
>         if (!led)
>                 return -ENOMEM;
>
> -       name = (void*)&led[1];
> +       name = (void *)&led[1];

We don't put spaces there if it's a cast. We only do that for type/var
definitions.

>         snprintf(name, namesz, "%s:blue:p%lu", dev_name(dev), ops->arg);
>         led->name = name;
>         led->brightness = 0;
> @@ -689,15 +689,15 @@ static int wiimod_ir_change(struct wiimote_data *wdata, __u16 mode)
>
>         /* put IR cam into desired state */
>         switch (mode) {
> -               case WIIPROTO_FLAG_IR_FULL:
> -                       format = 5;
> -                       break;
> -               case WIIPROTO_FLAG_IR_EXT:
> -                       format = 3;
> -                       break;
> -               case WIIPROTO_FLAG_IR_BASIC:
> -                       format = 1;
> -                       break;
> +       case WIIPROTO_FLAG_IR_FULL:
> +               format = 5;
> +               break;
> +       case WIIPROTO_FLAG_IR_EXT:
> +               format = 3;
> +               break;
> +       case WIIPROTO_FLAG_IR_BASIC:
> +               format = 1;
> +               break;

That one looks good. Can you resend without the cast-change? Feel free
to add my "Reviewed-by: David Herrmann <dh.herrmann@gmail.com>".

Thanks
David

>         }
>         ret = wiimote_cmd_write(wdata, 0xb00033, &format, sizeof(format));
>         if (ret)
> --
> 1.8.5.3
>
