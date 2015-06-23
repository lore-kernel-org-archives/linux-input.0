From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 09/11] Input: synaptics-rmi4 - f11: clean up rmi_f11_finger_handler
Date: Tue, 23 Jun 2015 15:17:28 -0400
Message-ID: <1435087050-11444-10-git-send-email-benjamin.tissoires@redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

abs_bit and rel_bits should not be computed at each iteration of the for
loop.
finger_press_count is unused.
Break out rmi_f11_parse_finger_state in its own function.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_f11.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 061530a..77a18aa 100644
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
2.4.3
