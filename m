From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom: Initialize and destroy LEDs for Intuos4 S tablets
Date: Sun, 3 Jun 2012 16:46:19 -0500
Message-ID: <CAGzDe_YQNQ=HHU9Nz3DyDfSp5dvouqp5DOXKPtVsMPPKTU-Qrg@mail.gmail.com>
References: <1338567707-9831-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61533 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754701Ab2FCVqU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 3 Jun 2012 17:46:20 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id d3so2575118lah.19
        for <linux-input@vger.kernel.org>; Sun, 03 Jun 2012 14:46:20 -0700 (PDT)
In-Reply-To: <1338567707-9831-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Fri, Jun 1, 2012 at 11:21 AM, Jason Gerecke <killertofu@gmail.com> w=
rote:
> This case appears to have been missed in the original commit.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =A0drivers/input/tablet/wacom_sys.c | =A0 =A02 ++
> =A01 file changed, 2 insertions(+)
>
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index b3a8bd3..d82d92d 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -855,6 +855,7 @@ static int wacom_initialize_leds(struct wacom *wa=
com)
>
> =A0 =A0 =A0 =A0/* Initialize default values */
> =A0 =A0 =A0 =A0switch (wacom->wacom_wac.features.type) {
> + =A0 =A0 =A0 case INTUOS4S:
> =A0 =A0 =A0 =A0case INTUOS4:
> =A0 =A0 =A0 =A0case INTUOS4L:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->led.select[0] =3D 0;
> @@ -908,6 +909,7 @@ static int wacom_initialize_leds(struct wacom *wa=
com)
> =A0static void wacom_destroy_leds(struct wacom *wacom)
> =A0{
> =A0 =A0 =A0 =A0switch (wacom->wacom_wac.features.type) {
> + =A0 =A0 =A0 case INTUOS4S:
> =A0 =A0 =A0 =A0case INTUOS4:
> =A0 =A0 =A0 =A0case INTUOS4L:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sysfs_remove_group(&wacom->intf->dev.k=
obj,
> --
> 1.7.10.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
