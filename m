From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 4/5] input: make pnp device id constant
Date: Sat, 09 Jan 2010 13:56:11 +0100
Message-ID: <4B487CEB.60003@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753985Ab0AIM42@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The id_table field of the struct pnp_driver is constant in <linux/pnp.h=
>
so it is worth to make pnp_devids also constant.

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
diff -u -p a/drivers/input/gameport/ns558.c b/drivers/input/gameport/ns=
558.c
--- a/drivers/input/gameport/ns558.c 2009-12-03 04:51:21.000000000 +010=
0
+++ b/drivers/input/gameport/ns558.c 2010-01-08 19:23:15.000000000 +010=
0
@@ -166,7 +166,7 @@ static int ns558_isa_probe(int io)

 #ifdef CONFIG_PNP

-static struct pnp_device_id pnp_devids[] =3D {
+static const struct pnp_device_id pnp_devids[] =3D {
 	{ .id =3D "@P@0001", .driver_data =3D 0 }, /* ALS 100 */
 	{ .id =3D "@P@0020", .driver_data =3D 0 }, /* ALS 200 */
 	{ .id =3D "@P@1001", .driver_data =3D 0 }, /* ALS 100+ */
