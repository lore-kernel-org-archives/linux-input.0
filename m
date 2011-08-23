From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 1/2] Input: wacom_w8001 - implement open and close
Date: Tue, 23 Aug 2011 12:22:06 -0500
Message-ID: <CAGzDe_bUbbpg5g773zhX__ax65jfVcRYf1afd=GxMS4GS8ge-w@mail.gmail.com>
References: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:51593 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab1HWRWI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Aug 2011 13:22:08 -0400
Received: by iye16 with SMTP id 16so472095iye.1
        for <linux-input@vger.kernel.org>; Tue, 23 Aug 2011 10:22:07 -0700 (PDT)
In-Reply-To: <1313957747-22796-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Jaya Kumar <jayakumar.lkml@gmail.com>

I don't have one of these to test but anyways:

Acked-by: Chris Bagwell <chris@cnpbagwell.com>

I've been trying to slowing document the protocols for ISDV4 and USB
Wacom devices (http://sourceforge.net/apps/mediawiki/linuxwacom/index.p=
hp?title=3DISDV4_Protocol
for these ISDV4 ones if your interested).  During this, I was
comparing this version against the user land version of this driver
inside xf86-input-wacom.

xf86-input-wacom was doing a version of this patch so good to see
here.  The only other difference remaining is it also discards any
data on the line during startup to flush old data from after initial
STOP command and so that its sure of command/response sequence.

I do not know the serio well enough to know if it discards old data.
Even if it does not, the driver would handle old motion events OK and
the tiniest possibility an old touch query response on line when it
sends initial pen query.

Chris

On Sun, Aug 21, 2011 at 3:15 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Implement open() and close() methods for the input device so that we
> do not start the device unless there are users listening to the event=
s.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
