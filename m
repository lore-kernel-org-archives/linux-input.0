From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] Input: wacom_w8001 - implement open and close
Date: Tue, 23 Aug 2011 14:23:40 -0700
Message-ID: <CAF8JNhKFez2UQu5yLoePVZrwVayc9wZHm-JLtxAxkfPEJckUbA@mail.gmail.com>
References: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
	<CAF8JNhJ+1=7J3e=Ohs-cpQVwkbYgqOfepxGt=MtWjXFq7=eHDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33519 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183Ab1HWVXk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 17:23:40 -0400
Received: by gwaa12 with SMTP id a12so423291gwa.19
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 14:23:40 -0700 (PDT)
In-Reply-To: <CAF8JNhJ+1=7J3e=Ohs-cpQVwkbYgqOfepxGt=MtWjXFq7=eHDQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

On Sun, Aug 21, 2011 at 1:15 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Implement open() and close() methods for the input device so that we
> do not start the device unless there are users listening to the event=
s.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


Tested-by: Ping Cheng <pingc@wacom.com> for the series.

I can not tell if the driver doing what it claimed in the commit
comment or not since I didn't trace into the code. As far as my
testing goes, the driver works as it was; it works as usual after
suspend and resume.

Ping

>
> ---
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 21 +++++++++++++++++=
+++-
> =A01 files changed, 20 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index c14412e..5ece6c1 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -367,6 +367,20 @@ static int w8001_command(struct w8001 *w8001, un=
signed char command,
> =A0 =A0 =A0 =A0return rc;
> =A0}
>
> +static int w8001_open(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct w8001 *w8001 =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 return w8001_command(w8001, W8001_CMD_START, false);
> +}
> +
> +static void w8001_close(struct input_dev *dev)
> +{
> + =A0 =A0 =A0 struct w8001 *w8001 =3D input_get_drvdata(dev);
> +
> + =A0 =A0 =A0 w8001_command(w8001, W8001_CMD_STOP, false);
> +}
> +
> =A0static int w8001_setup(struct w8001 *w8001)
> =A0{
> =A0 =A0 =A0 =A0struct input_dev *dev =3D w8001->dev;
> @@ -474,7 +488,7 @@ static int w8001_setup(struct w8001 *w8001)
>
> =A0 =A0 =A0 =A0strlcat(w8001->name, " Touchscreen", sizeof(w8001->nam=
e));
>
> - =A0 =A0 =A0 return w8001_command(w8001, W8001_CMD_START, false);
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0/*
> @@ -534,6 +548,11 @@ static int w8001_connect(struct serio *serio, st=
ruct serio_driver *drv)
> =A0 =A0 =A0 =A0input_dev->id.version =3D 0x0100;
> =A0 =A0 =A0 =A0input_dev->dev.parent =3D &serio->dev;
>
> + =A0 =A0 =A0 input_dev->open =3D w8001_open;
> + =A0 =A0 =A0 input_dev->close =3D w8001_close;
> +
> + =A0 =A0 =A0 input_set_drvdata(input_dev, w8001);
> +
> =A0 =A0 =A0 =A0err =3D input_register_device(w8001->dev);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;
> --
> 1.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
