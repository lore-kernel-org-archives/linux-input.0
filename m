From: =?ISO-8859-1?Q?Nicolas_L=E9veill=E9?= <knos@free.fr>
Subject: Re: [PATCH 3/3] (uu.6cd36bd9ef57) joystick/xpad.c -- Trigger buttons
 handling
Date: Sun, 22 Nov 2009 09:57:45 +0100
Message-ID: <4B08FD09.6020800@free.fr>
References: <4B08FC8A.6030404@free.fr> <4B08FCD3.2060502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:53502 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753903AbZKVJBr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Nov 2009 04:01:47 -0500
In-Reply-To: <4B08FCD3.2060502@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Third patch in a series of three.
--
    Added module parameter trigger_to_buttons, to let users force trigg=
ers
     to behave as buttons.

     Signed-off-by: Nicolas L=E9veill=E9 <nicolas@uucidl.com>

diff --git a/Documentation/input/xpad.txt b/Documentation/input/xpad.tx=
t
index aae0d40..01c9d1f 100644
--- a/Documentation/input/xpad.txt
+++ b/Documentation/input/xpad.txt
@@ -19,6 +19,9 @@ The number of buttons/axes reported varies based on 3=
=20
things:
  - if using an unknown device (one not listed below), what you set in =
the
    module configuration for "Map D-PAD to buttons rather than axes for=
=20
unknown
    pads" (module option dpad_to_buttons)
+- if triggers are mapped to buttons or axes. This depends on the devic=
e=20
and can be forced via module option triggers_to_buttons.
+
+dpad_to_buttons:

  If you set dpad_to_buttons to 0 and you are using an unknown device (=
one
  not listed below), the driver will map the directional pad to axes (X=
/Y),
@@ -27,6 +30,15 @@ style games to function correctly.  The default is Y=
=2E

  dpad_to_buttons has no effect for known pads.

+triggers_to_buttons:
+
+If you set triggers_to_buttons to 1 and you are using a device
+otherwise configured to map triggers to axes, the module will map them
+to digital buttons.
+
+Setting triggers_to_buttons to 0 does not do anything: it does not
+make sense to map a device digital button's into an axis.
+
  0.1 Normal Controllers
  ----------------------
  With a normal controller, the directional pad is mapped to its own X/=
Y=20
axes.
@@ -139,7 +151,7 @@ It works? Voila, you're done ;)

  I have to thank ITO Takayuki for the detailed info on his site
   http://euc.jp/periphs/xbox-controller.ja.html.
-
+
  His useful info and both the usb-skeleton as well as the iforce input=
=20
driver
  (Greg Kroah-Hartmann; Vojtech Pavlik) helped a lot in rapid prototypi=
ng
  the basic functionality.
@@ -173,7 +185,7 @@ I:  If#=3D 0 Alt=3D 0 #EPs=3D 2 Cls=3D58(unk. ) Sub=
=3D42=20
Prot=3D00 Driver=3Dxpad
  E:  Ad=3D82(I) Atr=3D03(Int.) MxPS=3D  32 Ivl=3D4ms
  E:  Ad=3D02(O) Atr=3D03(Int.) MxPS=3D  32 Ivl=3D4ms

---
+--
  Marko Friedemann <mfr@bmx-chemnitz.de>
  2002-07-16
   - original doc
@@ -181,3 +193,7 @@ Marko Friedemann <mfr@bmx-chemnitz.de>
  Dominic Cerquetti <binary1230@yahoo.com>
  2005-03-19
   - added stuff for dance pads, new d-pad->axes mappings
+
+Nicolas L=E9veill=E9 <nicolas@uucidl.com>
+2009-11-21
+ - added triggers remapping.
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
index 0d43838..7875494 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -102,6 +102,10 @@ static int dpad_to_buttons;
  module_param(dpad_to_buttons, bool, S_IRUGO);
  MODULE_PARM_DESC(dpad_to_buttons, "Map D-PAD to buttons rather than=20
axes for unknown pads");

+static int triggers_to_buttons;
+module_param(triggers_to_buttons, bool, S_IRUGO);
+MODULE_PARM_DESC(triggers_to_buttons, "Map triggers to buttons rather=20
than axes");
+
  static const struct xpad_device {
      u16 idVendor;
      u16 idProduct;
@@ -781,8 +785,16 @@ static int xpad_probe(struct usb_interface *intf,=20
const struct usb_device_id *id
      xpad->dpad_mapping =3D xpad_device[i].dpad_mapping;
      xpad->trigger_mapping =3D xpad_device[i].trigger_mapping;
      xpad->xtype =3D xpad_device[i].xtype;
+
      if (xpad->dpad_mapping =3D=3D MAP_DPAD_UNKNOWN)
          xpad->dpad_mapping =3D !dpad_to_buttons;
+
+    /* let module parameters override trigger_mapping */
+    if (triggers_to_buttons) {
+        printk (KERN_INFO "xpad: forcing triggers to map to buttons.\n=
");
+        xpad->trigger_mapping =3D MAP_TRIGGERS_TO_BUTTONS;
+    }
+
      if (xpad->xtype =3D=3D XTYPE_UNKNOWN) {
          if (intf->cur_altsetting->desc.bInterfaceClass =3D=3D=20
USB_CLASS_VENDOR_SPEC) {
              if (intf->cur_altsetting->desc.bInterfaceProtocol =3D=3D =
129)


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
