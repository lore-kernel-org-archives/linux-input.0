From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 2/5] input: make Open Firmware device id constant
Date: Sat, 09 Jan 2010 13:55:56 +0100
Message-ID: <4B487CDC.80303@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752977Ab0AIM4M@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The match_table field of the struct of_device_id is constant in <linux/=
of_platform.h>
so it is worth to make xps2_of_match also constant.

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
diff -u -p a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xil=
inx_ps2.c
--- a/drivers/input/serio/xilinx_ps2.c 2009-12-03 04:51:21.000000000 +0=
100
+++ b/drivers/input/serio/xilinx_ps2.c 2010-01-08 19:13:45.000000000 +0=
100
@@ -354,7 +354,7 @@ static int __devexit xps2_of_remove(stru
 }

 /* Match table for of_platform binding */
-static struct of_device_id xps2_of_match[] __devinitdata =3D {
+static const struct of_device_id xps2_of_match[] __devinitconst =3D {
 	{ .compatible =3D "xlnx,xps-ps2-1.00.a", },
 	{ /* end of list */ },
 };
