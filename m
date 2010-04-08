From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 2/4] Add RC5x support to ir-core
Date: Fri, 09 Apr 2010 01:04:30 +0200
Message-ID: <20100408230430.14453.74921.stgit@localhost.localdomain>
References: <20100408230246.14453.97377.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:45504 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933780Ab0DHXEf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Apr 2010 19:04:35 -0400
In-Reply-To: <20100408230246.14453.97377.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mchehab@redhat.com
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

This patch adds RC5x support to drivers/media/IR/ir-rc5-decoder.c

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>
---
 drivers/media/IR/ir-rc5-decoder.c |   78 ++++++++++++++++++++++++++++-=
--------
 1 files changed, 59 insertions(+), 19 deletions(-)

diff --git a/drivers/media/IR/ir-rc5-decoder.c b/drivers/media/IR/ir-rc=
5-decoder.c
index 59bcaa9..c970ab2 100644
--- a/drivers/media/IR/ir-rc5-decoder.c
+++ b/drivers/media/IR/ir-rc5-decoder.c
@@ -1,4 +1,4 @@
-/* ir-rc5-decoder.c - handle RC-5 IR Pulse/Space protocol
+/* ir-rc5-decoder.c - handle RC5(x) IR Pulse/Space protocol
  *
  * Copyright (C) 2010 by Mauro Carvalho Chehab <mchehab@redhat.com>
  *
@@ -13,15 +13,19 @@
  */
=20
 /*
- * This code only handles 14 bits RC-5 protocols. There are other vari=
ants
- * that use a different number of bits. This is currently unsupported
- * It considers a carrier of 36 kHz, with a total of 14 bits, where
+ * This code handles 14 bits RC5 protocols and 20 bits RC5x protocols.
+ * There are other variants that use a different number of bits.
+ * This is currently unsupported.
+ * It considers a carrier of 36 kHz, with a total of 14/20 bits, where
  * the first two bits are start bits, and a third one is a filing bit
  */
=20
 #include "ir-core-priv.h"
=20
 #define RC5_NBITS		14
+#define RC5X_NBITS		20
+#define CHECK_RC5X_NBITS	8
+#define RC5X_SPACE		SPACE(4)
 #define RC5_UNIT		888888 /* ns */
=20
 /* Used to register rc5_decoder clients */
@@ -32,6 +36,7 @@ enum rc5_state {
 	STATE_INACTIVE,
 	STATE_BIT_START,
 	STATE_BIT_END,
+	STATE_CHECK_RC5X,
 	STATE_FINISHED,
 };
=20
@@ -45,6 +50,7 @@ struct decoder_data {
 	u32			rc5_bits;
 	int			last_unit;
 	unsigned		count;
+	unsigned		wanted_bits;
 };
=20
=20
@@ -126,7 +132,7 @@ static int ir_rc5_decode(struct input_dev *input_de=
v, s64 duration)
 {
 	struct decoder_data *data;
 	struct ir_input_dev *ir_dev =3D input_get_drvdata(input_dev);
-	u8 command, system, toggle;
+	u8 toggle;
 	u32 scancode;
 	int u;
=20
@@ -147,7 +153,7 @@ static int ir_rc5_decode(struct input_dev *input_de=
v, s64 duration)
 		goto out;
=20
 again:
-	IR_dprintk(2, "RC5 decode started at state %i (%i units, %ius)\n",
+	IR_dprintk(2, "RC5(x) decode started at state %i (%i units, %ius)\n",
 		   data->state, u, TO_US(duration));
=20
 	if (DURATION(u) =3D=3D 0 && data->state !=3D STATE_FINISHED)
@@ -159,6 +165,8 @@ again:
 		if (IS_PULSE(u)) {
 			data->state =3D STATE_BIT_START;
 			data->count =3D 1;
+			/* We just need enough bits to get to STATE_CHECK_RC5X */
+			data->wanted_bits =3D RC5X_NBITS;
 			DECREASE_DURATION(u, 1);
 			goto again;
 		}
@@ -176,7 +184,7 @@ again:
 			 * If the last bit is zero, a space will merge
 			 * with the silence after the command.
 			 */
-			if (IS_PULSE(u) && data->count =3D=3D RC5_NBITS) {
+			if (IS_PULSE(u) && data->count =3D=3D data->wanted_bits) {
 				data->state =3D STATE_FINISHED;
 				goto again;
 			}
@@ -188,8 +196,10 @@ again:
=20
 	case STATE_BIT_END:
 		if (IS_TRANSITION(u, data->last_unit)) {
-			if (data->count =3D=3D RC5_NBITS)
+			if (data->count =3D=3D data->wanted_bits)
 				data->state =3D STATE_FINISHED;
+			else if (data->count =3D=3D CHECK_RC5X_NBITS)
+				data->state =3D STATE_CHECK_RC5X;
 			else
 				data->state =3D STATE_BIT_START;
=20
@@ -198,22 +208,52 @@ again:
 		}
 		break;
=20
+	case STATE_CHECK_RC5X:
+		if (IS_SPACE(u) && DURATION(u) >=3D DURATION(RC5X_SPACE)) {
+			/* RC5X */
+			data->wanted_bits =3D RC5X_NBITS;
+			DECREASE_DURATION(u, DURATION(RC5X_SPACE));
+		} else {
+			/* RC5 */
+			data->wanted_bits =3D RC5_NBITS;
+		}
+		data->state =3D STATE_BIT_START;
+		goto again;
+
 	case STATE_FINISHED:
-		command  =3D (data->rc5_bits & 0x0003F) >> 0;
-		system   =3D (data->rc5_bits & 0x007C0) >> 6;
-		toggle   =3D (data->rc5_bits & 0x00800) ? 1 : 0;
-		command +=3D (data->rc5_bits & 0x01000) ? 0 : 0x40;
-		scancode =3D system << 8 | command;
-
-		IR_dprintk(1, "RC5 scancode 0x%04x (toggle: %u)\n",
-			   scancode, toggle);
+		if (data->wanted_bits =3D=3D RC5X_NBITS) {
+			/* RC5X */
+			u8 xdata, command, system;
+			xdata    =3D (data->rc5_bits & 0x0003F) >> 0;
+			command  =3D (data->rc5_bits & 0x00FC0) >> 6;
+			system   =3D (data->rc5_bits & 0x1F000) >> 12;
+			toggle   =3D (data->rc5_bits & 0x20000) ? 1 : 0;
+			command +=3D (data->rc5_bits & 0x01000) ? 0 : 0x40;
+			scancode =3D system << 16 | command << 8 | xdata;
+
+			IR_dprintk(1, "RC5X scancode 0x%06x (toggle: %u)\n",
+				   scancode, toggle);
+
+		} else {
+			/* RC5 */
+			u8 command, system;
+			command  =3D (data->rc5_bits & 0x0003F) >> 0;
+			system   =3D (data->rc5_bits & 0x007C0) >> 6;
+			toggle   =3D (data->rc5_bits & 0x00800) ? 1 : 0;
+			command +=3D (data->rc5_bits & 0x01000) ? 0 : 0x40;
+			scancode =3D system << 8 | command;
+
+			IR_dprintk(1, "RC5 scancode 0x%04x (toggle: %u)\n",
+				   scancode, toggle);
+		}
+
 		ir_keydown(input_dev, scancode, toggle);
 		data->state =3D STATE_INACTIVE;
 		return 0;
 	}
=20
 out:
-	IR_dprintk(1, "RC5 decode failed at state %i (%i units, %ius)\n",
+	IR_dprintk(1, "RC5(x) decode failed at state %i (%i units, %ius)\n",
 		   data->state, u, TO_US(duration));
 	data->state =3D STATE_INACTIVE;
 	return -EINVAL;
@@ -273,7 +313,7 @@ static int __init ir_rc5_decode_init(void)
 {
 	ir_raw_handler_register(&rc5_handler);
=20
-	printk(KERN_INFO "IR RC-5 protocol handler initialized\n");
+	printk(KERN_INFO "IR RC5(x) protocol handler initialized\n");
 	return 0;
 }
=20
@@ -288,4 +328,4 @@ module_exit(ir_rc5_decode_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mauro Carvalho Chehab <mchehab@redhat.com>");
 MODULE_AUTHOR("Red Hat Inc. (http://www.redhat.com)");
-MODULE_DESCRIPTION("RC-5 IR protocol decoder");
+MODULE_DESCRIPTION("RC5(x) IR protocol decoder");

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
