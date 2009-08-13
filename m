From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [PATCH] Add EV_IR bit
Date: Thu, 13 Aug 2009 22:21:21 +0200
Message-ID: <20090813202121.GA15773@hardeman.nu>
References: <20090812223327.GA6827@hardeman.nu>
 <20090813072023.7BCC9526EC9@mailhub.coreip.homeip.net>
 <b8f9be4c2061560d4abe638f0ce91949.squirrel@www.hardeman.nu>
 <20090813162830.674A4526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:60906 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755758AbZHMUVY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Aug 2009 16:21:24 -0400
Content-Disposition: inline
In-Reply-To: <20090813162830.674A4526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Aug 13, 2009 at 08:57:45AM -0700, Dmitry Torokhov wrote:
>On Thu, Aug 13, 2009 at 10:32:16AM +0200, David H=E4rdeman wrote:
>> On Thu, August 13, 2009 08:49, Dmitry Torokhov wrote:
>>> Do you expect devices to actually _send_ EV_IR events?
>>
>> Yes, and I have some patches going in that direction (loosely based =
on Jon
>> Smirl's in-kernel IR driver patchset).
=2E..
>
>Would you mind posting the complete patchset?

Here's an example of what I've been considering, it should hopefully=20
convey the general idea. (Not actually a tested patch yet).


Index: linux-2.6/drivers/input/input.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/input/input.c	2009-08-13 18:18:28.000000000 =
+0200
+++ linux-2.6/drivers/input/input.c	2009-08-13 21:43:29.000000000 +0200
@@ -274,6 +274,10 @@
  	case EV_PWR:
  		disposition =3D INPUT_PASS_TO_ALL;
  		break;
+
+	case EV_IR:
+		disposition =3D INPUT_PASS_TO_ALL;
+		break;
  	}
 =20
  	if (disposition !=3D INPUT_IGNORE_EVENT && type !=3D EV_SYN)
@@ -1375,6 +1379,10 @@
  		/* do nothing */
  		break;
 =20
+	case EV_IR:
+		/* do nothing */
+		break;
+
  	default:
  		printk(KERN_ERR
  			"input_set_capability: unknown type %u (code %u)\n",
Index: linux-2.6/include/linux/input.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/include/linux/input.h	2009-08-13 18:18:28.000000000 =
+0200
+++ linux-2.6/include/linux/input.h	2009-08-13 21:48:49.000000000 +0200
@@ -98,6 +98,7 @@
  #define EV_FF			0x15
  #define EV_PWR			0x16
  #define EV_FF_STATUS		0x17
+#define EV_IR			0x18
  #define EV_MAX			0x1f
  #define EV_CNT			(EV_MAX+1)
 =20
@@ -985,6 +986,32 @@
  #define FF_MAX		0x7f
  #define FF_CNT		(FF_MAX+1)
 =20
+/*
+ * IR events
+ */
+#define IR_RAW		0x00
+#define IR_PROTOCOL	0x01
+#define IR_TOGGLE	0x02
+#define IR_COMMAND	0x03
+#define IR_DEVICE	0x04
+#define IR_SUBDEVICE	0x05
+#define IR_CUSTOMER	0x06
+
+/*
+ * IR Protocol values
+ */
+#define IR_PROTOCOL_RC5		0x00
+#define IR_PROTOCOL_RC5X	0x01
+#define IR_PROTOCOL_RC6_0	0x02
+#define IR_PROTOCOL_RC6_6A	0x03
+#define IR_PROTOCOL_SONY_12	0x04
+#define IR_PROTOCOL_SONY_15	0x05
+#define IR_PROTOCOL_SONY_20	0x06
+#define IR_PROTOCOL_NEC		0x07 /* NEC1, NEC2, NEC1X, NEC2X */
+#define IR_PROTOCOL_NEC_REP	0x08
+
+/* The value of TOGGLE, COMMAND, etc, is protocol-specific */
+
  #ifdef __KERNEL__
 =20
  /*
@@ -1323,6 +1350,11 @@
  	input_event(dev, EV_FF_STATUS, code, value);
  }
 =20
+static inline void input_report_ir(struct input_dev *dev, unsigned int=
 code, int value)
+{
+	input_event(dev, EV_IR, code, value);
+}
+
  static inline void input_report_switch(struct input_dev *dev, unsigne=
d int code, int value)
  {
  	input_event(dev, EV_SW, code, !!value);
Index: linux-2.6/include/linux/input-ir.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/linux/input-ir.h	2009-08-13 22:06:17.000000000 +0=
200
@@ -0,0 +1,104 @@
+#ifndef _INPUT_IR_H
+#define _INPUT_IR_H
+
+#include <linux/input.h>
+
+static inline void input_report_ir_raw(struct input_dev *dev, int valu=
e)
+{
+	input_report_ir(dev, IR_RAW, value);
+}
+
+static inline void input_report_ir_rc5(struct input_dev *dev,
+				       unsigned int device,
+				       unsigned int command,
+				       unsigned int toggle)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_RC5);
+	input_report_ir(dev, IR_DEVICE, device & 0x1F);
+	input_report_ir(dev, IR_COMMAND, command & 0x7F);
+	input_report_ir(dev, IR_TOGGLE, !!toggle);
+}
+
+static inline void input_report_ir_rc5x(struct input_dev *dev,
+					unsigned int device,
+					unsigned int subdevice,
+					unsigned int command,
+					unsigned int toggle)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_RC5X);
+	input_report_ir(dev, IR_DEVICE, device & 0x1F);
+	input_report_ir(dev, IR_SUBDEVICE, device & 0x7F);
+	input_report_ir(dev, IR_COMMAND, command & 0x3F);
+	input_report_ir(dev, IR_TOGGLE, !!toggle);
+}
+
+static inline void input_report_ir_rc6_0(struct input_dev *dev,
+					 unsigned int device,
+					 unsigned int command,
+					 unsigned int toggle)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_RC6_0);
+	input_report_ir(dev, IR_DEVICE, device & 0xFF);
+	input_report_ir(dev, IR_COMMAND, command & 0xFF);
+	input_report_ir(dev, IR_TOGGLE, !!toggle);
+}
+
+static inline void input_report_ir_rc6_6a(struct input_dev *dev,
+					  unsigned int customer,
+					  unsigned int device,
+					  unsigned int command,
+					  unsigned int toggle)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_RC6_0);
+	input_report_ir(dev, IR_CUSTOMER, customer & 0xFFFF);
+	input_report_ir(dev, IR_DEVICE, device & 0x7F);
+	input_report_ir(dev, IR_COMMAND, command & 0xFF);
+	input_report_ir(dev, IR_TOGGLE, !!toggle);
+}
+
+static inline void input_report_ir_sony_12(struct input_dev *dev,
+					   unsigned int device,
+					   unsigned int command)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_SONY_12);
+	input_report_ir(dev, IR_DEVICE, device & 0x1F);
+	input_report_ir(dev, IR_COMMAND, command & 0x7F);
+}
+
+static inline void input_report_ir_sony_15(struct input_dev *dev,
+					   unsigned int device,
+					   unsigned int command)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_SONY_15);
+	input_report_ir(dev, IR_DEVICE, device & 0xFF);
+	input_report_ir(dev, IR_COMMAND, command & 0x7F);
+}
+
+static inline void input_report_ir_sony_20(struct input_dev *dev,
+					   unsigned int device,
+					   unsigned int subdevice,
+					   unsigned int command)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_SONY_20);
+	input_report_ir(dev, IR_DEVICE, device & 0x1F);
+	input_report_ir(dev, IR_SUBDEVICE, subdevice & 0xFF);
+	input_report_ir(dev, IR_COMMAND, command & 0x7F);
+}
+
+static inline void input_report_ir_nec(struct input_dev *dev,
+					   unsigned int device,
+					   unsigned int subdevice,
+					   unsigned int command)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_NEC);
+	input_report_ir(dev, IR_DEVICE, device & 0xFF);
+	input_report_ir(dev, IR_SUBDEVICE, subdevice & 0xFF);
+	input_report_ir(dev, IR_COMMAND, command & 0xFF);
+}
+
+static inline void input_report_ir_nec_rep(struct input_dev *dev)
+{
+	input_report_ir(dev, IR_PROTOCOL, IR_PROTOCOL_NEC_REP);
+}
+
+#endif /* _INPUT_IR_H */
Index: linux-2.6/drivers/media/dvb/ttpci/budget-ci.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/drivers/media/dvb/ttpci/budget-ci.c	2009-08-13 22:11=
:11.000000000 +0200
+++ linux-2.6/drivers/media/dvb/ttpci/budget-ci.c	2009-08-13 22:15:52.0=
00000000 +0200
@@ -34,6 +34,7 @@
  #include <linux/slab.h>
  #include <linux/interrupt.h>
  #include <linux/input.h>
+#include <linux/input-ir.h>
  #include <linux/spinlock.h>
  #include <media/ir-common.h>
 =20
@@ -173,6 +174,12 @@
  	    budget_ci->ir.rc5_device !=3D (command & 0x1f))
  		return;
 =20
+	/* Report the raw RC5 event to userspace */
+	input_report_ir_rc5(budget_ci->dev,
+			    command & 0x1f,
+			    budget_ci->ir.ir_key,
+			    command & 0x20 ? 1 : 0);
+
  	/* Is this a repeated key sequence? (same device, command, toggle) *=
/
  	raw =3D budget_ci->ir.ir_key | (command << 8);
  	if (budget_ci->ir.last_raw !=3D raw || !timer_pending(&budget_ci->ir=
=2Etimer_keyup)) {
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
