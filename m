From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] add REL_* axes support to the rotary encoder driver
Date: Wed, 15 Apr 2009 23:11:41 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909015F8DFF@mi8nycmail19.Mi8.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <20090416020836.GB2413@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE1909015F8DFD@mi8nycmail19.Mi8.com> <200904151933.06721.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og112.obsmtp.com ([64.18.1.29]:54882 "HELO
	exprod6og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751212AbZDPDLp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 23:11:45 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200904151933.06721.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Wednesday, April 15, 2009 7:33 PM, Dmitry Torokhov wrote:
>>> Meh... How about below instead?
>>
>> Your changes look good to me.
>>
>> The only issue I can see is that absolute axis encoders wrap.
>>
>> If you have an encoder of something like ABS_VOLUME you would
>> probably want the "pos" to go from 0 to "steps" and then clamp.
>> The encoder could actually rotate multiple times depending on
>> it's actual line count, but the effect would be correct.
>
> I see. Care to prepare a patch? Thanks!

Dmitry,

How's this?  I left the ability for the original ABS_* axis
operation since that might be what Daniel Mack needed.

Regards,
Hartley


Input: rotary_encoder - add support for REL_* axes

From: H Hartley Sweeten <hartleys@visionengravers.com>

The rotary encoder driver only supports returning input events
for ABS_* axes, this adds support for REL_* axes.  The relative
axis input event is reported as -1 for each counter-clockwise
step and +1 for each clockwise step.

The ability to clamp the position of ABS_* axes between 0 and
a maximum of "steps" has also been added.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

diff --git a/Documentation/input/rotary-encoder.txt
b/Documentation/input/rotary-encoder.txt
index 435102a..3a6aec4 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -67,7 +67,12 @@ data with it.
 struct rotary_encoder_platform_data is declared in
 include/linux/rotary-encoder.h and needs to be filled with the number
of
 steps the encoder has and can carry information about externally
inverted
-signals (because of used invertig buffer or other reasons).
+signals (because of an inverting buffer or other reasons). The encoder
+can be set up to deliver input information as either an absolute or
relative
+axes. For relative axes the input event returns +/-1 for each step. For
+absolute axes the position of the encoder can either roll over between
zero
+and the number of steps or will clamp at the maximum and zero depending
on
+the configuration.
 
 Because GPIO to IRQ mapping is platform specific, this information must
 be given in seperately to the driver. See the example below.
@@ -85,6 +90,8 @@ be given in seperately to the driver. See the example
below.
 static struct rotary_encoder_platform_data my_rotary_encoder_info = {
 	.steps		= 24,
 	.axis		= ABS_X,
+	.relative_axis	= false,
+	.rollover	= false,
 	.gpio_a		= GPIO_ROTARY_A,
 	.gpio_b		= GPIO_ROTARY_B,
 	.inverted_a	= 0,
diff --git a/drivers/input/misc/rotary_encoder.c
b/drivers/input/misc/rotary_encoder.c
index 5bb3ab5..4a6a72a 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -26,13 +26,17 @@
 #define DRV_NAME "rotary-encoder"
 
 struct rotary_encoder {
-	unsigned int irq_a;
-	unsigned int irq_b;
-	unsigned int pos;
-	unsigned int armed;
-	unsigned int dir;
 	struct input_dev *input;
 	struct rotary_encoder_platform_data *pdata;
+
+	unsigned int axis;
+	unsigned int pos;
+
+	unsigned int irq_a;
+	unsigned int irq_b;
+
+	bool armed;
+	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
 };
 
 static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
@@ -53,21 +57,32 @@ static irqreturn_t rotary_encoder_irq(int irq, void
*dev_id)
 		if (!encoder->armed)
 			break;
 
-		if (encoder->dir) {
-			/* turning counter-clockwise */
-			encoder->pos += pdata->steps;
-			encoder->pos--;
-			encoder->pos %= pdata->steps;
+		if (pdata->relative_axis) {
+			input_report_rel(encoder->input, pdata->axis,
+					 encoder->dir ? -1 : 1);
 		} else {
-			/* turning clockwise */
-			encoder->pos++;
-			encoder->pos %= pdata->steps;
+			unsigned int pos = encoder->pos;
+
+			if (encoder->dir) {
+				/* turning counter-clockwise */
+				if (encoder->rollover)
+					pos += pdata->steps;
+				if (pos)
+					pos--;
+			} else {
+				/* turning clockwise */
+				if (encoder->rollover || pos <
pdata->steps)
+					pos++;
+			}
+			if (encoder->rollover)
+				pos %= pdata->steps;
+			encoder->pos = pos;
+			input_report_abs(encoder->input, pdata->axis,
+					 encoder->pos);
 		}
-
-		input_report_abs(encoder->input, pdata->axis,
encoder->pos);
 		input_sync(encoder->input);
 
-		encoder->armed = 0;
+		encoder->armed = false;
 		break;
 
 	case 0x1:
@@ -77,7 +92,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void
*dev_id)
 		break;
 
 	case 0x3:
-		encoder->armed = 1;
+		encoder->armed = true;
 		break;
 	}
 
@@ -113,9 +128,15 @@ static int __devinit rotary_encoder_probe(struct
platform_device *pdev)
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = &pdev->dev;
-	input->evbit[0] = BIT_MASK(EV_ABS);
-	input_set_abs_params(encoder->input,
-			     pdata->axis, 0, pdata->steps, 0, 1);
+
+	if (pdata->relative_axis) {
+		input->evbit[0] = BIT_MASK(EV_ABS);
+		input_set_abs_params(encoder->input,
+				     pdata->axis, 0, pdata->steps, 0,
1);
+	} else {
+		input->evbit[0] = BIT_MASK(EV_REL);
+		input->relbit[0] = BIT_MASK(pdata->axis);
+	}
 
 	err = input_register_device(input);
 	if (err) {
diff --git a/include/linux/rotary_encoder.h
b/include/linux/rotary_encoder.h
index 12d63a3..215278b 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -8,6 +8,8 @@ struct rotary_encoder_platform_data {
 	unsigned int gpio_b;
 	unsigned int inverted_a;
 	unsigned int inverted_b;
+	bool relative_axis;
+	bool rollover;
 };
 
 #endif /* __ROTARY_ENCODER_H__ */ 
