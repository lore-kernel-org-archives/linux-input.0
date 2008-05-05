From: "Michael Gruber" <backup.mg@gmx.de>
Subject: [PATCH 1/2] xpad - Allow mapping D-pad to buttons for all pads
Date: Mon, 05 May 2008 12:34:00 +0200
Message-ID: <20080505103400.284050@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:47433 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754711AbYEEKeB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 May 2008 06:34:01 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

=46rom: Michael Gruber <lists.mg@googlemail.com>

If the new module option force_dpad_to_buttons is set, the directional =
pad will
be mapped to 4buttons instead of 2axes for all controllers. This includ=
es those
in the list of known controllers which are not affected by the existing=
 option
dpad_to_buttons.

Signed-off-by: Michael Gruber <lists.mg@googlemail.com>

---

The ability to switch between axes and buttons mode is already present =
in the
driver but it is only possible if the connected controller is not known=
 by the
driver. This patch makes the feature available for all pads.

 Documentation/input/xpad.txt  |    4 +++-
 drivers/input/joystick/xpad.c |    7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--- a/Documentation/input/xpad.txt	2008-04-14 01:50:14.000000000 +0200
+++ b/Documentation/input/xpad.txt	2008-04-30 16:04:23.000000000 +0200
@@ -25,7 +25,9 @@ not listed below), the driver will map t
 if you said N it will map the d-pad to buttons, which is needed for da=
nce
 style games to function correctly.  The default is Y.
=20
-dpad_to_buttons has no effect for known pads.
+dpad_to_buttons has no effect for known pads. If you want to override =
the
+d-pad mapping to use buttons instead of axes for a known controller yo=
u
+should set force_dpad_to_buttons to Y. The default is N.
=20
 0.1 Normal Controllers
 ----------------------
--- a/drivers/input/joystick/xpad.c	2008-04-15 10:41:42.000000000 +0200
+++ b/drivers/input/joystick/xpad.c	2008-04-30 15:11:14.000000000 +0200
@@ -98,6 +98,9 @@
 static int dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
 MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than ax=
es for unknown pads");
+static int force_dpad_to_buttons;
+module_param(force_dpad_to_buttons, bool, S_IRUGO);
+MODULE_PARM_DESC(force_dpad_to_buttons, "Map D-PAD to buttons rather t=
han axes for all pads");
=20
 static const struct xpad_device {
 	u16 idVendor;
@@ -742,7 +745,9 @@ static int xpad_probe(struct usb_interfa
 	xpad->udev =3D udev;
 	xpad->dpad_mapping =3D xpad_device[i].dpad_mapping;
 	xpad->xtype =3D xpad_device[i].xtype;
-	if (xpad->dpad_mapping =3D=3D MAP_DPAD_UNKNOWN)
+	if (force_dpad_to_buttons)
+		xpad->dpad_mapping =3D MAP_DPAD_TO_BUTTONS;
+	else if (xpad->dpad_mapping =3D=3D MAP_DPAD_UNKNOWN)
 		xpad->dpad_mapping =3D !dpad_to_buttons;
 	if (xpad->xtype =3D=3D XTYPE_UNKNOWN) {
 		if (intf->cur_altsetting->desc.bInterfaceClass =3D=3D USB_CLASS_VEND=
OR_SPEC) {

--=20
249 Spiele f=FCr nur 1 Preis. Die GMX Spieleflatrate schon ab 9,90 Euro=
=2E
Neu: Asterix bei den Olympischen Spielen: http://flat.games.gmx.de
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
