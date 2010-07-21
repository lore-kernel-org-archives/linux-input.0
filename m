From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Tue, 20 Jul 2010 20:36:55 -0700
Message-ID: <20100721033655.GA9070@core.coreip.homeip.net>
References: <4C1FD2B0.1080504@tudelft.nl>
 <4C1FD454.4050807@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37385 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932940Ab0GUDhB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jul 2010 23:37:01 -0400
Received: by pwi5 with SMTP id 5so2443218pwi.19
        for <linux-input@vger.kernel.org>; Tue, 20 Jul 2010 20:37:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C1FD454.4050807@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

On Mon, Jun 21, 2010 at 11:06:28PM +0200, =C9ric Piel wrote:
> When 2 fingers are pressed, the low and high coordinates are given.
> Instead of reporting just the low coordinate as the normal position,
> report an average of both. This allow to have the cursor always move,
> whichever finger moves. In practice, this improves the support of
> two-fingers scolling with the synaptics X driver.
>=20
> Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
> ---
>  drivers/input/mouse/elantech.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index c84f741..d1b505a 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -301,11 +301,11 @@ static void elantech_report_absolute_v2(struct =
psmouse *psmouse)
>  		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
>  		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
>  		/*
> -		 * For compatibility with the X Synaptics driver scale up
> -		 * one coordinate and report as ordinary mouse movent
> +		 * For compatibility with non-multitouch userspace apps
> +		 * report the average of both coordinates and scale up.
>  		 */
> -		input_report_abs(dev, ABS_X, x1 << 2);
> -		input_report_abs(dev, ABS_Y, y1 << 2);
> +		input_report_abs(dev, ABS_X, (x1 + x2) << 1);
> +		input_report_abs(dev, ABS_Y, (y1 + y2) << 1);

I am concerned what happens when you put one finger first and then add
another one. Would not that couse the cursor to jump?

I'd say we need to obey MT protocol and continue reporting the first
contact in non-MT protocol and rely on MT-aware drivers to do better jo=
b
of contact tracking. This is also consistent with how other drivers,
such as bcm5974, report coordinates.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
