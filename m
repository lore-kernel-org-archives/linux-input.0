From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 21/24] input: Port xpad to ff-memless-next
Date: Tue, 22 Apr 2014 16:00:06 +0200
Message-ID: <1398175209-9565-22-git-send-email-madcatxster@devoid-pointer.net>
References: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.devoid-pointer.net ([31.31.77.140]:49533 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932441AbaDVOBb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 10:01:31 -0400
In-Reply-To: <1398175209-9565-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, elias.vds@gmail.com, anssi.hannula@iki.fi, simon@mungewell.org

Port xpad to ff-memless-next

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
---
 drivers/input/joystick/Kconfig |   2 +-
 drivers/input/joystick/xpad.c  | 125 +++++++++++++++++++++++----------=
--------
 2 files changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kc=
onfig
index 2dd3ba1..9f26e48 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -294,7 +294,7 @@ config JOYSTICK_XPAD
 config JOYSTICK_XPAD_FF
 	bool "X-Box gamepad rumble support"
 	depends on JOYSTICK_XPAD && INPUT
-	select INPUT_FF_MEMLESS
+	select INPUT_FF_MEMLESS_NEXT
 	---help---
 	  Say Y here if you want to take advantage of xbox 360 rumble feature=
s.
=20
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
index 603fe0d..5d9c8a2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -78,6 +78,7 @@
 #include <linux/stat.h>
 #include <linux/module.h>
 #include <linux/usb/input.h>
+#include <linux/input/ff-memless-next.h>
=20
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
@@ -97,6 +98,8 @@
 #define XTYPE_XBOX360W    2
 #define XTYPE_UNKNOWN     3
=20
+#define FF_UPDATE_RATE 50
+
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than ax=
es for unknown pads");
@@ -628,63 +631,75 @@ static void xpad_stop_output(struct usb_xpad *xpa=
d) {}
 #endif
=20
 #ifdef CONFIG_JOYSTICK_XPAD_FF
-static int xpad_play_effect(struct input_dev *dev, void *data, struct =
ff_effect *effect)
+static int xpad_play_effect(struct input_dev *dev, void *data,
+			    const struct mlnx_effect_command *command)
 {
 	struct usb_xpad *xpad =3D input_get_drvdata(dev);
+	const struct mlnx_rumble_force *rumble_force =3D &command->u.rumble_f=
orce;
+	__u16 strong, weak;
=20
-	if (effect->type =3D=3D FF_RUMBLE) {
-		__u16 strong =3D effect->u.rumble.strong_magnitude;
-		__u16 weak =3D effect->u.rumble.weak_magnitude;
-
-		switch (xpad->xtype) {
-
-		case XTYPE_XBOX:
-			xpad->odata[0] =3D 0x00;
-			xpad->odata[1] =3D 0x06;
-			xpad->odata[2] =3D 0x00;
-			xpad->odata[3] =3D strong / 256;	/* left actuator */
-			xpad->odata[4] =3D 0x00;
-			xpad->odata[5] =3D weak / 256;	/* right actuator */
-			xpad->irq_out->transfer_buffer_length =3D 6;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOX360:
-			xpad->odata[0] =3D 0x00;
-			xpad->odata[1] =3D 0x08;
-			xpad->odata[2] =3D 0x00;
-			xpad->odata[3] =3D strong / 256;  /* left actuator? */
-			xpad->odata[4] =3D weak / 256;	/* right actuator? */
-			xpad->odata[5] =3D 0x00;
-			xpad->odata[6] =3D 0x00;
-			xpad->odata[7] =3D 0x00;
-			xpad->irq_out->transfer_buffer_length =3D 8;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOX360W:
-			xpad->odata[0] =3D 0x00;
-			xpad->odata[1] =3D 0x01;
-			xpad->odata[2] =3D 0x0F;
-			xpad->odata[3] =3D 0xC0;
-			xpad->odata[4] =3D 0x00;
-			xpad->odata[5] =3D strong / 256;
-			xpad->odata[6] =3D weak / 256;
-			xpad->odata[7] =3D 0x00;
-			xpad->odata[8] =3D 0x00;
-			xpad->odata[9] =3D 0x00;
-			xpad->odata[10] =3D 0x00;
-			xpad->odata[11] =3D 0x00;
-			xpad->irq_out->transfer_buffer_length =3D 12;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		default:
-			dev_dbg(&xpad->dev->dev,
-				"%s - rumble command sent to unsupported xpad type: %d\n",
-				__func__, xpad->xtype);
-			return -1;
-		}
+	switch (command->cmd) {
+	case MLNX_START_RUMBLE:
+		strong =3D rumble_force->strong;
+		weak =3D rumble_force->weak;
+		break;
+	case MLNX_STOP_RUMBLE:
+		strong =3D 0;
+		weak =3D 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+
+	switch (xpad->xtype) {
+
+	case XTYPE_XBOX:
+		xpad->odata[0] =3D 0x00;
+		xpad->odata[1] =3D 0x06;
+		xpad->odata[2] =3D 0x00;
+		xpad->odata[3] =3D strong / 256;	/* left actuator */
+		xpad->odata[4] =3D 0x00;
+		xpad->odata[5] =3D weak / 256;	/* right actuator */
+		xpad->irq_out->transfer_buffer_length =3D 6;
+
+		return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
+	case XTYPE_XBOX360:
+		xpad->odata[0] =3D 0x00;
+		xpad->odata[1] =3D 0x08;
+		xpad->odata[2] =3D 0x00;
+		xpad->odata[3] =3D strong / 256;  /* left actuator? */
+		xpad->odata[4] =3D weak / 256;	/* right actuator? */
+		xpad->odata[5] =3D 0x00;
+		xpad->odata[6] =3D 0x00;
+		xpad->odata[7] =3D 0x00;
+		xpad->irq_out->transfer_buffer_length =3D 8;
+
+		return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
+	case XTYPE_XBOX360W:
+		xpad->odata[0] =3D 0x00;
+		xpad->odata[1] =3D 0x01;
+		xpad->odata[2] =3D 0x0F;
+		xpad->odata[3] =3D 0xC0;
+		xpad->odata[4] =3D 0x00;
+		xpad->odata[5] =3D strong / 256;
+		xpad->odata[6] =3D weak / 256;
+		xpad->odata[7] =3D 0x00;
+		xpad->odata[8] =3D 0x00;
+		xpad->odata[9] =3D 0x00;
+		xpad->odata[10] =3D 0x00;
+		xpad->odata[11] =3D 0x00;
+		xpad->irq_out->transfer_buffer_length =3D 12;
+
+		return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
+	default:
+		dev_dbg(&xpad->dev->dev,
+			"%s - rumble command sent to unsupported xpad type: %d\n",
+			__func__, xpad->xtype);
+		return -1;
 	}
=20
 	return 0;
@@ -697,7 +712,7 @@ static int xpad_init_ff(struct usb_xpad *xpad)
=20
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
=20
-	return input_ff_create_memless(xpad->dev, NULL, xpad_play_effect);
+	return input_ff_create_mlnx(xpad->dev, NULL, xpad_play_effect, FF_UPD=
ATE_RATE);
 }
=20
 #else
--=20
1.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
