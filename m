From: John Hiesey <john@endlessm.com>
Subject: [PATCH] i8042 self test causes trackpad to fail on Asus X455L
Date: Thu, 24 Sep 2015 12:14:45 -0700
Message-ID: <F38873EC-2B41-48B4-BEF8-26731AC02E7E@endlessm.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34997 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbbIXTOs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Sep 2015 15:14:48 -0400
Received: by pacfv12 with SMTP id fv12so82314759pac.2
        for <linux-input@vger.kernel.org>; Thu, 24 Sep 2015 12:14:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Drake <drake@endlessm.com>

I have an Asus laptop with a PS/2 trackpad that stops working until reb=
oot any time i8042_controller_selftest() is called. By =E2=80=9Cstops w=
orking" I mean that there are no interrupts generated when the trackpad=
 is touched/clicked.

Normally i8042_controller_selftest() seems to be called on suspend and =
resume only, which led to my originally observed problem where the trac=
kpad wouldn=E2=80=99t work after resume.

If never calling i8042_controller_selftest()/never sending the I8042_CM=
D_CTL_TEST command seems to work properly on this hardware, are there a=
ny consequences of doing this that I might not be aware of?

Here=E2=80=99s the draft of my patch that works on this hardware:

=46rom 32b4766f4afe349dde51043f4c9dd06b69e323cc Mon Sep 17 00:00:00 200=
1
=46rom: John Hiesey <john@hiesey.com>
Date: Wed, 23 Sep 2015 19:09:33 -0700
Subject: [PATCH] Input: i8042 - don't run self test on Asus X455LAB

On this model, any time the self test command is sent to the
i8042 controller the trackpad stops sending data. Never send the
self test command when this model is detected with DMI.

---
 drivers/input/serio/i8042.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index cb5ece7..469e4d2 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -24,6 +24,7 @@
 #include <linux/platform_device.h>
 #include <linux/i8042.h>
 #include <linux/slab.h>
+#include <linux/dmi.h>
=20
 #include <asm/io.h>
=20
@@ -133,6 +134,7 @@ static bool i8042_kbd_irq_registered;
 static bool i8042_aux_irq_registered;
 static unsigned char i8042_suppress_kbd_ack;
 static struct platform_device *i8042_platform_device;
+static bool i8042_noselftest;
=20
 static irqreturn_t i8042_interrupt(int irq, void *dev_id);
 static bool (*i8042_platform_filter)(unsigned char data, unsigned char=
 str,
@@ -884,6 +886,13 @@ static int i8042_controller_selftest(void)
 	int i =3D 0;
=20
 	/*
+	 * On some hardware just running the self test causes problems.
+	 * In that case, don't run the test and just assume success.
+	 */
+	if (i8042_noselftest)
+		return 0;
+
+	/*
 	 * We try this 5 times; on some really fragile systems this does not
 	 * take the first time...
 	 */
@@ -1496,6 +1505,16 @@ static int i8042_remove(struct platform_device *=
dev)
 	return 0;
 }
=20
+static const struct dmi_system_id i8042_dmi_noselftest_table[] __initc=
onst =3D {
+	{
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X455LAB"),
+		},
+	},
+	{}
+};
+
 static struct platform_driver i8042_driver =3D {
 	.driver		=3D {
 		.name	=3D "i8042",
@@ -1513,6 +1532,8 @@ static int __init i8042_init(void)
 	int err;
=20
 	dbg_init();
+	if (dmi_check_system(i8042_dmi_noselftest_table))
+		i8042_noselftest =3D true;
=20
 	err =3D i8042_platform_init();
 	if (err)
--=20
2.5.3


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
