From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] input: make USB device id constant
Date: Sun, 10 Jan 2010 11:51:39 +0100
Message-ID: <4B49B13B.8070604@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <cocci-bounces@diku.dk>
List-Unsubscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=unsubscribe>
List-Archive: <http://lists.diku.dk/pipermail/cocci>
List-Post: <mailto:cocci@diku.dk>
List-Help: <mailto:cocci-request@diku.dk?subject=help>
List-Subscribe: <http://lists.diku.dk/mailman/listinfo/cocci>,
	<mailto:cocci-request@diku.dk?subject=subscribe>
Sender: cocci-bounces@diku.dk
Errors-To: cocci-bounces@diku.dk
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@diku.dk, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The id_table field of the struct usb_device_id is constant in <linux/usb.=
h>
so it is worth to make the initialization data also constant.

The semantic match that finds this kind of pattern is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
disable decl_init,const_decl_init;
identifier I1, I2, x;
@@
	struct I1 {
	  ...
	  const struct I2 *x;
	  ...
	};
@s@
identifier r.I1, y;
identifier r.x, E;
@@
	struct I1 y =3D {
	  .x =3D E,
	};
@c@
identifier r.I2;
identifier s.E;
@@
	const struct I2 E[] =3D ... ;
@depends on !c@
identifier r.I2;
identifier s.E;
@@
+	const
	struct I2 E[] =3D ...;
// </smpl>

Signed-off-by: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>
Cc: Julia Lawall <julia@diku.dk>
Cc: cocci@diku.dk
---
diff -u -p a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
--- a/drivers/input/tablet/gtco.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/input/tablet/gtco.c 2010-01-08 19:11:02.000000000 +0100
@@ -92,7 +92,7 @@ Scott Hill shill@gtcocalcomp.com
 /* DATA STRUCTURES */

 /* Device table */
-static struct usb_device_id gtco_usbid_table [] =3D {
+static const struct usb_device_id gtco_usbid_table[] =3D {
 	{ USB_DEVICE(VENDOR_ID_GTCO, PID_400) },
 	{ USB_DEVICE(VENDOR_ID_GTCO, PID_401) },
 	{ USB_DEVICE(VENDOR_ID_GTCO, PID_1000) },
diff -u -p a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/t=
ouchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c 2010-01-07 19:08:40.0000=
00000 +0100
+++ b/drivers/input/touchscreen/usbtouchscreen.c 2010-01-08 19:17:10.0000=
00000 +0100
@@ -144,7 +144,7 @@ enum {
 	.bInterfaceClass =3D USB_INTERFACE_CLASS_HID, \
 	.bInterfaceProtocol =3D USB_INTERFACE_PROTOCOL_MOUSE

-static struct usb_device_id usbtouch_devices[] =3D {
+static const struct usb_device_id usbtouch_devices[] =3D {
 #ifdef CONFIG_TOUCHSCREEN_USB_EGALAX
 	/* ignore the HID capable devices, handled by usbhid */
 	{USB_DEVICE_HID_CLASS(0x0eef, 0x0001), .driver_info =3D DEVTYPE_IGNORE}=
,
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
