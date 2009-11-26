From: =?ISO-8859-1?Q?Nicolas_L=E9veill=E9?= <knos@free.fr>
Subject: [PATCH 2/2] triggers as buttons rather than axes.
Date: Thu, 26 Nov 2009 22:36:38 +0100
Message-ID: <4B0EF4E6.10301@free.fr>
References: <4B0EF30D.1030705@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:42436 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752981AbZKZVlA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 16:41:00 -0500
In-Reply-To: <4B0EF30D.1030705@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


Certain devices implement triggers as buttons rather than axes. In
particular, arcade sticks such as the HORI Real Arcade Pro.EX do not
have analog buttons.

These devices are now setup to present buttons rather than axes for
triggers.

User-space applications often also have problems with
axes-as-buttons. Activating MAP_TRIGGERS_TO_BUTTONS for a device
removes the artificial difference between buttons and triggers.

Signed-off-by: Nicolas L=E9veill=E9 <nicolas@uucidl.com>
---
 drivers/input/joystick/xpad.c |  137 ++++++++++++++++++++++++++-------=
--------
 1 files changed, 88 insertions(+), 49 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
index 482cb12..0d43838 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -90,6 +90,9 @@
 #define MAP_DPAD_TO_AXES       1
 #define MAP_DPAD_UNKNOWN       2

+#define MAP_TRIGGERS_TO_AXES    0
+#define MAP_TRIGGERS_TO_BUTTONS 1
+
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
 #define XTYPE_XBOX360W    2
@@ -104,52 +107,53 @@ static const struct xpad_device {
 	u16 idProduct;
 	char *name;
 	u8 dpad_mapping;
+	u8 trigger_mapping;
 	u8 xtype;
 } xpad_device[] =3D {
-	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, =
XTYPE_XBOX360W },
-	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XT=
YPE_XBOX },
-	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_DPAD_TO_AXES, =
XTYPE_XBOX },
-	{ 0x046d, 0xc242, "Logitech Chillstream Controller", MAP_DPAD_TO_AXES=
, XTYPE_XBOX360 },
-	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", MAP_DPAD_TO_AX=
ES, XTYPE_XBOX },
-	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", MAP_DPAD_TO=
_AXES, XTYPE_XBOX },
-	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", MAP_DPAD_TO_AXE=
S, XTYPE_XBOX },
-	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", MAP_=
DPAD_TO_AXES, XTYPE_XBOX },
-	{ 0x0738, 0x4516, "Mad Catz Control Pad", MAP_DPAD_TO_AXES, XTYPE_XBO=
X },
-	{ 0x0738, 0x4522, "Mad Catz LumiCON", MAP_DPAD_TO_AXES, XTYPE_XBOX },
-	{ 0x0738, 0x4526, "Mad Catz Control Pad Pro", MAP_DPAD_TO_AXES, XTYPE=
_XBOX },
-	{ 0x0738, 0x4536, "Mad Catz MicroCON", MAP_DPAD_TO_AXES, XTYPE_XBOX }=
,
-	{ 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBO=
X },
-	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", MAP_DPAD_TO_AX=
ES, XTYPE_XBOX },
-	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", MAP_DPAD_TO_A=
XES, XTYPE_XBOX360 },
-	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_DP=
AD_TO_AXES, XTYPE_XBOX360 },
-	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS, XTYPE=
_XBOX },
-	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES, XTYPE=
_XBOX },
-	{ 0x0c12, 0x880a, "Pelican Eclipse PL-2023", MAP_DPAD_TO_AXES, XTYPE_=
XBOX },
-	{ 0x0c12, 0x8810, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES, XTYPE=
_XBOX },
-	{ 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", MAP_DPAD_TO_AXES=
, XTYPE_XBOX },
-	{ 0x0e4c, 0x1097, "Radica Gamester Controller", MAP_DPAD_TO_AXES, XTY=
PE_XBOX },
-	{ 0x0e4c, 0x2390, "Radica Games Jtech Controller", MAP_DPAD_TO_AXES, =
XTYPE_XBOX },
-	{ 0x0e6f, 0x0003, "Logic3 Freebird wireless Controller", MAP_DPAD_TO_=
AXES, XTYPE_XBOX },
-	{ 0x0e6f, 0x0005, "Eclipse wireless Controller", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x0e6f, 0x0006, "Edge wireless Controller", MAP_DPAD_TO_AXES, XTYPE=
_XBOX },
-	{ 0x0e6f, 0x0006, "Pelican 'TSZ' Wired Xbox 360 Controller", MAP_DPAD=
_TO_AXES, XTYPE_XBOX360 },
-	{ 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", MAP_DPAD_TO_AXES,=
 XTYPE_XBOX },
-	{ 0x0f30, 0x0202, "Joytech Advanced Controller", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", MAP_DPAD_TO_AXES, XT=
YPE_XBOX },
-	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", MAP_DPAD_TO=
_AXES, XTYPE_XBOX },
-	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBO=
X },
-	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP_DPAD_TO_AXES,=
 XTYPE_XBOX360 },
-	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO=
_BUTTONS, XTYPE_XBOX },
-	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", MAP_DPAD_=
TO_AXES, XTYPE_XBOX360 },
-	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES, XTYPE_=
XBOX360 },
-	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, =
XTYPE_XBOX360 },
-	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_DPAD_TO_AXES, XTYPE_=
XBOX360 },
-	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES, X=
TYPE_XBOX },
-	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, XTYPE_UNKNOW=
N }
+       { 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x045e, 0x0287, "Microsoft Xbox Controller S", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUT=
TONS, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360W },
+       { 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTO=
NS, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", MAP_DPAD_TO_=
AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x046d, 0xc242, "Logitech Chillstream Controller", MAP_DPAD_T=
O_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x046d, 0xca84, "Logitech Xbox Cordless Controller", MAP_DPAD=
_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x046d, 0xca88, "Logitech Compact Controller for Xbox", MAP_D=
PAD_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x05fd, 0x1007, "Mad Catz Controller (unverified)", MAP_DPAD_=
TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)"=
, MAP_DPAD_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4516, "Mad Catz Control Pad", MAP_DPAD_TO_AXES, MAP=
_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4522, "Mad Catz LumiCON", MAP_DPAD_TO_AXES, MAP_TRI=
GGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4526, "Mad Catz Control Pad Pro", MAP_DPAD_TO_AXES,=
 MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4536, "Mad Catz MicroCON", MAP_DPAD_TO_AXES, MAP_TR=
IGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTTONS, MAP=
_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", MAP_DPAD=
_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", MAP_DPA=
D_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", =
MAP_DPAD_TO_AXES, MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+       { 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS,=
 MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0c12, 0x8802, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES,=
 MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0c12, 0x880a, "Pelican Eclipse PL-2023", MAP_DPAD_TO_AXES, =
MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0c12, 0x8810, "Zeroplus Xbox Controller", MAP_DPAD_TO_AXES,=
 MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", MAP_DPAD_T=
O_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0e4c, 0x1097, "Radica Gamester Controller", MAP_DPAD_TO_AXE=
S, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0e4c, 0x2390, "Radica Games Jtech Controller", MAP_DPAD_TO_=
AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0e6f, 0x0003, "Logic3 Freebird wireless Controller", MAP_DP=
AD_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0e6f, 0x0005, "Eclipse wireless Controller", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0e6f, 0x0006, "Edge wireless Controller", MAP_DPAD_TO_AXES,=
 MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0e6f, 0x0006, "Pelican 'TSZ' Wired Xbox 360 Controller", MA=
P_DPAD_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", MAP_DPAD_TO=
_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0f30, 0x0202, "Joytech Advanced Controller", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0f30, 0x8888, "BigBen XBMiniPad Controller", MAP_DPAD_TO_AX=
ES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", MAP_D=
PAD_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, MAP=
_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP_DPAD_TO=
_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_D=
PAD_TO_BUTTONS, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", MAP=
_DPAD_TO_AXES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES, =
MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUT=
TONS, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX360 },
+       { 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_DPAD_TO_AXES, =
MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
+       { 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_A=
XES, MAP_TRIGGERS_TO_AXES, XTYPE_XBOX },
+       { 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, MAP_TR=
IGGERS_TO_AXES, XTYPE_UNKNOWN }
 };

 /* buttons shared with xbox and xbox360 */
@@ -181,7 +185,6 @@ static const signed short xpad360_btn[] =3D {  /* b=
uttons for x360 controller */
 static const signed short xpad_abs[] =3D {
 	ABS_X, ABS_Y,		/* left stick */
 	ABS_RX, ABS_RY,		/* right stick */
-	ABS_Z, ABS_RZ,		/* triggers left/right */
 	-1			/* terminating entry */
 };

@@ -191,6 +194,18 @@ static const signed short xpad_abs_pad[] =3D {
 	-1			/* terminating entry */
 };

+/* used if MAP_TRIGGERS_TO_AXES */
+static const signed short xpad_abs_triggers[] =3D {
+	ABS_Z, ABS_RZ,		/* triggers left/right */
+	-1
+};
+
+/* used if MAP_TRIGGERS_TO_BUTTONS */
+static const signed short xpad_btn_triggers[] =3D {
+	BTN_TL2, BTN_TR2,		/* triggers left/right */
+	-1
+};
+
 /* Xbox 360 has a vendor-specific class, so we cannot match it with on=
ly
  * USB_INTERFACE_INFO (also specifically refused by USB subsystem), so=
 we
  * match against vendor id as well. Wired Xbox 360 devices have protoc=
ol 1,
@@ -247,6 +262,7 @@ struct usb_xpad {
 	char phys[64];			/* physical device path */

 	int dpad_mapping;		/* map d-pad to buttons or to axes */
+	int trigger_mapping;            /* map triggers to axes */
 	int xtype;			/* type of xbox device */
 };

@@ -277,8 +293,13 @@ static void xpad_process_packet(struct usb_xpad *x=
pad, u16 cmd, unsigned char *d
 			 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));

 	/* triggers left/right */
-	input_report_abs(dev, ABS_Z, data[10]);
-	input_report_abs(dev, ABS_RZ, data[11]);
+	if (xpad->trigger_mapping =3D=3D MAP_TRIGGERS_TO_BUTTONS) {
+		input_report_key(dev, BTN_TL2, data[10]);
+		input_report_key(dev, BTN_TR2, data[11]);
+	} else /* MAP_TRIGGERS_TO_AXES */ {
+		input_report_abs(dev, ABS_Z, data[10]);
+		input_report_abs(dev, ABS_RZ, data[11]);
+	}

 	/* digital pad */
 	if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES) {
@@ -371,8 +392,13 @@ static void xpad360_process_packet(struct usb_xpad=
 *xpad,
 			 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));

 	/* triggers left/right */
-	input_report_abs(dev, ABS_Z, data[4]);
-	input_report_abs(dev, ABS_RZ, data[5]);
+	if (xpad->trigger_mapping =3D=3D MAP_TRIGGERS_TO_BUTTONS) {
+		input_report_key(dev, BTN_TL2, data[4]);
+		input_report_key(dev, BTN_TR2, data[5]);
+	} else /* MAP_TRIGGERS_TO_AXES */ {
+		input_report_abs(dev, ABS_Z, data[4]);
+		input_report_abs(dev, ABS_RZ, data[5]);
+	}

 	input_sync(dev);
 }
@@ -753,6 +779,7 @@ static int xpad_probe(struct usb_interface *intf, c=
onst struct usb_device_id *id

 	xpad->udev =3D udev;
 	xpad->dpad_mapping =3D xpad_device[i].dpad_mapping;
+	xpad->trigger_mapping =3D xpad_device[i].trigger_mapping;
 	xpad->xtype =3D xpad_device[i].xtype;
 	if (xpad->dpad_mapping =3D=3D MAP_DPAD_UNKNOWN)
 		xpad->dpad_mapping =3D !dpad_to_buttons;
@@ -794,6 +821,12 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
 		for (i =3D 0; xpad_btn_pad[i] >=3D 0; i++)
 			set_bit(xpad_btn_pad[i], input_dev->keybit);

+	if (xpad->trigger_mapping =3D=3D MAP_TRIGGERS_TO_BUTTONS) {
+		for (i =3D 0; xpad_btn_triggers[i] >=3D 0; i++) {
+			set_bit(xpad_btn_triggers[i], input_dev->keybit);
+		}
+	}
+
 	/* set up axes */
 	for (i =3D 0; xpad_abs[i] >=3D 0; i++)
 		xpad_set_up_abs(input_dev, xpad_abs[i]);
@@ -801,6 +834,12 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
 		for (i =3D 0; xpad_abs_pad[i] >=3D 0; i++)
 		    xpad_set_up_abs(input_dev, xpad_abs_pad[i]);

+	if (xpad->trigger_mapping =3D=3D MAP_TRIGGERS_TO_AXES) {
+		for (i =3D 0; xpad_abs_triggers[i] >=3D 0; i++) {
+			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
+		}
+	}
+
 	error =3D xpad_init_output(intf, xpad);
 	if (error)
 		goto fail2;
--
1.6.4.4
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
