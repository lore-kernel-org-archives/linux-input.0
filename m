From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 1/5] mfd: sunxi-gpadc-mfd: add TP_UP_PENDING irq
Date: Wed, 20 Jul 2016 10:29:07 +0200
Message-ID: <1469003351-15263-2-git-send-email-quentin.schulz@free-electrons.com>
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41182 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753033AbcGTI3y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 04:29:54 -0400
In-Reply-To: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, antoine.tenart@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

This adds support for TP_UP_PENDING irq in Allwinner SoCs' GPADC's MFD.

This interrupt occurs when a touchscreen is attached and the thing (stylus,
finger) currently touching the touchscreen releases the touch.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/mfd/sunxi-gpadc-mfd.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/sunxi-gpadc-mfd.c b/drivers/mfd/sunxi-gpadc-mfd.c
index f0005a6..05a000b 100644
--- a/drivers/mfd/sunxi-gpadc-mfd.c
+++ b/drivers/mfd/sunxi-gpadc-mfd.c
@@ -19,6 +19,8 @@
 
 #define SUNXI_IRQ_FIFO_DATA	0
 #define SUNXI_IRQ_TEMP_DATA	1
+#define SUNXI_IRQ_TP_UP		2
+
 
 static struct resource adc_resources[] = {
 	{
@@ -34,9 +36,19 @@ static struct resource adc_resources[] = {
 	},
 };
 
+static struct resource ts_resources[] = {
+	{
+		.name	= "TP_UP_PENDING",
+		.start	= SUNXI_IRQ_TP_UP,
+		.end	= SUNXI_IRQ_TP_UP,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static const struct regmap_irq sunxi_gpadc_mfd_regmap_irq[] = {
 	REGMAP_IRQ_REG(SUNXI_IRQ_FIFO_DATA, 0, BIT(16)),
 	REGMAP_IRQ_REG(SUNXI_IRQ_TEMP_DATA, 0, BIT(18)),
+	REGMAP_IRQ_REG(SUNXI_IRQ_TP_UP, 0, BIT(1)),
 };
 
 static const struct regmap_irq_chip sunxi_gpadc_mfd_regmap_irq_chip = {
-- 
2.5.0

