From: Ming-ting Yao Wei <mwei@lxde.org>
Subject: [PATCH v2] xpad: Add rumble support for Xbox One controller
Date: Wed, 15 Apr 2015 05:51:01 +0800
Message-ID: <1429048261-13002-1-git-send-email-mwei@lxde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:32888 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbbDNVwM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 17:52:12 -0400
Received: by paboj16 with SMTP id oj16so26366754pab.0
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2015 14:52:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ming-ting Yao Wei <mwei@lxde.org>, linux-input@vger.kernel.org

This adds rumble support for Xbox One controller by sending continuous =
rumble
command.  Trigger button rumbling does not yet implemented.

Signed-off-by: Ming-ting Yao Wei <mwei@lxde.org>

---
 drivers/input/joystick/xpad.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
index 3aa2f3f..61c7611 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -31,12 +31,14 @@
  *  - the iForce driver    drivers/char/joystick/iforce.c
  *  - the skeleton-driver  drivers/usb/usb-skeleton.c
  *  - Xbox 360 information http://www.free60.org/wiki/Gamepad
+ *  - Xbox One information https://github.com/quantus/xbox-one-control=
ler-protocol
  *
  * Thanks to:
  *  - ITO Takayuki for providing essential xpad information on his web=
site
  *  - Vojtech Pavlik     - iforce driver / input subsystem
  *  - Greg Kroah-Hartman - usb-skeleton driver
  *  - XBOX Linux project - extra USB id's
+ *  - Pekka P=C3=B6yry (quantus) - Xbox One controller reverse enginee=
ring
  *
  * TODO:
  *  - fine tune axes (especially trigger axes)
@@ -828,6 +830,23 @@ static int xpad_play_effect(struct input_dev *dev,=
 void *data, struct ff_effect
=20
 			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
=20
+		case XTYPE_XBOXONE:
+			xpad->odata[0] =3D 0x09; /* activate rumble */
+			xpad->odata[1] =3D 0x08;
+			xpad->odata[2] =3D 0x00;
+			xpad->odata[3] =3D 0x08; /* continuous effect */
+			xpad->odata[4] =3D 0x00; /* simple rumble mode */
+			xpad->odata[5] =3D 0x03; /* L and R actuator only */
+			xpad->odata[6] =3D 0x00; /* TODO: LT actuator */
+			xpad->odata[7] =3D 0x00; /* TODO: RT actuator */
+			xpad->odata[8] =3D strong / 256;	/* left actuator */
+			xpad->odata[9] =3D weak / 256;	/* right actuator */
+			xpad->odata[10] =3D 0x80;	/* length of pulse */
+			xpad->odata[11] =3D 0x00;	/* stop period of pulse */
+			xpad->irq_out->transfer_buffer_length =3D 12;
+
+			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
 		default:
 			dev_dbg(&xpad->dev->dev,
 				"%s - rumble command sent to unsupported xpad type: %d\n",
@@ -841,7 +860,7 @@ static int xpad_play_effect(struct input_dev *dev, =
void *data, struct ff_effect
=20
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
-	if (xpad->xtype =3D=3D XTYPE_UNKNOWN || xpad->xtype =3D=3D XTYPE_XBOX=
ONE)
+	if (xpad->xtype =3D=3D XTYPE_UNKNOWN)
 		return 0;
=20
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
--=20
2.3.2 (Apple Git-55)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
