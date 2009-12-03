From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] (uu.6cd36bd9ef57) joystick/xpad.c -- Support HORI
	RAP.EX/MadCatz Fightpad
Date: Wed, 2 Dec 2009 19:13:21 -0800
Message-ID: <20091203031321.GD9121@core.coreip.homeip.net>
References: <4B08FC8A.6030404@free.fr> <20091126060443.GJ23244@core.coreip.homeip.net> <75261F2D-4244-4587-9B17-98322189DDCD@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:55904 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbZLCDNT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2009 22:13:19 -0500
Received: by pzk14 with SMTP id 14so871361pzk.23
        for <linux-input@vger.kernel.org>; Wed, 02 Dec 2009 19:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <75261F2D-4244-4587-9B17-98322189DDCD@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nicolas =?iso-8859-1?Q?L=E9veill=E9?= <knos@free.fr>
Cc: linux-input@vger.kernel.org

On Thu, Nov 26, 2009 at 11:27:58AM +0100, Nicolas L=E9veill=E9 wrote:
> Hi, thanks for the feedback.
>=20
> I'll soon resend the first two patches as properly formatted ones.
> (git format-patch this time)
>=20
> About the third one adding a "trigger_mapping" option:
>=20
> When reusing the dpad_mapping field to add new options to it are you
> thinking about turning it into a numerical constant that goes 0-1-2-3
> for all mapping combinations?=20

Rather a bitmap for mapping AXIS and DPAD to button.

>=20
> It does not needlessly break user space's configuration scripts,
> however the name and semantics of the option are more complicated.
>=20
> In particular the semantics of the existing dpad_mapping option is a
> bit strange already, since it only act on "unknown" devices / do not
> act on known devices.=20

The idea was is that for known devices the selection option is the
proper one and it does not make sense to change it.

>=20
> Which I'm not sure works anyway? My devices only started to work when
> I registered their vendor and product id.=20

We bind depening on vendor and interface. If vendor is known but
particular model is not it will be "Unknown" and you can remap.

>=20
> Why not allow overriding mappings of a known device?

See above.

So, could you please try the patch below and let me know if I broke it?
I already applied your other patch adding new devices.

Thanks!

--=20
Dmitry


Input: xpad - allow using triggers as buttons rather than axes

=46rom: Nicolas L=E9veill=E9 <knos@free.fr>

Certain devices implement triggers as buttons rather than axes. In
particular, arcade sticks such as the HORI Real Arcade Pro.EX do not
have analog buttons.

These devices are now setup to present buttons rather than axes for
triggers.

User-space applications often also have problems with
axes-as-buttons. Activating MAP_TRIGGERS_TO_BUTTONS for a device
removes the artificial difference between buttons and triggers.

Signed-off-by: Nicolas L=E9veill=E9 <nicolas@uucidl.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/xpad.c |  200 +++++++++++++++++++++++++--------=
--------
 1 files changed, 121 insertions(+), 79 deletions(-)


diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
index 482cb12..5483fb9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -86,9 +86,8 @@
=20
 /* xbox d-pads should map to buttons, as is required for DDR pads
    but we map them to axes when possible to simplify things */
-#define MAP_DPAD_TO_BUTTONS    0
-#define MAP_DPAD_TO_AXES       1
-#define MAP_DPAD_UNKNOWN       2
+#define MAP_DPAD_TO_BUTTONS		(1 << 0)
+#define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
=20
 #define XTYPE_XBOX        0
 #define XTYPE_XBOX360     1
@@ -99,57 +98,61 @@ static int dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than ax=
es for unknown pads");
=20
+static int triggers_to_buttons;
+module_param(triggers_to_buttons, bool, S_IRUGO);
+MODULE_PARM_DESC(triggers_to_buttons, "Map triggers to buttons rather =
than axes for unknown pads");
+
 static const struct xpad_device {
 	u16 idVendor;
 	u16 idProduct;
 	char *name;
-	u8 dpad_mapping;
+	u8 mapping;
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
+	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
+	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
+	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
+	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, =
XTYPE_XBOX360W },
 	{ 0x0c12, 0x8809, "RedOctane Xbox Dance Pad", MAP_DPAD_TO_BUTTONS, XT=
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
+	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
+	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360=
 },
+	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX =
},
+	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XB=
OX },
+	{ 0x05fd, 0x1007, "Mad Catz Controller (unverified)", 0, XTYPE_XBOX }=
,
+	{ 0x05fd, 0x107a, "InterAct 'PowerPad Pro' X-Box pad (Germany)", 0, X=
TYPE_XBOX },
+	{ 0x0738, 0x4516, "Mad Catz Control Pad", 0, XTYPE_XBOX },
+	{ 0x0738, 0x4522, "Mad Catz LumiCON", 0, XTYPE_XBOX },
+	{ 0x0738, 0x4526, "Mad Catz Control Pad Pro", 0, XTYPE_XBOX },
+	{ 0x0738, 0x4536, "Mad Catz MicroCON", 0, XTYPE_XBOX },
 	{ 0x0738, 0x4540, "Mad Catz Beat Pad", MAP_DPAD_TO_BUTTONS, XTYPE_XBO=
X },
-	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", MAP_DPAD_TO_AX=
ES, XTYPE_XBOX },
-	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", MAP_DPAD_TO_A=
XES, XTYPE_XBOX360 },
-	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_DP=
AD_TO_AXES, XTYPE_XBOX360 },
+	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", 0, XTYPE_XBOX =
},
+	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", 0, XTYPE_XBOX=
360 },
+	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_TR=
IGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0x6040, "Mad Catz Beat Pad Pro", MAP_DPAD_TO_BUTTONS, XTYPE=
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
+	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
+	{ 0x0c12, 0x880a, "Pelican Eclipse PL-2023", 0, XTYPE_XBOX },
+	{ 0x0c12, 0x8810, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
+	{ 0x0c12, 0x9902, "HAMA VibraX - *FAULTY HARDWARE*", 0, XTYPE_XBOX },
+	{ 0x0e4c, 0x1097, "Radica Gamester Controller", 0, XTYPE_XBOX },
+	{ 0x0e4c, 0x2390, "Radica Games Jtech Controller", 0, XTYPE_XBOX },
+	{ 0x0e6f, 0x0003, "Logic3 Freebird wireless Controller", 0, XTYPE_XBO=
X },
+	{ 0x0e6f, 0x0005, "Eclipse wireless Controller", 0, XTYPE_XBOX },
+	{ 0x0e6f, 0x0006, "Edge wireless Controller", 0, XTYPE_XBOX },
+	{ 0x0e6f, 0x0006, "Pelican 'TSZ' Wired Xbox 360 Controller", 0, XTYPE=
_XBOX360 },
+	{ 0x0e8f, 0x0201, "SmartJoy Frag Xpad/PS2 adaptor", 0, XTYPE_XBOX },
+	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
+	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
+	{ 0x102c, 0xff0c, "Joytech Wireless Advanced Controller", 0, XTYPE_XB=
OX },
 	{ 0x12ab, 0x8809, "Xbox DDR dancepad", MAP_DPAD_TO_BUTTONS, XTYPE_XBO=
X },
-	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", MAP_DPAD_TO_AXES,=
 XTYPE_XBOX360 },
+	{ 0x1430, 0x4748, "RedOctane Guitar Hero X-plorer", 0, XTYPE_XBOX360 =
},
 	{ 0x1430, 0x8888, "TX6500+ Dance Pad (first generation)", MAP_DPAD_TO=
_BUTTONS, XTYPE_XBOX },
-	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", MAP_DPAD_=
TO_AXES, XTYPE_XBOX360 },
-	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", MAP_DPAD_TO_AXES, XTYPE_=
XBOX360 },
+	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_=
XBOX360 },
+	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x1bad, 0x0003, "Harmonix Rock Band Drumkit", MAP_DPAD_TO_BUTTONS, =
XTYPE_XBOX360 },
-	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_DPAD_TO_AXES, XTYPE_=
XBOX360 },
-	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", MAP_DPAD_TO_AXES, X=
TYPE_XBOX },
-	{ 0x0000, 0x0000, "Generic X-Box pad", MAP_DPAD_UNKNOWN, XTYPE_UNKNOW=
N }
+	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_TRIGGERS_TO_BUTTONS,=
 XTYPE_XBOX360 },
+	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
+	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
 };
=20
 /* buttons shared with xbox and xbox360 */
@@ -165,13 +168,20 @@ static const signed short xpad_btn[] =3D {
 	-1			/* terminating entry */
 };
=20
-/* only used if MAP_DPAD_TO_BUTTONS */
+/* used when dpad is mapped to nuttons */
 static const signed short xpad_btn_pad[] =3D {
 	BTN_LEFT, BTN_RIGHT,		/* d-pad left, right */
 	BTN_0, BTN_1,			/* d-pad up, down (XXX names??) */
 	-1				/* terminating entry */
 };
=20
+/* used when triggers are mapped to buttons */
+static const signed short xpad_btn_triggers[] =3D {
+	BTN_TL2, BTN_TR2,		/* triggers left/right */
+	-1
+};
+
+
 static const signed short xpad360_btn[] =3D {  /* buttons for x360 con=
troller */
 	BTN_TL, BTN_TR,		/* Button LB/RB */
 	BTN_MODE,		/* The big X button */
@@ -181,16 +191,21 @@ static const signed short xpad360_btn[] =3D {  /*=
 buttons for x360 controller */
 static const signed short xpad_abs[] =3D {
 	ABS_X, ABS_Y,		/* left stick */
 	ABS_RX, ABS_RY,		/* right stick */
-	ABS_Z, ABS_RZ,		/* triggers left/right */
 	-1			/* terminating entry */
 };
=20
-/* only used if MAP_DPAD_TO_AXES */
+/* used when dpad is mapped to axes */
 static const signed short xpad_abs_pad[] =3D {
 	ABS_HAT0X, ABS_HAT0Y,	/* d-pad axes */
 	-1			/* terminating entry */
 };
=20
+/* used when triggers are mapped to axes */
+static const signed short xpad_abs_triggers[] =3D {
+	ABS_Z, ABS_RZ,		/* triggers left/right */
+	-1
+};
+
 /* Xbox 360 has a vendor-specific class, so we cannot match it with on=
ly
  * USB_INTERFACE_INFO (also specifically refused by USB subsystem), so=
 we
  * match against vendor id as well. Wired Xbox 360 devices have protoc=
ol 1,
@@ -246,7 +261,7 @@ struct usb_xpad {
=20
 	char phys[64];			/* physical device path */
=20
-	int dpad_mapping;		/* map d-pad to buttons or to axes */
+	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
 };
=20
@@ -277,20 +292,25 @@ static void xpad_process_packet(struct usb_xpad *=
xpad, u16 cmd, unsigned char *d
 			 ~(__s16) le16_to_cpup((__le16 *)(data + 18)));
=20
 	/* triggers left/right */
-	input_report_abs(dev, ABS_Z, data[10]);
-	input_report_abs(dev, ABS_RZ, data[11]);
+	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
+		input_report_key(dev, BTN_TL2, data[10]);
+		input_report_key(dev, BTN_TR2, data[11]);
+	} else {
+		input_report_abs(dev, ABS_Z, data[10]);
+		input_report_abs(dev, ABS_RZ, data[11]);
+	}
=20
 	/* digital pad */
-	if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES) {
-		input_report_abs(dev, ABS_HAT0X,
-				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
-		input_report_abs(dev, ABS_HAT0Y,
-				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
-	} else /* xpad->dpad_mapping =3D=3D MAP_DPAD_TO_BUTTONS */ {
+	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		input_report_key(dev, BTN_LEFT,  data[2] & 0x04);
 		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
 		input_report_key(dev, BTN_0,     data[2] & 0x01); /* up */
 		input_report_key(dev, BTN_1,     data[2] & 0x02); /* down */
+	} else {
+		input_report_abs(dev, ABS_HAT0X,
+				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
+		input_report_abs(dev, ABS_HAT0Y,
+				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
 	}
=20
 	/* start/back buttons and stick press left/right */
@@ -328,17 +348,17 @@ static void xpad360_process_packet(struct usb_xpa=
d *xpad,
 	struct input_dev *dev =3D xpad->dev;
=20
 	/* digital pad */
-	if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES) {
-		input_report_abs(dev, ABS_HAT0X,
-				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
-		input_report_abs(dev, ABS_HAT0Y,
-				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
-	} else if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_BUTTONS) {
+	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		/* dpad as buttons (right, left, down, up) */
 		input_report_key(dev, BTN_LEFT, data[2] & 0x04);
 		input_report_key(dev, BTN_RIGHT, data[2] & 0x08);
 		input_report_key(dev, BTN_0, data[2] & 0x01);	/* up */
 		input_report_key(dev, BTN_1, data[2] & 0x02);	/* down */
+	} else {
+		input_report_abs(dev, ABS_HAT0X,
+				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
+		input_report_abs(dev, ABS_HAT0Y,
+				 !!(data[2] & 0x02) - !!(data[2] & 0x01));
 	}
=20
 	/* start/back buttons */
@@ -371,8 +391,13 @@ static void xpad360_process_packet(struct usb_xpad=
 *xpad,
 			 ~(__s16) le16_to_cpup((__le16 *)(data + 12)));
=20
 	/* triggers left/right */
-	input_report_abs(dev, ABS_Z, data[4]);
-	input_report_abs(dev, ABS_RZ, data[5]);
+	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
+		input_report_key(dev, BTN_TL2, data[4]);
+		input_report_key(dev, BTN_TR2, data[5]);
+	} else {
+		input_report_abs(dev, ABS_Z, data[4]);
+		input_report_abs(dev, ABS_RZ, data[5]);
+	}
=20
 	input_sync(dev);
 }
@@ -712,11 +737,11 @@ static void xpad_set_up_abs(struct input_dev *inp=
ut_dev, signed short abs)
 		input_set_abs_params(input_dev, abs, -32768, 32767, 16, 128);
 		break;
 	case ABS_Z:
-	case ABS_RZ:	/* the triggers */
+	case ABS_RZ:	/* the triggers (if mapped to axes) */
 		input_set_abs_params(input_dev, abs, 0, 255, 0, 0);
 		break;
 	case ABS_HAT0X:
-	case ABS_HAT0Y:	/* the d-pad (only if MAP_DPAD_TO_AXES) */
+	case ABS_HAT0Y:	/* the d-pad (only if dpad is mapped to axes */
 		input_set_abs_params(input_dev, abs, -1, 1, 0, 0);
 		break;
 	}
@@ -752,10 +777,9 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
 		goto fail2;
=20
 	xpad->udev =3D udev;
-	xpad->dpad_mapping =3D xpad_device[i].dpad_mapping;
+	xpad->mapping =3D xpad_device[i].mapping;
 	xpad->xtype =3D xpad_device[i].xtype;
-	if (xpad->dpad_mapping =3D=3D MAP_DPAD_UNKNOWN)
-		xpad->dpad_mapping =3D !dpad_to_buttons;
+
 	if (xpad->xtype =3D=3D XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass =3D=3D USB_CLASS_VEND=
OR_SPEC) {
 			if (intf->cur_altsetting->desc.bInterfaceProtocol =3D=3D 129)
@@ -764,7 +788,13 @@ static int xpad_probe(struct usb_interface *intf, =
const struct usb_device_id *id
 				xpad->xtype =3D XTYPE_XBOX360;
 		} else
 			xpad->xtype =3D XTYPE_XBOX;
+
+		if (dpad_to_buttons)
+			xpad->mapping |=3D MAP_DPAD_TO_BUTTONS;
+		if (triggers_to_buttons)
+			xpad->mapping |=3D MAP_TRIGGERS_TO_BUTTONS;
 	}
+
 	xpad->dev =3D input_dev;
 	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
 	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
@@ -781,25 +811,37 @@ static int xpad_probe(struct usb_interface *intf,=
 const struct usb_device_id *id
=20
 	input_dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
=20
-	/* set up buttons */
+	/* set up standard buttons and axes */
 	for (i =3D 0; xpad_common_btn[i] >=3D 0; i++)
-		set_bit(xpad_common_btn[i], input_dev->keybit);
-	if ((xpad->xtype =3D=3D XTYPE_XBOX360) || (xpad->xtype =3D=3D XTYPE_X=
BOX360W))
-		for (i =3D 0; xpad360_btn[i] >=3D 0; i++)
-			set_bit(xpad360_btn[i], input_dev->keybit);
-	else
-		for (i =3D 0; xpad_btn[i] >=3D 0; i++)
-			set_bit(xpad_btn[i], input_dev->keybit);
-	if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_BUTTONS)
-		for (i =3D 0; xpad_btn_pad[i] >=3D 0; i++)
-			set_bit(xpad_btn_pad[i], input_dev->keybit);
+		__set_bit(xpad_common_btn[i], input_dev->keybit);
=20
-	/* set up axes */
 	for (i =3D 0; xpad_abs[i] >=3D 0; i++)
 		xpad_set_up_abs(input_dev, xpad_abs[i]);
-	if (xpad->dpad_mapping =3D=3D MAP_DPAD_TO_AXES)
+
+	/* Now set up model-specific ones */
+	if (xpad->xtype =3D=3D XTYPE_XBOX360 || xpad->xtype =3D=3D XTYPE_XBOX=
360W) {
+		for (i =3D 0; xpad360_btn[i] >=3D 0; i++)
+			__set_bit(xpad360_btn[i], input_dev->keybit);
+	} else {
+		for (i =3D 0; xpad_btn[i] >=3D 0; i++)
+			__set_bit(xpad_btn[i], input_dev->keybit);
+	}
+
+	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
+		for (i =3D 0; xpad_btn_pad[i] >=3D 0; i++)
+			__set_bit(xpad_btn_pad[i], input_dev->keybit);
+	} else {
 		for (i =3D 0; xpad_abs_pad[i] >=3D 0; i++)
 		    xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
+	}
+
+	if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
+		for (i =3D 0; xpad_btn_triggers[i] >=3D 0; i++)
+			__set_bit(xpad_btn_triggers[i], input_dev->keybit);
+	} else {
+		for (i =3D 0; xpad_abs_triggers[i] >=3D 0; i++)
+			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
+	}
=20
 	error =3D xpad_init_output(intf, xpad);
 	if (error)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
