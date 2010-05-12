From: Jelle Martijn Kok <jmkok@youcom.nl>
Subject: [PATCH 2/3] rotary_encoder: added initial_value, min_value and max_value
Date: Wed, 12 May 2010 15:09:51 +0200
Message-ID: <4BEAA89F.10509@youcom.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lime.solrad.nl ([213.193.238.107]:49555 "EHLO lime.solrad.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194Ab0ELNJx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 09:09:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Added initial_value, min_value and max_value. This would replace "steps".
The steps parameter is still allowed as it will be copied in the 
max_value for backwards compatibility.
The max_value parameter is one higher than the steps parameter, and will 
better match the "input_set_abs_params" function.

Signed-off-by: Jelle Martijn Kok <jmkok@youcom.nl>
---
  drivers/input/misc/rotary_encoder.c |   21 +++++++++++++--------
  include/linux/rotary_encoder.h      |    5 ++++-
  2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c 
b/drivers/input/misc/rotary_encoder.c
index 24621b8..1c9728f 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -70,17 +70,18 @@ static irqreturn_t rotary_encoder_irq(int irq, void 
*dev_id)

                  if (dir == -1) {
                      /* turning counter-clockwise */
-                    if (pdata->rollover)
-                        pos += pdata->steps;
-                    if (pos)
+                    if (pos > pdata->min_value)
                          pos--;
-                } else {
+                    else if (pdata->rollover)
+                        pos = pdata->max_value;
+                }
+                else {
                      /* turning clockwise */
-                    if (pdata->rollover || pos < pdata->steps)
+                    if (pos < pdata->max_value)
                          pos++;
+                    else if (pdata->rollover)
+                        pos = pdata->min_value;
                  }
-                if (pdata->rollover)
-                    pos %= pdata->steps;
                  encoder->pos = pos;
                  input_report_abs(encoder->input, pdata->axis,
                           encoder->pos);
@@ -119,6 +120,10 @@ static int __devinit rotary_encoder_probe(struct 
platform_device *pdev)
      encoder->pdata = pdata;
      encoder->irq_a = gpio_to_irq(pdata->gpio_a);
      encoder->irq_b = gpio_to_irq(pdata->gpio_b);
+    encoder->pos = pdata->initial_value;
+    /* ensure backwards compatibility with the steps parameter */
+    if (!pdata->max_value)
+        pdata->max_value = pdata->steps-1;

      /* create and register the input driver */
      input->name = pdev->name;
@@ -131,7 +136,7 @@ static int __devinit rotary_encoder_probe(struct 
platform_device *pdev)
      } else {
          input->evbit[0] = BIT_MASK(EV_ABS);
          input_set_abs_params(encoder->input,
-                     pdata->axis, 0, pdata->steps, 0, 1);
+                     pdata->axis, pdata->min_value, pdata->max_value, 
0, 1);
      }

      err = input_register_device(input);
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index 215278b..a0d15d9 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -2,7 +2,10 @@
  #define __ROTARY_ENCODER_H__

  struct rotary_encoder_platform_data {
-    unsigned int steps;
+    unsigned int steps;    /* deprecated, use max_value instead */
+    unsigned int initial_value;
+    unsigned int min_value;
+    unsigned int max_value;
      unsigned int axis;
      unsigned int gpio_a;
      unsigned int gpio_b;
-- 
1.7.0.4

