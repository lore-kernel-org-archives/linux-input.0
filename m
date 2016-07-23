From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: Re: [PATCH] Input: xpad - fix wireless 360 controller breaking after suspend
Date: Sat, 23 Jul 2016 12:15:27 +0200
Message-ID: <CA+b0ujckSVMOVK4+Kc4gMrg3hVZ5mEwkPY=a5DwhHm+Qi-yiEg@mail.gmail.com>
References: <0635c1d0-7572-bac9-99cc-7a0db54c9013@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32970 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcGWKPs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Jul 2016 06:15:48 -0400
Received: by mail-vk0-f66.google.com with SMTP id s189so10715181vkh.0
        for <linux-input@vger.kernel.org>; Sat, 23 Jul 2016 03:15:47 -0700 (PDT)
In-Reply-To: <0635c1d0-7572-bac9-99cc-7a0db54c9013@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

If you blame the line, you will see that it was introduced to fix the
exact problem you are describing.
Maybe the used USB controller is relevant or something changed in USB
core meanwhile.
I will test whether resume works for me without that line as well and
report back.

Cameron Gutman <aicommander@gmail.com> schrieb am Sa., 23. Juli 2016
um 10:27 Uhr:
>
> Suspending and resuming the system can sometimes cause the out
> URB to get hung after a reset_resume. This causes LED setting
> and force feedback to break on resume. To avoid this, just drop
> the reset_resume callback so the USB core rebinds xpad to the
> wireless pads on resume if a reset happened.
>
> A nice side effect of this change is the LED ring on wireless
> controllers is now set correctly on system resume.
>
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/input/joystick/xpad.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index a529a45..843054a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1626,7 +1626,6 @@ static struct usb_driver xpad_driver = {
>         .disconnect     = xpad_disconnect,
>         .suspend        = xpad_suspend,
>         .resume         = xpad_resume,
> -       .reset_resume   = xpad_resume,
>         .id_table       = xpad_table,
>  };
>
> --
> 2.7.4
