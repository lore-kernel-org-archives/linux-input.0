From: <michael.hennerich@analog.com>
Subject: [PATCH] Input: ad714x - restore struct ad714x_chip status interrupt result placement
Date: Mon, 22 Aug 2011 13:44:15 +0200
Message-ID: <1314013455-13463-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:58246
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751305Ab1HVLoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Aug 2011 07:44:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

This patch needs to go on top of Dmitry's reworked patch set.
Since we read status interrupt registers in row, we also need to place the
storage members sequentially. This part got dropped from the original patch set.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/ad714x.h b/drivers/input/misc/ad714x.h
index 6edc080..3c85455 100644
--- a/drivers/input/misc/ad714x.h
+++ b/drivers/input/misc/ad714x.h
@@ -22,8 +22,8 @@ typedef int (*ad714x_read_t)(struct ad714x_chip *, unsigned short, unsigned shor
 typedef int (*ad714x_write_t)(struct ad714x_chip *, unsigned short, unsigned short);
 
 struct ad714x_chip {
-	unsigned short h_state;
 	unsigned short l_state;
+	unsigned short h_state;
 	unsigned short c_state;
 	unsigned short adc_reg[STAGE_NUM];
 	unsigned short amb_reg[STAGE_NUM];
-- 
1.7.0.4


