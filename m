From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 6/6] Input: elantech - add v3 hardware support
Date: Fri, 19 Aug 2011 15:03:04 +0200
Message-ID: <4E4E5F08.1030803@tudelft.nl>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:38018 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab1HSNDH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 09:03:07 -0400
In-Reply-To: <1313632629-23603-7-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Op 18-08-11 03:57, JJ Ding schreef:
> v3 hardware's packet format is almost identical to v2 (one/three fing=
er touch),
> except when sensing two finger touch, the hardware sends 12 bytes of =
data.
>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
Hi,
A couple of comments, in line.

:
:
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index ddd40eb..e13a719 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
:
> +/*
> + * Interpret complete data packets and report absolute mode input ev=
ents for
> + * hardware version 3. (12 byte packets for two fingers)
> + */
> +static void elantech_report_absolute_v3(struct psmouse *psmouse,
> +					int packet_type)
> +{
> +	struct input_dev *dev =3D psmouse->dev;
> +	struct elantech_data *etd =3D psmouse->private;
> +	unsigned char *packet =3D psmouse->packet;
> +	unsigned int fingers =3D 0, x1 =3D 0, y1 =3D 0, x2 =3D 0, y2 =3D 0;
> +	unsigned int width =3D 0, pres =3D 0;
> +
> +	/* byte 0: n1  n0   .   .   .   .   R   L */
> +	fingers =3D (packet[0]&  0xc0)>>  6;
> +
> +	switch (fingers) {
> +	case 3:
> +	case 1:
> +		/*
> +		 * byte 1:  .   .   .   .  x11 x10 x9  x8
> +		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
> +		 */
> +		x1 =3D ((packet[1]&  0x0f)<<  8) | packet[2];
> +		/*
> +		 * byte 4:  .   .   .   .  y11 y10 y9  y8
> +		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
> +		 */
> +		y1 =3D etd->y_max - (((packet[4]&  0x0f)<<  8) | packet[5]);
> +
> +		if (fingers =3D=3D 3&&  debounce(x1, y1))
> +			return;
> +
> +		break;
> +
> +	case 2:
> +		if (packet_type =3D=3D PACKET_V3_HEAD) {
> +			/*
> +			 * byte 1:   .    .    .    .  ax11 ax10 ax9  ax8
> +			 * byte 2: ax7  ax6  ax5  ax4  ax3  ax2  ax1  ax0
> +			 */
> +			etd->prev_x =3D ((packet[1]&  0x0f)<<  8) | packet[2];
> +			/*
> +			 * byte 4:   .    .    .    .  ay11 ay10 ay9  ay8
> +			 * byte 5: ay7  ay6  ay5  ay4  ay3  ay2  ay1  ay0
> +			 */
> +			etd->prev_y =3D etd->y_max -
> +				(((packet[4]&  0x0f)<<  8) | packet[5]);
> +			/*
> +			 * wait for next packet
> +			 */
> +			return;
> +		}
> +
> +		/* packet_type =3D=3D PACKET_V3_TAIL */
> +		x1 =3D etd->prev_x;
> +		y1 =3D etd->prev_y;
> +		x2 =3D ((packet[1]&  0x0f)<<  8) | packet[2];
> +		y2 =3D etd->y_max - (((packet[4]&  0x0f)<<  8) | packet[5]);
> +		break;
> +	}
You actually have three times the same formula, so you could simplify i=
t:

if (fingers !=3D0 ) {
	/*
	 * byte 1:  .   .   .   .  x11 x10 x9  x8
	 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
	 */
	x1 =3D ((packet[1]&  0x0f)<<  8) | packet[2];
	/*
	 * byte 4:  .   .   .   .  y11 y10 y9  y8
	 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
	 */
	y1 =3D ((packet[4]&  0x0f)<<  8) | packet[5];
}

if ((fingers =3D=3D 3) && debounce(x1, y1))
	return;

if (fingers =3D=3D 2) {
	if (packet_type =3D=3D PACKET_V3_HEAD)) {
		/* wait for next packet */
		etd->prev_x =3D x1;
		etd->prev_y =3D etd->y_max - y1;
		return;
	} else {
		/* packet_type =3D=3D PACKET_V3_TAIL */
		x2 =3D etd->prev_x;
		y2 =3D etd->prev_y;
	}
}


> +
> +	pres =3D (packet[1]&  0xf0) | ((packet[4]&  0xf0)>>  4);
> +	width =3D ((packet[0]&  0x30)>>  2) | ((packet[3]&  0x30)>>  4);
What about the case of two fingers? Are pressure and width correct for=20
both fingers? In that case, maybe it should also be saved from=20
PACKET_V3_HEAD.


> +
> +	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
> +	input_report_abs(dev, ABS_X, x1);
> +	input_report_abs(dev, ABS_Y, y1);
> +	elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
> +	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
> +	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
> +	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=3D 3);
> +	input_report_key(dev, BTN_LEFT, packet[0]&  0x01);
> +	input_report_key(dev, BTN_RIGHT, packet[0]&  0x02);
> +	input_report_abs(dev, ABS_PRESSURE, pres);
> +	input_report_abs(dev, ABS_TOOL_WIDTH, width);
> +
> +	input_sync(dev);
> +}
> +
:
>
>   /*
>    * Set the appropriate event bits for the input subsystem
>    */
> -static void elantech_set_input_params(struct psmouse *psmouse)
> +static int elantech_set_input_params(struct psmouse *psmouse)
>   {
>   	struct input_dev *dev =3D psmouse->dev;
>   	struct elantech_data *etd =3D psmouse->private;
>   	unsigned int x_min =3D 0, y_min =3D 0, x_max =3D 0, y_max =3D 0, y=
_2ft_max =3D 0;
>
> -	set_range(psmouse,&x_min,&y_min,&x_max,&y_max,&y_2ft_max);
> +	if (set_range(psmouse,&x_min,&y_min,&x_max,&y_max,&y_2ft_max))
> +		return -1;
>
>   	__set_bit(EV_KEY, dev->evbit);
>   	__set_bit(EV_ABS, dev->evbit);
> @@ -582,10 +739,26 @@ static void elantech_set_input_params(struct ps=
mouse *psmouse)
>   		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
>   		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
>   		break;
> +
> +	case 3:
> +		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
> +		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
> +		/* range of pressure and width is the same as v2 */
> +		input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
> +				     ETP_PMAX_V2, 0, 0);
> +		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
> +				     ETP_WMAX_V2, 0, 0);
> +		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
Does v3 have the same limitation in MT about only reporting the edges o=
f=20
the bounding box? Or are the two fingers always reported independently?=
=20
If that is so, you can drop this line :-)


> +		input_mt_init_slots(dev, 2);
> +		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
> +		break;
>   	}
>

Cheers,
=C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
