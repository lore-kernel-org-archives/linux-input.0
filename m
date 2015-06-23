From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 07/11] Input: synaptics-rmi4 - f11: fix bitmap irq check
Date: Tue, 23 Jun 2015 15:17:26 -0400
Message-ID: <1435087050-11444-8-git-send-email-benjamin.tissoires@redhat.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933207AbbFWTRo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2015 15:17:44 -0400
In-Reply-To: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Allie Xiong <axiong@synaptics.com>
Cc: Stephen Chandler Paul <cpaul@redhat.com>, benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

num_irq_regs is the count of registers of 1 bytes that we use to check
the irqs. bitmap_and() expects the number of bits.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/rmi4/rmi_f11.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 99d6181..c3b757b 100644
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
2.4.3

