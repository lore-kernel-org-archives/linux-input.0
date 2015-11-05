From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 07/26] Input: synaptics-rmi4 - f11: fix bitmap irq check
Date: Thu, 5 Nov 2015 15:38:33 -0800
Message-ID: <1446766713-30532-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

num_irq_regs is the count of registers of 1 bytes that we use to check
the irqs. bitmap_and() expects the number of bits.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 0028176..7fd808f 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -726,12 +726,12 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		}
 
 		abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
-				      num_irq_regs);
+				      num_irq_regs * 8);
 		if (abs_bits)
 			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
 
 		rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
-				      num_irq_regs);
+				      num_irq_regs * 8);
 		if (rel_bits)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
-- 
2.1.4
