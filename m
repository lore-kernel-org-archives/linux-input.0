From: Marc Reilly <marc@cpdesign.com.au>
Subject: [PATCH 3/4] input: mc13xxx_ts: handle bad adc conversions
Date: Mon, 30 Jan 2012 09:51:03 +1100
Message-ID: <1327877464-23526-4-git-send-email-marc@cpdesign.com.au>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46564 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2A2Wvn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 17:51:43 -0500
Received: by mail-pw0-f46.google.com with SMTP id a10so3264234pba.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 14:51:43 -0800 (PST)
In-Reply-To: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: s.hauer@pengutronuix.de, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Marc Reilly <marc@cpdesign.com.au>

Before, if the adc conversion failed for some reason then no more
samples would be taken until the after the next pen up/down interrupt.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/input/touchscreen/mc13xxx_ts.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/mc13xxx_ts.c b/drivers/input/touchscreen/mc13xxx_ts.c
index 264b977..8924d66 100644
--- a/drivers/input/touchscreen/mc13xxx_ts.c
+++ b/drivers/input/touchscreen/mc13xxx_ts.c
@@ -199,8 +199,12 @@ static void mc13xxx_ts_work(struct work_struct *work)
 	unsigned int channel = 12;
 
 	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
-				mode, channel, priv->sample) == 0)
+				mode, channel, priv->sample) == 0) {
 		mc13xxx_ts_report_sample(priv);
+	} else {
+		dev_warn(&priv->idev->dev, "bad conversion");
+		queue_delayed_work(priv->workq, &priv->work, HZ / 50);
+	}
 }
 
 static int mc13xxx_ts_open(struct input_dev *dev)
-- 
1.7.3.4

