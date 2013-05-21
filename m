From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Add support for Fujitsu S762 laptops scroll wheel
Date: Tue, 21 May 2013 11:58:44 -0700
Message-ID: <20130521185844.GA23365@core.coreip.homeip.net>
References: <1367861750.11289.3.camel@u-foka-laptop.ethome2>
 <519BA0AA.7080002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:49549 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab3EUS6s (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 May 2013 14:58:48 -0400
Received: by mail-pd0-f182.google.com with SMTP id g10so912908pdj.41
        for <linux-input@vger.kernel.org>; Tue, 21 May 2013 11:58:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <519BA0AA.7080002@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eisenberger =?iso-8859-1?Q?Tam=E1s?= <ufooka@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Tam=E1s,

On Tue, May 21, 2013 at 06:28:26PM +0200, Eisenberger Tam=E1s wrote:
> Hello,
>=20
> This were my first contribution, and I received no response at all :(
> Am I done something wrong, no one else is interested in supporting
> this particular piece of hardware or what?
>=20
> If anyone has a minute please review it.
>

Ah, yes, sorry...

> Thanks:
> Tam=E1s
>=20
> On 2013-05-06 19:35, Eisenberger Tam=E1s wrote:
> >Detects and makes the Touch Scroll Wheel found on some Fujitsu lapto=
ps
> >working.
> >
> >The detection is based on the (hopefully) unique E7 report of the wh=
eel
> >device.
> >Up and down scrolling is detected by the only byte that has differen=
t
> >values in the devices packets, but it should be fine since it only a=
ble
> >to report that two events.
> >
> >Signed-off-by: Tama's Eisenberger <tamas@eisenberger.hu>
> >Index: linux/drivers/input/mouse/alps.c
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux.orig/drivers/input/mouse/alps.c
> >+++ linux/drivers/input/mouse/alps.c
> >@@ -410,6 +410,17 @@ static void alps_process_trackstick_pack
> >  	if (packet[1] =3D=3D 0x7f && packet[2] =3D=3D 0x7f && packet[4] =3D=
=3D 0x7f)
> >  		return;
> >
> >+	if (priv->quirks & ALPS_QUIRK_SCROLL_WHEEL) {
> >+		if (packet[3] =3D=3D 0x4c)
> >+			input_report_rel(dev, REL_WHEEL, 1);
> >+
> >+		if (packet[3] =3D=3D 0x58)
> >+			input_report_rel(dev, REL_WHEEL, -1);

Are these really the only values that emitted by the wheel? Have you
tried spinning it vigorously to see if it produces different results?

> >+
> >+		input_sync(dev);
> >+		return;

Why are we ignoring the rest of the packet in this case? Does it contai=
n
invalid data?

> >+	}
> >+
> >  	x =3D (s8)(((packet[0] & 0x20) << 2) | (packet[1] & 0x7f));
> >  	y =3D (s8)(((packet[0] & 0x10) << 3) | (packet[2] & 0x7f));
> >  	z =3D (packet[4] & 0x7c) >> 2;
> >@@ -1255,6 +1266,7 @@ error:
> >  static int alps_setup_trackstick_v3(struct psmouse *psmouse, int
> >reg_base)
> >  {
> >  	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
> >+	struct alps_data *priv =3D psmouse->private;
> >  	int ret =3D 0;
> >  	unsigned char param[4];
> >
> >@@ -1277,6 +1289,12 @@ static int alps_setup_trackstick_v3(stru
> >  		psmouse_dbg(psmouse, "trackstick E7 report: %3ph\n", param);
> >
> >  		/*
> >+		 * Detect fujitsu scroll wheel device
> >+		 */
> >+		if (param[0] =3D=3D 0x34 && param[1] =3D=3D 0x01 && param[2] =3D=3D=
 0x14)
> >+			priv->quirks |=3D ALPS_QUIRK_SCROLL_WHEEL;
> >+

I believe this quirk should go into alps_model_data[] table.

> >+		/*
> >  		 * Not sure what this does, but it is absolutely
> >  		 * essential. Without it, the touchpad does not
> >  		 * work at all and the trackstick just emits normal
> >@@ -1798,12 +1816,16 @@ int alps_init(struct psmouse *psmouse)
> >  	dev2->id.product =3D PSMOUSE_ALPS;
> >  	dev2->id.version =3D 0x0000;
> >  	dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
> >-
> >  	dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
> >  	dev2->relbit[BIT_WORD(REL_X)] =3D BIT_MASK(REL_X) | BIT_MASK(REL_=
Y);
> >  	dev2->keybit[BIT_WORD(BTN_LEFT)] =3D
> >  		BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
> >
> >+	if (priv->quirks & ALPS_QUIRK_SCROLL_WHEEL) {
> >+		dev2->name =3D "DualPoint Scroll Wheel";

I'd keep the name as is.

> >+		dev2->relbit[BIT_WORD(REL_X)] |=3D BIT_MASK(REL_WHEEL);
> >+	}
> >+
> >  	if (input_register_device(priv->dev2))
> >  		goto init_fail;
> >
> >Index: linux/drivers/input/mouse/alps.h
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >--- linux.orig/drivers/input/mouse/alps.h
> >+++ linux/drivers/input/mouse/alps.h
> >@@ -158,6 +158,7 @@ struct alps_data {
> >  };
> >
> >  #define ALPS_QUIRK_TRACKSTICK_BUTTONS	1 /* trakcstick buttons in
> >trackstick packet */
> >+#define ALPS_QUIRK_SCROLL_WHEEL		2 /* secondary device is scroll wh=
eel
> >*/
> >
> >  #ifdef CONFIG_MOUSE_PS2_ALPS
> >  int alps_detect(struct psmouse *psmouse, bool set_properties);
> >

BTW, your mailer line-wrapped the patch so it is not possible to apply,
when resending please make sure the long lines stay intact.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
