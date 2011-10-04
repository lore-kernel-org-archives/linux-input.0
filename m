From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH 1/4] input: wacom - Lower the LED luminance
Date: Tue, 4 Oct 2011 08:26:18 -0700
Message-ID: <CAF8JNhLmjU+X9=x_U9qvOsTtMmyWcTNNNOU9D0-49fsXcrH9Sw@mail.gmail.com>
References: <1317686570-29572-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59456 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932513Ab1JDP0T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Oct 2011 11:26:19 -0400
Received: by yxl31 with SMTP id 31so594021yxl.19
        for <linux-input@vger.kernel.org>; Tue, 04 Oct 2011 08:26:18 -0700 (PDT)
In-Reply-To: <1317686570-29572-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Eduard Hasenleithner <eduard@hasenleithner.at>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

All four patches in this set were reviewed-by and signed-off-by Eduard
Hasenleithner. Somehow I missed those tags in the other patches.

Ping

On Mon, Oct 3, 2011 at 5:02 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> The LED luminance level is normally lower when no button is pressed.
>
> Reviewed-by: Eduard Hasenleithner <eduard@hasenleithner.at>
> Tested-by: Eduard Hasenleithner <eduard@hasenleithner.at>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
> =A0Documentation/ABI/testing/sysfs-driver-wacom | =A0 =A03 ++-
> =A0drivers/input/tablet/wacom_sys.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A02 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-wacom b/Documenta=
tion/ABI/testing/sysfs-driver-wacom
> index dfe1d46..b1d5c17 100644
> --- a/Documentation/ABI/testing/sysfs-driver-wacom
> +++ b/Documentation/ABI/testing/sysfs-driver-wacom
> @@ -25,7 +25,8 @@ Contact: =A0 =A0 =A0linux-input@vger.kernel.org
> =A0Description:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Writing to this file sets the status L=
ED luminance (0..127)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0when the stylus does not touch the tab=
let surface, and no
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 button is pressed on the stylus.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 button is pressed on the stylus. This l=
uminance level is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 normally lower than the level when a bu=
tton is pressed.
>
> =A0What: =A0 =A0 =A0 =A0 =A0/sys/bus/usb/devices/<busnum>-<devnum>:<c=
fg>.<intf>/wacom_led/status1_luminance
> =A0Date: =A0 =A0 =A0 =A0 =A0August 2011
> diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/=
wacom_sys.c
> index 0eccf57..7facacc 100644
> --- a/drivers/input/tablet/wacom_sys.c
> +++ b/drivers/input/tablet/wacom_sys.c
> @@ -678,7 +678,7 @@ static int wacom_initialize_leds(struct wacom *wa=
com)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Initialize default values */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->led.select =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->led.llv =3D 30;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wacom->led.llv =3D 10;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->led.hlv =3D 20;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom->led.img_lum =3D 10;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_led_control(wacom);
> --
> 1.7.6
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
