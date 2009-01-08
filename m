From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] input/mfd/ucb1400: move static function from header to its user
Date: Thu, 8 Jan 2009 12:07:57 +0100
Message-ID: <20090108110757.GB24243@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:60101 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093AbZAHLIB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jan 2009 06:08:01 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org

it's a little too large for static line and just static is somehow ....

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
The only user I've seen is ts driver.

 drivers/input/touchscreen/ucb1400_ts.c |   19 +++++++++++++++++++
 include/linux/ucb1400.h                |   19 -------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 1647bc4..f2377a2 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -44,6 +44,25 @@ static inline void ucb1400_ts_mode_int(struct snd_ac97 *ac97)
 			UCB_TS_CR_MODE_INT);
 }
 
+static unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16 adc_channel,
+		int adcsync)
+{
+	unsigned int val;
+
+	if (adcsync)
+		adc_channel |= UCB_ADC_SYNC_ENA;
+
+	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel);
+	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel |
+			UCB_ADC_START);
+
+	while (!((val = ucb1400_reg_read(ac97, UCB_ADC_DATA))
+				& UCB_ADC_DAT_VALID))
+		schedule_timeout_uninterruptible(1);
+
+	return val & UCB_ADC_DAT_MASK;
+}
+
 /*
  * Switch to pressure mode, and read pressure.  We don't need to wait
  * here, since both plates are being driven.
diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
index 970473b..bf4f547 100644
--- a/include/linux/ucb1400.h
+++ b/include/linux/ucb1400.h
@@ -134,25 +134,6 @@ static inline void ucb1400_adc_enable(struct snd_ac97 *ac97)
 	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA);
 }
 
-static unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16 adc_channel,
-					int adcsync)
-{
-	unsigned int val;
-
-	if (adcsync)
-		adc_channel |= UCB_ADC_SYNC_ENA;
-
-	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel);
-	ucb1400_reg_write(ac97, UCB_ADC_CR, UCB_ADC_ENA | adc_channel |
-				UCB_ADC_START);
-
-	while (!((val = ucb1400_reg_read(ac97, UCB_ADC_DATA))
-			& UCB_ADC_DAT_VALID))
-		schedule_timeout_uninterruptible(1);
-
-	return val & UCB_ADC_DAT_MASK;
-}
-
 static inline void ucb1400_adc_disable(struct snd_ac97 *ac97)
 {
 	ucb1400_reg_write(ac97, UCB_ADC_CR, 0);
-- 
1.5.6.5

