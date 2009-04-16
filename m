From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] add REL_* axes support to the rotary encoder driver
Date: Wed, 15 Apr 2009 19:08:36 -0700
Message-ID: <20090416020836.GB2413@dtor-d630.eng.vmware.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <20090307170632.GA31096@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE1909015F87BC@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:47590 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbZDPCIp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2009 22:08:45 -0400
Received: by rv-out-0506.google.com with SMTP id b25so2826860rvf.5
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2009 19:08:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE1909015F87BC@mi8nycmail19.Mi8.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

Hi,

On Monday 13 April 2009 16:06:24 H Hartley Sweeten wrote:
> +
> +	unsigned int	axis;
> +	unsigned int	pos;
> +
> +	unsigned int	irq_a;
> +	unsigned int	irq_b;
> +
> +	unsigned int	abs:1;
> +	unsigned int	dir:1;
> +	unsigned int	armed:1;

Doing it this way makes us go from simple store to read/modify/write cycle in 
the interrupt handler.

>
> +#define ROTARY_ENCODER_REL	(0<<31)
> +#define ROTARY_ENCODER_ABS	(1<<31)

Meh... How about below instead?

-- 
Dmitry


Input: rotary_encoder - add support for REL_* axes

From: H Hartley Sweeten <hartleys@visionengravers.com>

The rotary encoder driver only supports returning input events
for ABS_* axes, this adds support for REL_* axes.  The relative
axis input event is reported as -1 for each counter-clockwise
step and +1 for each clockwise step.

In addition the private data structure has been rearranged and
modified to use less memory.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/input/rotary-encoder.txt |    7 ++++
 drivers/input/misc/rotary_encoder.c    |   52 ++++++++++++++++++++------------
 include/linux/rotary_encoder.h         |    3 ++
 3 files changed, 42 insertions(+), 20 deletions(-)


diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 435102a..9b6b6e3 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -67,7 +67,11 @@ data with it.
 struct rotary_encoder_platform_data is declared in
 include/linux/rotary-encoder.h and needs to be filled with the number of
 steps the encoder has and can carry information about externally inverted
-signals (because of used invertig buffer or other reasons).
+signals (because of an inverting buffer or other reasons). The encoder
+can be set up to deliver input information as either an absolute or relative
+axes. For absolute axes the position of the encoder rolls over between zero
+and the number of steps. For relative axes the input event returns +/-1 for
+each step.
 
 Because GPIO to IRQ mapping is platform specific, this information must
 be given in seperately to the driver. See the example below.
@@ -85,6 +89,7 @@ be given in seperately to the driver. See the example below.
 static struct rotary_encoder_platform_data my_rotary_encoder_info = {
 	.steps		= 24,
 	.axis		= ABS_X,
+	.relative_axis	= false,
 	.gpio_a		= GPIO_ROTARY_A,
 	.gpio_b		= GPIO_ROTARY_B,
 	.inverted_a	= 0,
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 5bb3ab5..5d81116 100644
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
@@ -53,21 +57,25 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
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
+			if (encoder->dir) {
+				/* turning counter-clockwise */
+				encoder->pos += pdata->steps;
+				encoder->pos--;
+			} else {
+				/* turning clockwise */
+				encoder->pos++;
+			}
 			encoder->pos %= pdata->steps;
+			input_report_abs(encoder->input, pdata->axis,
+					 encoder->pos);
 		}
-
-		input_report_abs(encoder->input, pdata->axis, encoder->pos);
 		input_sync(encoder->input);
 
-		encoder->armed = 0;
+		encoder->armed = false;
 		break;
 
 	case 0x1:
@@ -77,7 +85,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 		break;
 
 	case 0x3:
-		encoder->armed = 1;
+		encoder->armed = true;
 		break;
 	}
 
@@ -113,9 +121,15 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
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
+				     pdata->axis, 0, pdata->steps, 0, 1);
+	} else {
+		input->evbit[0] = BIT_MASK(EV_REL);
+		input->relbit[0] = BIT_MASK(pdata->axis);
+	}
 
 	err = input_register_device(input);
 	if (err) {
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index 12d63a3..a178bdc 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -1,6 +1,8 @@
 #ifndef __ROTARY_ENCODER_H__
 #define __ROTARY_ENCODER_H__
 
+#include <linux/types.h>
+
 struct rotary_encoder_platform_data {
 	unsigned int steps;
 	unsigned int axis;
@@ -8,6 +10,7 @@ struct rotary_encoder_platform_data {
 	unsigned int gpio_b;
 	unsigned int inverted_a;
 	unsigned int inverted_b;
+	bool relative_axis;
 };
 
 #endif /* __ROTARY_ENCODER_H__ */
