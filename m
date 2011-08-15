From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2 hardware
Date: Mon, 15 Aug 2011 13:25:55 +0800
Message-ID: <CAGS+omB9MCrbHM149iwCKzBzgMuea-V7wDfy0YuVHGwDbvfsDg@mail.gmail.com>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:57834 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555Ab1HOF0T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Aug 2011 01:26:19 -0400
Received: from hpaq3.eem.corp.google.com (hpaq3.eem.corp.google.com [172.25.149.3])
	by smtp-out.google.com with ESMTP id p7F5QIIR020507
	for <linux-input@vger.kernel.org>; Sun, 14 Aug 2011 22:26:18 -0700
Received: from iyn15 (iyn15.prod.google.com [10.241.52.79])
	by hpaq3.eem.corp.google.com with ESMTP id p7F5QFjU002876
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Sun, 14 Aug 2011 22:26:16 -0700
Received: by iyn15 with SMTP id 15so7141260iyn.20
        for <linux-input@vger.kernel.org>; Sun, 14 Aug 2011 22:26:15 -0700 (PDT)
In-Reply-To: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>

Hi JJ,

On Mon, Aug 15, 2011 at 11:51 AM, JJ Ding <jj_ding@emc.com.tw> wrote:
>
> x, y values are actually 12-bit long. Also update protocol document to reflect
> the change.
>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
> Hello List,
>
> We are working on adding support for newer elantech touchpad, which we will
> submit shortly. Along the way I found this error in current code.
> This is a simple patch to correct x, y value ranges in v2 hardware.
> Please review, thank you.
>
>  Documentation/input/elantech.txt |    8 ++++----
>  drivers/input/mouse/elantech.c   |    8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/input/elantech.txt b/Documentation/input/elantech.txt
> index db798af..bce9941 100644
> --- a/Documentation/input/elantech.txt
> +++ b/Documentation/input/elantech.txt
> @@ -389,14 +389,14 @@ byte 0:
>  byte 1:
>
>    bit   7   6   5   4   3   2   1   0
> -        p7  p6  p5  p4  .  x10 x9  x8
> +        p7  p6  p5  p4 x11 x10 x9  x8
>
>  byte 2:
>
>    bit   7   6   5   4   3   2   1   0
>         x7  x6  x5  x4  x3  x2  x1  x0
>
> -         x10..x0 = absolute x value (horizontal)
> +         x11..x0 = absolute x value (horizontal)
>
>  byte 3:
>
> @@ -420,7 +420,7 @@ byte 3:
>  byte 4:
>
>    bit   7   6   5   4   3   2   1   0
> -        p3  p1  p2  p0   .   .  y9  y8
> +        p3  p1  p2  p0  y11 y10 y9  y8
>
>         p7..p0 = pressure (not EF113)
>
> @@ -429,7 +429,7 @@ byte 5:
>    bit   7   6   5   4   3   2   1   0
>         y7  y6  y5  y4  y3  y2  y1  y0
>
> -         y9..y0 = absolute y value (vertical)
> +         y11..y0 = absolute y value (vertical)
>
>
>  4.2.2 Two finger touch
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 3250356..da161da 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -290,15 +290,15 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
>                /* pass through... */
>        case 1:
>                /*
> -                * byte 1:  .   .   .   .   .  x10 x9  x8
> +                * byte 1:  .   .   .   .  x11 x10 x9  x8
>                 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
>                 */
> -               x1 = ((packet[1] & 0x07) << 8) | packet[2];
> +               x1 = ((packet[1] & 0x0f) << 8) | packet[2];
>                /*
> -                * byte 4:  .   .   .   .   .   .  y9  y8
> +                * byte 4:  .   .   .   .  y11 y10 y9  y8
>                 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>                 */
> -               y1 = ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]);
> +               y1 = ETP_YMAX_V2 - (((packet[4] & 0x0f) << 8) | packet[5]);
>
>                input_report_abs(dev, ABS_X, x1);
>                input_report_abs(dev, ABS_Y, y1);
> --
> 1.7.4.1
>
