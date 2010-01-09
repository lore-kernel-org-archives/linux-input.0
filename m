From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 5/5] input: make xenbus device id constant
Date: Sat, 09 Jan 2010 13:56:18 +0100
Message-ID: <4B487CF2.1060108@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753600Ab0AIM5E@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Markus Armbruster <armbru@redhat.com>Anthony Liguori <a>
Cc: xen-devel@lists.xensource.com, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The ids field of the struct xenbus_device_id is constant in <linux/xen/=
xenbus.h>
so it is worth to make xenkbd_ids also constant.

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
diff -u -p a/drivers/input/xen-kbdfront.c b/drivers/input/xen-kbdfront.=
c
--- a/drivers/input/xen-kbdfront.c 2010-01-07 19:08:40.000000000 +0100
+++ b/drivers/input/xen-kbdfront.c 2010-01-08 19:23:27.000000000 +0100
@@ -321,7 +321,7 @@ InitWait:
 	}
 }

-static struct xenbus_device_id xenkbd_ids[] =3D {
+static const struct xenbus_device_id xenkbd_ids[] =3D {
 	{ "vkbd" },
 	{ "" }
 };
