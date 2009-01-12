From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] input/mfd/ucb1400: move static function from header into core
Date: Mon, 12 Jan 2009 10:31:30 +0100
Message-ID: <20090112093130.GA15721@www.tglx.de>
References: <20090108110757.GB24243@www.tglx.de> <200901081323.55398.marek.vasut@gmail.com> <4965F2A9.3060208@linutronix.de> <20090111234716.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:44044 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750984AbZALJbp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 04:31:45 -0500
Content-Disposition: inline
In-Reply-To: <20090111234716.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org

it's a little too large for static line.
The ts is currently the only mainline user but Marek Vasut claims that
there is a battery driver in an ARM tree which also needs this function.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ucb1400_core.c |   20 ++++++++++++++++++++
 include/linux/ucb1400.h    |   20 ++------------------
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/mfd/ucb1400_core.c b/drivers/mfd/ucb1400_core.c
index 88f33c1..3a89e7f 100644
--- a/drivers/mfd/ucb1400_core.c
+++ b/drivers/mfd/ucb1400_core.c
@@ -23,6 +23,26 @@
 #include <linux/module.h>
 #include <linux/ucb1400.h>
 
+unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16 adc_channel,
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
+EXPORT_SYMBOL_GPL(ucb1400_adc_read);
+
 static int ucb1400_core_probe(struct device *dev)
 {
 	int err;
diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
index 970473b..1b0840d 100644
--- a/include/linux/ucb1400.h
+++ b/include/linux/ucb1400.h
@@ -134,24 +134,8 @@ static inline void ucb1400_adc_enable(struct snd_ac97 *ac97)
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
+unsigned int ucb1400_adc_read(struct snd_ac97 *ac97, u16 adc_channel,
+		int adcsync);
 
 static inline void ucb1400_adc_disable(struct snd_ac97 *ac97)
 {
-- 
1.5.6.5

