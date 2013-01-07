From: Marek Vasut <marex@denx.de>
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based probe
Date: Mon,  7 Jan 2013 15:29:49 +0100
Message-ID: <1357568989-16237-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39709 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab3AGO34 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 09:29:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-input@vger.kernel.org, Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>

In case of a DT-based probe of the stmpe MFD driver, the irq_gpio was zero,
which resulted in the driver failing to probe.

Implement DT properties "irq-over-gpio" and "irq-gpios" which are already used
in "arch/arm/boot/dts/spear320-hmi.dts" to circumvent these problems. The new
behaviour is the expected one and copies the behavior of platform_data-based
probe.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/mfd/stmpe.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/stmpe.c b/drivers/mfd/stmpe.c
index 4b11202..fb9cd6f 100644
--- a/drivers/mfd/stmpe.c
+++ b/drivers/mfd/stmpe.c
@@ -1018,6 +1018,11 @@ void stmpe_of_probe(struct stmpe_platform_data *pdata, struct device_node *np)
 	pdata->id = -1;
 	pdata->irq_trigger = IRQF_TRIGGER_NONE;
 
+	pdata->irq_over_gpio = of_get_property(np, "irq-over-gpio", NULL);
+	pdata->irq_gpio = of_get_named_gpio(np, "irq-gpios", 0);
+	if (!gpio_is_valid(pdata->irq_gpio))
+		pdata->irq_gpio = -1;
+
 	of_property_read_u32(np, "st,autosleep-timeout",
 			&pdata->autosleep_timeout);
 
-- 
1.7.10.4

