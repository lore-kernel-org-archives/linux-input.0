From: =?UTF-8?B?TsOpbWV0aCBNw6FydG9u?= <nm127@freemail.hu>
Subject: [PATCH 3/5] input: make PCI device id constant
Date: Sat, 09 Jan 2010 13:56:03 +0100
Message-ID: <4B487CE3.5000500@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail02d.mail.t-online.hu ([84.2.42.7]:50270 "EHLO
	mail02d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab0AIM4L (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 Jan 2010 07:56:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

=46rom: M=C3=A1rton N=C3=A9meth <nm127@freemail.hu>

The id_table field of the struct pci_driver is constant in <linux/pci.h=
>
so it is worth to make initialization data also constant.

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
diff -u -p a/drivers/input/serio/pcips2.c b/drivers/input/serio/pcips2.=
c
--- a/drivers/input/serio/pcips2.c 2009-12-03 04:51:21.000000000 +0100
+++ b/drivers/input/serio/pcips2.c 2010-01-08 19:12:05.000000000 +0100
@@ -186,7 +186,7 @@ static void __devexit pcips2_remove(stru
 	pci_disable_device(dev);
 }

-static struct pci_device_id pcips2_ids[] =3D {
+static const struct pci_device_id pcips2_ids[] =3D {
 	{
 		.vendor		=3D 0x14f2,	/* MOBILITY */
 		.device		=3D 0x0123,	/* Keyboard */
diff -u -p a/drivers/input/gameport/fm801-gp.c b/drivers/input/gameport=
/fm801-gp.c
--- a/drivers/input/gameport/fm801-gp.c 2009-12-03 04:51:21.000000000 +=
0100
+++ b/drivers/input/gameport/fm801-gp.c 2010-01-08 19:22:57.000000000 +=
0100
@@ -140,7 +140,7 @@ static void __devexit fm801_gp_remove(st
 	}
 }

-static struct pci_device_id fm801_gp_id_table[] =3D {
+static const struct pci_device_id fm801_gp_id_table[] =3D {
 	{ PCI_VENDOR_ID_FORTEMEDIA, PCI_DEVICE_ID_FM801_GP, PCI_ANY_ID, PCI_A=
NY_ID, 0, 0, 0  },
 	{ 0 }
 };
diff -u -p a/drivers/input/gameport/emu10k1-gp.c b/drivers/input/gamepo=
rt/emu10k1-gp.c
--- a/drivers/input/gameport/emu10k1-gp.c 2009-12-03 04:51:21.000000000=
 +0100
+++ b/drivers/input/gameport/emu10k1-gp.c 2010-01-08 19:23:20.000000000=
 +0100
@@ -46,7 +46,7 @@ struct emu {
 	int size;
 };

-static struct pci_device_id emu_tbl[] =3D {
+static const struct pci_device_id emu_tbl[] =3D {

 	{ 0x1102, 0x7002, PCI_ANY_ID, PCI_ANY_ID }, /* SB Live gameport */
 	{ 0x1102, 0x7003, PCI_ANY_ID, PCI_ANY_ID }, /* Audigy gameport */
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
