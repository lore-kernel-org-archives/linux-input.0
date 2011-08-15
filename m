From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2 hardware
Date: Mon, 15 Aug 2011 14:45:24 +0200
Message-ID: <4E4914E4.3000703@tudelft.nl>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:53528 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1HOMp2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 08:45:28 -0400
In-Reply-To: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, =?UTF-8?B?Sm9jZWx5biBIZXV6w6k=?= <jocelyn.heuze@gmail.com>

On 15-08-11 05:51, JJ Ding wrote:
> x, y values are actually 12-bit long. Also update protocol document t=
o reflect
> the change.
>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
> ---
> Hello List,
>
> We are working on adding support for newer elantech touchpad, which w=
e will
> submit shortly. Along the way I found this error in current code.
> This is a simple patch to correct x, y value ranges in v2 hardware.
> Please review, thank you.
Hello,

I'm glad to hear Elantech is planning to contribute directly to the=20
Linux driver!

In your patch, be careful to the Y axis. ETP_YMAX_V2 is actually set to=
=20
760. Compared to the 4095 that can be reached, there might be overflow.

Do all the v2 hardwares have the same resolution (in which case we can=20
leave 760, or 768)? Or is there a way to query their resolution?=20
Otherwise, we could just put ETP_YMAX_V2 =3D 4095, and ETP_YMIN_V2 =3D =
(4095=20
- 768), to be sure we cannot have an overflow. I think that's what is=20
done in the synaptics driver.

Dmitry, would this seems the correct way to set min/max in=20
input_set_abs_params()?

Cheers,
=C3=89ric


>
>   Documentation/input/elantech.txt |    8 ++++----
>   drivers/input/mouse/elantech.c   |    8 ++++----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/input/elantech.txt b/Documentation/input/e=
lantech.txt
> index db798af..bce9941 100644
> --- a/Documentation/input/elantech.txt
> +++ b/Documentation/input/elantech.txt
> @@ -389,14 +389,14 @@ byte 0:
>   byte 1:
>
>      bit   7   6   5   4   3   2   1   0
> -	 p7  p6  p5  p4  .  x10 x9  x8
> +	 p7  p6  p5  p4 x11 x10 x9  x8
>
>   byte 2:
>
>      bit   7   6   5   4   3   2   1   0
>   	 x7  x6  x5  x4  x3  x2  x1  x0
>
> -         x10..x0 =3D absolute x value (horizontal)
> +         x11..x0 =3D absolute x value (horizontal)
>
>   byte 3:
>
> @@ -420,7 +420,7 @@ byte 3:
>   byte 4:
>
>      bit   7   6   5   4   3   2   1   0
> -        p3  p1  p2  p0   .   .  y9  y8
> +        p3  p1  p2  p0  y11 y10 y9  y8
>
>   	 p7..p0 =3D pressure (not EF113)
>
> @@ -429,7 +429,7 @@ byte 5:
>      bit   7   6   5   4   3   2   1   0
>           y7  y6  y5  y4  y3  y2  y1  y0
>
> -         y9..y0 =3D absolute y value (vertical)
> +         y11..y0 =3D absolute y value (vertical)
>
>
>   4.2.2 Two finger touch
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 3250356..da161da 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -290,15 +290,15 @@ static void elantech_report_absolute_v2(struct =
psmouse *psmouse)
>   		/* pass through... */
>   	case 1:
>   		/*
> -		 * byte 1:  .   .   .   .   .  x10 x9  x8
> +		 * byte 1:  .   .   .   .  x11 x10 x9  x8
>   		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
>   		 */
> -		x1 =3D ((packet[1]&  0x07)<<  8) | packet[2];
> +		x1 =3D ((packet[1]&  0x0f)<<  8) | packet[2];
>   		/*
> -		 * byte 4:  .   .   .   .   .   .  y9  y8
> +		 * byte 4:  .   .   .   .  y11 y10 y9  y8
>   		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>   		 */
> -		y1 =3D ETP_YMAX_V2 - (((packet[4]&  0x03)<<  8) | packet[5]);
> +		y1 =3D ETP_YMAX_V2 - (((packet[4]&  0x0f)<<  8) | packet[5]);
>
>   		input_report_abs(dev, ABS_X, x1);
>   		input_report_abs(dev, ABS_Y, y1);

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
