From: Jelle Martijn Kok <jmkok@youcom.nl>
Subject: [PATCH 3/3] rotary_encoder: added key events to increase and decrease
Date: Wed, 12 May 2010 15:12:34 +0200
Message-ID: <4BEAA942.1010108@youcom.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lime.solrad.nl ([213.193.238.107]:49560 "EHLO lime.solrad.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751565Ab0ELNMf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 09:12:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

You may now set key events for the increase and decrease events.
For example you could set this to "KEY_VOLUMEUP" and "KEY_VOLUMEDOWN" 
for a volume encoder.

Signed-off-by: Jelle Martijn Kok <jmkok@youcom.nl>
---
  drivers/input/misc/rotary_encoder.c |   19 +++++++++++++++++--
  include/linux/rotary_encoder.h      |    2 ++
  2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c 
b/drivers/input/misc/rotary_encoder.c
index 1c9728f..9ada6fd 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -56,9 +56,17 @@ static irqreturn_t rotary_encoder_irq(int irq, void 
*dev_id)
          int dir = 0;
          if (state_exor == 0x01) {
              dir = +1;
+            if (pdata->event_up) {
+                input_report_key(encoder->input, pdata->event_up, 1);
+                input_report_key(encoder->input, pdata->event_up, 0);
+            }
          }
          else {
              dir = -1;
+            if (pdata->event_down) {
+                input_report_key(encoder->input, pdata->event_down, 1);
+                input_report_key(encoder->input, pdata->event_down, 0);
+            }
          }

          if (dir) {
@@ -130,11 +138,18 @@ static int __devinit rotary_encoder_probe(struct 
platform_device *pdev)
      input->id.bustype = BUS_HOST;
      input->dev.parent = &pdev->dev;

+    if (pdata->event_up || pdata->event_down) {
+        input->evbit[0] |= BIT(EV_KEY);
+        __set_bit(pdata->event_up, input->keybit);
+        __set_bit(pdata->event_down, input->keybit);
+        input_set_capability(input, EV_MSC, MSC_SCAN);
+    }
+
      if (pdata->relative_axis) {
-        input->evbit[0] = BIT_MASK(EV_REL);
+        input->evbit[0] |= BIT_MASK(EV_REL);
          input->relbit[0] = BIT_MASK(pdata->axis);
      } else {
-        input->evbit[0] = BIT_MASK(EV_ABS);
+        input->evbit[0] |= BIT_MASK(EV_ABS);
          input_set_abs_params(encoder->input,
                       pdata->axis, pdata->min_value, pdata->max_value, 
0, 1);
      }
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index a0d15d9..2350a48 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -7,6 +7,8 @@ struct rotary_encoder_platform_data {
      unsigned int min_value;
      unsigned int max_value;
      unsigned int axis;
+    unsigned int event_up;
+    unsigned int event_down;
      unsigned int gpio_a;
      unsigned int gpio_b;
      unsigned int inverted_a;
-- 
1.7.0.4

