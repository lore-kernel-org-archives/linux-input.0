From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 3/8] IR: fix duty cycle capability
Date: Tue,  7 Sep 2010 00:26:08 +0300
Message-ID: <1283808373-27876-4-git-send-email-maximlevitsky@gmail.com>
References: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1283808373-27876-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: lirc-list@lists.sourceforge.net
Cc: Jarod Wilson <jarod@wilsonet.com>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-input@vger.kernel.org

Due to typo lirc bridge enabled wrong capability.

Signed-off-by: Maxim Levitsky <maximlevitsky@gmail.com>
---
 drivers/media/IR/ir-lirc-codec.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/IR/ir-lirc-codec.c b/drivers/media/IR/ir-lirc-codec.c
index 77b5946..e63f757 100644
--- a/drivers/media/IR/ir-lirc-codec.c
+++ b/drivers/media/IR/ir-lirc-codec.c
@@ -267,7 +267,7 @@ static int ir_lirc_register(struct input_dev *input_dev)
 			features |= LIRC_CAN_SET_SEND_CARRIER;
 
 		if (ir_dev->props->s_tx_duty_cycle)
-			features |= LIRC_CAN_SET_REC_DUTY_CYCLE;
+			features |= LIRC_CAN_SET_SEND_DUTY_CYCLE;
 	}
 
 	if (ir_dev->props->s_rx_carrier_range)
-- 
1.7.0.4
