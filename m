From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [PATCH 3/8] IR: fix duty cycle capability
Date: Mon,  6 Sep 2010 01:22:39 +0300
Message-ID: <1283725364-4053-4-git-send-email-maximlevitsky@gmail.com>
References: <1283725364-4053-1-git-send-email-maximlevitsky@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34156 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921Ab0IEWWz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Sep 2010 18:22:55 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so2219369fxm.19
        for <linux-input@vger.kernel.org>; Sun, 05 Sep 2010 15:22:54 -0700 (PDT)
In-Reply-To: <1283725364-4053-1-git-send-email-maximlevitsky@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: lirc-list@lists.sourceforge.net
Cc: Jarod Wilson <jarod@wilsonet.com>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, mchehab@infradead.org, linux-input@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>

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

