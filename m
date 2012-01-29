From: Marc Reilly <marc@cpdesign.com.au>
Subject: [PATCH 4/4] input: mc13xxx_ts: intersperse delays between ts samples
Date: Mon, 30 Jan 2012 09:51:04 +1100
Message-ID: <1327877464-23526-5-git-send-email-marc@cpdesign.com.au>
References: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36735 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2A2Wvr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Jan 2012 17:51:47 -0500
Received: by mail-pz0-f46.google.com with SMTP id i2so3053851dad.19
        for <linux-input@vger.kernel.org>; Sun, 29 Jan 2012 14:51:46 -0800 (PST)
In-Reply-To: <1327877464-23526-1-git-send-email-marc@cpdesign.com.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: s.hauer@pengutronuix.de, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de, Marc Reilly <marc@cpdesign.com.au>

The mc13xxx ICs have the ability to add a small delay in between each
sample taken in a set of TS samples. This allows time for the ts to be
biased correctly, and improved accuracy of raw readings.

Signed-off-by: Marc Reilly <marc@cpdesign.com.au>
---
 drivers/input/touchscreen/mc13xxx_ts.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/mc13xxx_ts.c b/drivers/input/touchscreen/mc13xxx_ts.c
index 8924d66..f46e49d 100644
--- a/drivers/input/touchscreen/mc13xxx_ts.c
+++ b/drivers/input/touchscreen/mc13xxx_ts.c
@@ -197,9 +197,13 @@ static void mc13xxx_ts_work(struct work_struct *work)
 		container_of(work, struct mc13xxx_ts_priv, work.work);
 	unsigned int mode = MC13XXX_ADC_MODE_TS;
 	unsigned int channel = 12;
+	u32 adc1_mask = MC13XXX_ADC1_ATOX | MC13XXX_ADC1_ATO_MASK;
+	u32 adc1_val = MC13XXX_ADC1_ATOX | (3 << MC13XXX_ADC1_ATO_SHIFT);
 
-	if (mc13xxx_adc_do_conversion(priv->mc13xxx,
-				mode, channel, priv->sample) == 0) {
+	if (mc13xxx_adc_do_conversion_ex(priv->mc13xxx,
+				mode, channel, priv->sample,
+				0, 0,
+				adc1_mask, adc1_val) == 0) {
 		mc13xxx_ts_report_sample(priv);
 	} else {
 		dev_warn(&priv->idev->dev, "bad conversion");
-- 
1.7.3.4

