From: Jelle Martijn Kok <jmkok@youcom.nl>
Subject: [PATCH 1/3] rotary_encoder: increase/decrease on both rest states
Date: Wed, 12 May 2010 15:04:49 +0200
Message-ID: <4BEAA771.5010006@youcom.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lime.solrad.nl ([213.193.238.107]:49554 "EHLO lime.solrad.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075Ab0ELNJw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 May 2010 09:09:52 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Replaced the armed and dir states with a single last_state field. The 
rotary encoder does now increase on both "00" and "11".
It also fixes the "pumping" problem. If the rotary encoder is moved 
forward and backwards over a single pump, it will only increase or 
decrease in one direction.
An example for this "pumping" using gray codes
The encoder rotates one step: "11" => "10" => "00" (now it is increased)
The encoder rotates back: "00" => "10" => "11" (now it won't decrease)

Signed-off-by: Jelle Martijn Kok <jmkok@youcom.nl>
---
  drivers/input/misc/rotary_encoder.c |   77 
++++++++++++++++------------------
  1 files changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c 
b/drivers/input/misc/rotary_encoder.c
index 1f8e010..24621b8 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -36,8 +36,7 @@ struct rotary_encoder {
      unsigned int irq_a;
      unsigned int irq_b;

-    bool armed;
-    unsigned char dir;    /* 0 - clockwise, 1 - CCW */
+    int last_state;
  };

  static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
@@ -52,51 +51,47 @@ static irqreturn_t rotary_encoder_irq(int irq, void 
*dev_id)
      b ^= pdata->inverted_b;
      state = (a << 1) | b;

-    switch (state) {
-
-    case 0x0:
-        if (!encoder->armed)
-            break;
-
-        if (pdata->relative_axis) {
-            input_report_rel(encoder->input, pdata->axis,
-                     encoder->dir ? -1 : 1);
-        } else {
-            unsigned int pos = encoder->pos;
+    if (((state == 0x0) || (state == 0x3)) && ((encoder->last_state == 
0x01) || (encoder->last_state == 0x02)))  {
+        int state_exor = state ^ encoder->last_state;
+        int dir = 0;
+        if (state_exor == 0x01) {
+            dir = +1;
+        }
+        else {
+            dir = -1;
+        }

-            if (encoder->dir) {
-                /* turning counter-clockwise */
-                if (pdata->rollover)
-                    pos += pdata->steps;
-                if (pos)
-                    pos--;
+        if (dir) {
+            if (pdata->relative_axis) {
+                input_report_rel(encoder->input, pdata->axis,
+                         dir);
              } else {
-                /* turning clockwise */
-                if (pdata->rollover || pos < pdata->steps)
-                    pos++;
+                unsigned int pos = encoder->pos;
+
+                if (dir == -1) {
+                    /* turning counter-clockwise */
+                    if (pdata->rollover)
+                        pos += pdata->steps;
+                    if (pos)
+                        pos--;
+                } else {
+                    /* turning clockwise */
+                    if (pdata->rollover || pos < pdata->steps)
+                        pos++;
+                }
+                if (pdata->rollover)
+                    pos %= pdata->steps;
+                encoder->pos = pos;
+                input_report_abs(encoder->input, pdata->axis,
+                         encoder->pos);
              }
-            if (pdata->rollover)
-                pos %= pdata->steps;
-            encoder->pos = pos;
-            input_report_abs(encoder->input, pdata->axis,
-                     encoder->pos);
+            input_sync(encoder->input);
          }
-        input_sync(encoder->input);
-
-        encoder->armed = false;
-        break;
-
-    case 0x1:
-    case 0x2:
-        if (encoder->armed)
-            encoder->dir = state - 1;
-        break;
-
-    case 0x3:
-        encoder->armed = true;
-        break;
      }

+    /* always store the state - even on 00 or 11 */
+    encoder->last_state = state;
+
      return IRQ_HANDLED;
  }

-- 
1.7.0.4

