From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] elantech: Report multitouch with proper ABS_MT
 messages
Date: Wed, 5 May 2010 09:38:33 -0700
Message-ID: <20100505163832.GA7337@core.coreip.homeip.net>
References: <4BE1629E.50901@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:58067 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab0EEQiq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 12:38:46 -0400
Received: by wwb13 with SMTP id 13so6975wwb.19
        for <linux-input@vger.kernel.org>; Wed, 05 May 2010 09:38:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE1629E.50901@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Eric,

On Wed, May 05, 2010 at 02:20:46PM +0200, =C9ric Piel wrote:
>=20
> Multitouch info was reported only via a old protocol used by the
> proprietary X driver from elantech. Let's report the multitouch info
> also following the official MT protocol.
>=20
> This was done following the multi-touch-protocol.txt documentation, a=
nd
> inspired by the bcm5974 implementation. Testing was light as there is
> not many applications using this protocol yet, but the X synaptics
> driver didn't complain and the X multitouch driver behaved correctly.
>=20
> Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
> ---
>  drivers/input/mouse/elantech.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 6a99b30..22978a9 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -253,7 +253,6 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
> =20
>  	/* byte 0: n1  n0   .   .   .   .   R   L */
>  	fingers =3D (packet[0] & 0xc0) >> 6;
> -	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);

Mousedev works a tad better if BTN_TOUCH is reported first. Otherwise
looks good.

Henrik, should we report "tool width" as ABS_MT_WIDTH_MAJOR?

Eric, we don't have the "width" for the 2nd point of contact, do we?

Where is the proprietary driver BTW? Do we even care? I'd probably get
rid of HAT abuse if our standard tools provide good user experience.

> =20
>  	switch (fingers) {
>  	case 1:
> @@ -268,6 +267,10 @@ static void elantech_report_absolute_v2(struct p=
smouse *psmouse)
>  		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
>  		 */
>  		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]);
> +		input_report_abs(dev, ABS_MT_POSITION_X, x1);
> +		input_report_abs(dev, ABS_MT_POSITION_Y, y1);
> +		input_mt_sync(dev);
> +
>  		input_report_abs(dev, ABS_TOOL_WIDTH, width);
>  		input_report_abs(dev, ABS_X, x1);
>  		input_report_abs(dev, ABS_Y, y1);
> @@ -290,6 +293,13 @@ static void elantech_report_absolute_v2(struct p=
smouse *psmouse)
>  		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
>  		/* byte 5: by7 by6 by5 by4 by3 by2 by1 by0 */
>  		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
> +		/* Multitouch */
> +		input_report_abs(dev, ABS_MT_POSITION_X, x1 << 2);
> +		input_report_abs(dev, ABS_MT_POSITION_Y, y1 << 2);
> +		input_mt_sync(dev);
> +		input_report_abs(dev, ABS_MT_POSITION_X, x2 << 2);
> +		input_report_abs(dev, ABS_MT_POSITION_Y, y2 << 2);
> +		input_mt_sync(dev);
>  		/*
>  		 * For compatibility with the X Synaptics driver scale up
>  		 * one coordinate and report as ordinary mouse movent
> @@ -307,6 +317,7 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
>  		break;
>  	}
> =20
> +	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
>  	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
>  	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
>  	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=3D 3);
> @@ -472,6 +483,8 @@ static void elantech_set_input_params(struct psmo=
use *psmouse)
>  		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2=
, 0, 0);
>  		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
>  		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_X, ETP_XMIN_V2, ETP_XMAX=
_V2, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, ETP_YMIN_V2, ETP_YMAX=
_V2, 0, 0);
>  		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0=
, 0);
>  		input_set_abs_params(dev, ABS_HAT0Y, ETP_2FT_YMIN, ETP_2FT_YMAX, 0=
, 0);
>  		input_set_abs_params(dev, ABS_HAT1X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0=
, 0);


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
