From: <michael.hennerich@analog.com>
Subject: [PATCH] input: touchscreen: ad7879: Fix deficient device disable
Date: Tue, 2 Aug 2011 14:46:45 +0200
Message-ID: <1312289205-9936-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:50641
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754424Ab1HBMru (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2011 08:47:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Input close or device disable should not interact with the exported gpiolib
functionality. However that's the case. __ad7879_disable() clears the
entire AD7879_REG_CTRL2, while it should just power down the ADC and
its reference.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7879.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index bc3b518..131f9d1 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -249,12 +249,14 @@ static void __ad7879_enable(struct ad7879 *ts)
 
 static void __ad7879_disable(struct ad7879 *ts)
 {
+	u16 reg = (ts->cmd_crtl2 & ~AD7879_PM(-1)) |
+		AD7879_PM(AD7879_PM_SHUTDOWN);
 	disable_irq(ts->irq);
 
 	if (del_timer_sync(&ts->timer))
 		ad7879_ts_event_release(ts);
 
-	ad7879_write(ts, AD7879_REG_CTRL2, AD7879_PM(AD7879_PM_SHUTDOWN));
+	ad7879_write(ts, AD7879_REG_CTRL2, reg);
 }
 
 
-- 
1.7.0.4


