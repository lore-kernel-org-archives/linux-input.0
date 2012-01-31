From: Dima Zavin <dima@android.com>
Subject: Re: [PATCH] Input: evdev - fix variable initialisation
Date: Tue, 31 Jan 2012 13:40:42 -0800
Message-ID: <CAPz4a6DDwt2uEX1o3ULSESjnVqMA1gBWoFP27XCviaOXd1-fpw@mail.gmail.com>
References: <201201312224.46360.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46221 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755247Ab2AaVkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 16:40:43 -0500
Received: by yhoo21 with SMTP id o21so313724yho.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2012 13:40:43 -0800 (PST)
In-Reply-To: <201201312224.46360.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

ugh, thanks for fixing this.

On Tue, Jan 31, 2012 at 1:24 PM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> Commit 509f87c5f564 (evdev - do not block waiting for an event if fd
> is nonblock) created a code path were it was possible to use retval
> uninitialized.
>
> This could lead to the xorg evdev input driver getting corrupt data
> and refusing to work with log messages like
> =A0 =A0 =A0 =A0AUO-Pixcir touchscreen: Read error: Success
> =A0 =A0 =A0 =A0sg060_keys: Read error: Success
> =A0 =A0 =A0 =A0AUO-Pixcir touchscreen: Read error: Success
> =A0 =A0 =A0 =A0sg060_keys: Read error: Success
> (for drivers auo-pixcir-ts and gpio-keys).
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Dima Zavin <dima@android.com>

> ---
> This is obviously meant as a fix for 3.3
>
> =A0drivers/input/evdev.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 76457d5..afc166f 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -386,7 +386,7 @@ static ssize_t evdev_read(struct file *file, char=
 __user *buffer,
> =A0 =A0 =A0 =A0struct evdev_client *client =3D file->private_data;
> =A0 =A0 =A0 =A0struct evdev *evdev =3D client->evdev;
> =A0 =A0 =A0 =A0struct input_event event;
> - =A0 =A0 =A0 int retval;
> + =A0 =A0 =A0 int retval =3D 0;
>
> =A0 =A0 =A0 =A0if (count < input_event_size())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> --
> 1.7.2.3
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
