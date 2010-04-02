From: david@hardeman.nu
Subject: [patch 3/3] Convert drivers/media/dvb/ttpci/budget-ci.c to use ir-core
Date: Fri, 02 Apr 2010 20:58:30 +0200
Message-ID: <20100402190255.774628605@hardeman.nu>
References: <20100402185827.425741206@hardeman.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:49052 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876Ab0DBTDF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Apr 2010 15:03:05 -0400
Content-Disposition: inline; filename=convert-budget-ci-to-use-ir-core
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mchehab@infradead.org
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org

This patch converts drivers/media/dvb/ttpci/budget-ci.c to use ir-core
rather than rolling its own keydown timeout handler and reporting keys
via drivers/media/IR/ir-functions.c.

Signed-off-by: David H=C3=A4rdeman <david@hardeman.nu>


Index: ir/drivers/media/dvb/ttpci/budget-ci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ir.orig/drivers/media/dvb/ttpci/budget-ci.c	2010-04-02 16:41:15.524=
206900 +0200
+++ ir/drivers/media/dvb/ttpci/budget-ci.c	2010-04-02 16:48:15.66823943=
7 +0200
@@ -35,7 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/spinlock.h>
-#include <media/ir-common.h>
+#include <media/ir-core.h>
=20
 #include "budget.h"
=20
@@ -82,12 +82,6 @@
 #define SLOTSTATUS_READY	8
 #define SLOTSTATUS_OCCUPIED	(SLOTSTATUS_PRESENT|SLOTSTATUS_RESET|SLOTS=
TATUS_READY)
=20
-/*
- * Milliseconds during which a key is regarded as pressed.
- * If an identical command arrives within this time, the timer will st=
art over.
- */
-#define IR_KEYPRESS_TIMEOUT	250
-
 /* RC5 device wildcard */
 #define IR_DEVICE_ANY		255
=20
@@ -104,12 +98,9 @@
 struct budget_ci_ir {
 	struct input_dev *dev;
 	struct tasklet_struct msp430_irq_tasklet;
-	struct timer_list timer_keyup;
 	char name[72]; /* 40 + 32 for (struct saa7146_dev).name */
 	char phys[32];
-	struct ir_input_state state;
 	int rc5_device;
-	u32 last_raw;
 	u32 ir_key;
 	bool have_command;
 };
@@ -124,18 +115,11 @@
 	u8 tuner_pll_address; /* used for philips_tdm1316l configs */
 };
=20
-static void msp430_ir_keyup(unsigned long data)
-{
-	struct budget_ci_ir *ir =3D (struct budget_ci_ir *) data;
-	ir_input_nokey(ir->dev, &ir->state);
-}
-
 static void msp430_ir_interrupt(unsigned long data)
 {
 	struct budget_ci *budget_ci =3D (struct budget_ci *) data;
 	struct input_dev *dev =3D budget_ci->ir.dev;
 	u32 command =3D ttpci_budget_debiread(&budget_ci->budget, DEBINOSWAP,=
 DEBIADDR_IR, 2, 1, 0) >> 8;
-	u32 raw;
=20
 	/*
 	 * The msp430 chip can generate two different bytes, command and devi=
ce
@@ -171,20 +155,12 @@
 		return;
 	budget_ci->ir.have_command =3D false;
=20
+	/* FIXME: We should generate complete scancodes with device info */
 	if (budget_ci->ir.rc5_device !=3D IR_DEVICE_ANY &&
 	    budget_ci->ir.rc5_device !=3D (command & 0x1f))
 		return;
=20
-	/* Is this a repeated key sequence? (same device, command, toggle) */
-	raw =3D budget_ci->ir.ir_key | (command << 8);
-	if (budget_ci->ir.last_raw !=3D raw || !timer_pending(&budget_ci->ir.=
timer_keyup)) {
-		ir_input_nokey(dev, &budget_ci->ir.state);
-		ir_input_keydown(dev, &budget_ci->ir.state,
-				 budget_ci->ir.ir_key);
-		budget_ci->ir.last_raw =3D raw;
-	}
-
-	mod_timer(&budget_ci->ir.timer_keyup, jiffies + msecs_to_jiffies(IR_K=
EYPRESS_TIMEOUT));
+	ir_keydown(dev, budget_ci->ir.ir_key, (command & 0x20) ? 1 : 0);
 }
=20
 static int msp430_ir_init(struct budget_ci *budget_ci)
@@ -251,11 +227,6 @@
=20
 	ir_input_init(input_dev, &budget_ci->ir.state, IR_TYPE_RC5);
=20
-	/* initialise the key-up timeout handler */
-	init_timer(&budget_ci->ir.timer_keyup);
-	budget_ci->ir.timer_keyup.function =3D msp430_ir_keyup;
-	budget_ci->ir.timer_keyup.data =3D (unsigned long) &budget_ci->ir;
-	budget_ci->ir.last_raw =3D 0xffff; /* An impossible value */
 	error =3D ir_input_register(input_dev, ir_codes, NULL, MODULE_NAME);
 	if (error) {
 		printk(KERN_ERR "budget_ci: could not init driver for IR device (cod=
e %d)\n", error);
@@ -284,9 +255,6 @@
 	saa7146_setgpio(saa, 3, SAA7146_GPIO_INPUT);
 	tasklet_kill(&budget_ci->ir.msp430_irq_tasklet);
=20
-	del_timer_sync(&dev->timer);
-	ir_input_nokey(dev, &budget_ci->ir.state);
-
 	ir_input_unregister(dev);
 }
=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
