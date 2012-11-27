From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] mfd: arizona: Allow the CODEC DAPM context to be accessed elsewhere
Date: Tue, 27 Nov 2012 07:08:05 +0000
Message-ID: <1354000088-30517-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56264 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755779Ab2K0HIT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 02:08:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Some other device functions need to integrate with signal sources in the
audio portion (primarily for haptics) so allow CODEC to export the DAPM
context by pointing to it from the core driver.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/linux/mfd/arizona/core.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mfd/arizona/core.h b/include/linux/mfd/arizona/core.h
index dd231ac..a580363 100644
--- a/include/linux/mfd/arizona/core.h
+++ b/include/linux/mfd/arizona/core.h
@@ -78,6 +78,8 @@ enum arizona_type {
 
 #define ARIZONA_NUM_IRQ                   50
 
+struct snd_soc_dapm_context;
+
 struct arizona {
 	struct regmap *regmap;
 	struct device *dev;
@@ -98,6 +100,8 @@ struct arizona {
 
 	struct mutex clk_lock;
 	int clk32k_ref;
+
+	struct snd_soc_dapm_context *dapm;
 };
 
 int arizona_clk32k_enable(struct arizona *arizona);
-- 
1.7.10.4

