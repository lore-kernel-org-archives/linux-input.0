From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH] hid: make USB device id constant
Date: Sun, 10 Jan 2010 17:59:22 +0100
Message-ID: <4B4A076A.8020207@freemail.hu>
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
To: Jiri Kosina <jkosina@suse.cz>
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
diff -u -p a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.=
c
--- a/drivers/hid/usbhid/hid-core.c 2010-01-07 19:08:40.000000000 +0100
+++ b/drivers/hid/usbhid/hid-core.c 2010-01-08 18:55:16.000000000 +0100
@@ -1342,7 +1342,7 @@ static int hid_reset_resume(struct usb_i

 #endif /* CONFIG_PM */

-static struct usb_device_id hid_usb_ids [] =3D {
+static const struct usb_device_id hid_usb_ids[] =3D {
 	{ .match_flags =3D USB_DEVICE_ID_MATCH_INT_CLASS,
 		.bInterfaceClass =3D USB_INTERFACE_CLASS_HID },
 	{ }						/* Terminating entry */
_______________________________________________
Cocci mailing list
Cocci@diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
