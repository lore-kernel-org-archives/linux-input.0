From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 09/26] Input: synaptics-rmi4 - f11: clean up rmi_f11_finger_handler
Date: Thu, 5 Nov 2015 15:39:22 -0800
Message-ID: <1446766762-30624-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:30193 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965349AbbKEXja (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Nov 2015 18:39:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

abs_bit and rel_bits should not be computed at each iteration of the for
loop.
finger_press_count is unused.
Break out rmi_f11_parse_finger_state in its own function.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index dbe2681..768c199 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -695,43 +695,36 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
 		input_mt_sync(input);
 }
 
+static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_finger)
+{
+	return (f_state[n_finger / 4] >> (2 * (n_finger % 4))) &
+							FINGER_STATE_MASK;
+}
+
 static void rmi_f11_finger_handler(struct f11_data *f11,
 				   struct f11_2d_sensor *sensor,
 				   unsigned long *irq_bits, int num_irq_regs)
 {
 	const u8 *f_state = sensor->data.f_state;
 	u8 finger_state;
-	u8 finger_pressed_count;
 	u8 i;
 
-	int rel_bits;
-	int abs_bits;
+	int abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
+				  num_irq_regs * 8);
+	int rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
+				  num_irq_regs * 8);
 
-	for (i = 0, finger_pressed_count = 0; i < sensor->nbr_fingers; i++) {
+	for (i = 0; i < sensor->nbr_fingers; i++) {
 		/* Possible of having 4 fingers per f_statet register */
-		finger_state = (f_state[i / 4] >> (2 * (i % 4))) &
-					FINGER_STATE_MASK;
-		switch (finger_state) {
-		case F11_RESERVED:
+		finger_state = rmi_f11_parse_finger_state(f_state, i);
+		if (finger_state == F11_RESERVED) {
 			pr_err("Invalid finger state[%d]: 0x%02x", i, finger_state);
 			continue;
-
-		case F11_PRESENT:
-		case F11_INACCURATE:
-			finger_pressed_count++;
-			break;
-
-		case F11_NO_FINGER:
-			break;
 		}
 
-		abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
-				      num_irq_regs * 8);
 		if (abs_bits)
 			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
 
-		rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
-				      num_irq_regs * 8);
 		if (rel_bits)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
-- 
2.1.4

