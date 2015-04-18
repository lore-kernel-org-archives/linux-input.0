From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Re: [PATCH v2] psmouse - focaltech pass finger width to userspace
Date: Sat, 18 Apr 2015 19:14:12 +0300
Message-ID: <553282D4.2020501@gmail.com>
References: <1429364143-13510-1-git-send-email-hanipouspilot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35792 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbbDRQOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2015 12:14:14 -0400
Received: by lbbuc2 with SMTP id uc2so103128606lbb.2
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2015 09:14:13 -0700 (PDT)
In-Reply-To: <1429364143-13510-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mathias Gottschlag <mgottschlag@gmail.com>

18.04.2015 16:35, Dmitry Tunin =EF=E8=F8=E5=F2:
> Focaltech touchpads report finger width in packet[5] of absolute pack=
et.
> Range for width in raw format is 0x10 - 0x70. Second half-byte is alw=
ays 0.
> 0xff is reported, when a large contact area is detected.
> This can be handled in userspace.
>=20
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
> ---
>  drivers/input/mouse/focaltech.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/fo=
caltech.c
> index 23d2594..25e4bb3 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -90,6 +90,12 @@ struct focaltech_finger_state {
>  	 */
>  	unsigned int x;
>  	unsigned int y;
> +
> +	/*
> +	* Finger width 0-7 and 15 for 'latching'
> +	* 15 value stays until the finger is released
> +	*/
> +	unsigned int width;
>  };
> =20
>  /*
> @@ -137,6 +143,7 @@ static void focaltech_report_state(struct psmouse=
 *psmouse)
>  			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
>  			input_report_abs(dev, ABS_MT_POSITION_Y,
>  					 priv->y_max - clamped_y);
> +			input_report_abs(dev, ABS_TOOL_WIDTH, finger->width);
>  		}
>  	}
>  	input_mt_report_pointer_emulation(dev, true);
> @@ -187,6 +194,7 @@ static void focaltech_process_abs_packet(struct p=
smouse *psmouse,
> =20
>  	state->fingers[finger].x =3D ((packet[1] & 0xf) << 8) | packet[2];
>  	state->fingers[finger].y =3D (packet[3] << 8) | packet[4];
> +	state->fingers[finger].width =3D packet[5] >> 4;
>  	state->fingers[finger].valid =3D true;
>  }
> =20
> @@ -331,6 +339,7 @@ static void focaltech_set_input_params(struct psm=
ouse *psmouse)
>  	__set_bit(EV_ABS, dev->evbit);
>  	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
>  	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
> +	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
>  	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
>  	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
>  }
>=20
After some testing I discovered that this looking quite harmless patch =
leads to a regression.
At least on a weak laptop X200MA with xorg-synaptics.

If I scroll with two fingers and then lift them and put them down again=
, the scrolled text jerks further.
I think it is because of limited bandwidth of PS/2. When I increase amo=
unt of data, it starts behaving worse.
Relative packets do not report finger width either way, so we do not ne=
ed to report it each time.
If general idea is approved, then it can be done another way, so finger=
 width information is sent, when it is really
appropriate.=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
