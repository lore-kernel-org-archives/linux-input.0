From: =?UTF-8?B?RWlzZW5iZXJnZXIgVGFtw6Fz?= <ufooka@gmail.com>
Subject: Re: [PATCH] Input: Add support for Fujitsu S762 laptops scroll wheel
Date: Tue, 21 May 2013 18:28:26 +0200
Message-ID: <519BA0AA.7080002@gmail.com>
References: <1367861750.11289.3.camel@u-foka-laptop.ethome2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:61952 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab3EUQ2a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 May 2013 12:28:30 -0400
Received: by mail-ea0-f172.google.com with SMTP id d10so546897eaj.3
        for <linux-input@vger.kernel.org>; Tue, 21 May 2013 09:28:29 -0700 (PDT)
Received: from [192.168.102.2] (catv-86-101-91-26.catv.broadband.hu. [86.101.91.26])
        by mx.google.com with ESMTPSA id y10sm4606024eev.3.2013.05.21.09.28.27
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 09:28:28 -0700 (PDT)
In-Reply-To: <1367861750.11289.3.camel@u-foka-laptop.ethome2>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

This were my first contribution, and I received no response at all :(
Am I done something wrong, no one else is interested in supporting this=
=20
particular piece of hardware or what?

If anyone has a minute please review it.

Thanks:
Tam=C3=A1s

On 2013-05-06 19:35, Eisenberger Tam=C3=A1s wrote:
> Detects and makes the Touch Scroll Wheel found on some Fujitsu laptop=
s
> working.
>
> The detection is based on the (hopefully) unique E7 report of the whe=
el
> device.
> Up and down scrolling is detected by the only byte that has different
> values in the devices packets, but it should be fine since it only ab=
le
> to report that two events.
>
> Signed-off-by: Tama's Eisenberger <tamas@eisenberger.hu>
> Index: linux/drivers/input/mouse/alps.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/input/mouse/alps.c
> +++ linux/drivers/input/mouse/alps.c
> @@ -410,6 +410,17 @@ static void alps_process_trackstick_pack
>   	if (packet[1] =3D=3D 0x7f && packet[2] =3D=3D 0x7f && packet[4] =3D=
=3D 0x7f)
>   		return;
>
> +	if (priv->quirks & ALPS_QUIRK_SCROLL_WHEEL) {
> +		if (packet[3] =3D=3D 0x4c)
> +			input_report_rel(dev, REL_WHEEL, 1);
> +
> +		if (packet[3] =3D=3D 0x58)
> +			input_report_rel(dev, REL_WHEEL, -1);
> +
> +		input_sync(dev);
> +		return;
> +	}
> +
>   	x =3D (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
>   	y =3D (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
>   	z =3D (packet[4] & 0x7c) >> 2;
> @@ -1255,6 +1266,7 @@ error:
>   static int alps_setup_trackstick_v3(struct psmouse *psmouse, int
> reg_base)
>   {
>   	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> +	struct alps_data *priv =3D psmouse->private;
>   	int ret =3D 0;
>   	unsigned char param[4];
>
> @@ -1277,6 +1289,12 @@ static int alps_setup_trackstick_v3(stru
>   		psmouse_dbg(psmouse, "trackstick E7 report: %3ph\n", param);
>
>   		/*
> +		 * Detect fujitsu scroll wheel device
> +		 */
> +		if (param[0] =3D=3D 0x34 && param[1] =3D=3D 0x01 && param[2] =3D=3D=
 0x14)
> +			priv->quirks |=3D ALPS_QUIRK_SCROLL_WHEEL;
> +
> +		/*
>   		 * Not sure what this does, but it is absolutely
>   		 * essential. Without it, the touchpad does not
>   		 * work at all and the trackstick just emits normal
> @@ -1798,12 +1816,16 @@ int alps_init(struct psmouse *psmouse)
>   	dev2->id.product =3D PSMOUSE_ALPS;
>   	dev2->id.version =3D 0x0000;
>   	dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
> -
>   	dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
>   	dev2->relbit[BIT_WORD(REL_X)] =3D BIT_MASK(REL_X) | BIT_MASK(REL_Y=
);
>   	dev2->keybit[BIT_WORD(BTN_LEFT)] =3D
>   		BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
>
> +	if (priv->quirks & ALPS_QUIRK_SCROLL_WHEEL) {
> +		dev2->name =3D "DualPoint Scroll Wheel";
> +		dev2->relbit[BIT_WORD(REL_X)] |=3D BIT_MASK(REL_WHEEL);
> +	}
> +
>   	if (input_register_device(priv->dev2))
>   		goto init_fail;
>
> Index: linux/drivers/input/mouse/alps.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/input/mouse/alps.h
> +++ linux/drivers/input/mouse/alps.h
> @@ -158,6 +158,7 @@ struct alps_data {
>   };
>
>   #define ALPS_QUIRK_TRACKSTICK_BUTTONS	1 /* trakcstick buttons in
> trackstick packet */
> +#define ALPS_QUIRK_SCROLL_WHEEL		2 /* secondary device is scroll whe=
el
> */
>
>   #ifdef CONFIG_MOUSE_PS2_ALPS
>   int alps_detect(struct psmouse *psmouse, bool set_properties);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
