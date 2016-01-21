From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v5 4/4] Input: cyttsp - perform hard reset of the chip during probe
Date: Thu, 21 Jan 2016 23:21:32 +0100
Message-ID: <f5311f917c21caf5ba0cb8cca8220c43f46f0d0c.1453414661.git.oreste.salerno@tomtom.com>
References: <cover.1453414661.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.tomtom.com ([85.90.76.132]:7420 "EHLO mail3.tomtom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbcAUWVo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 17:21:44 -0500
In-Reply-To: <cover.1453414661.git.oreste.salerno@tomtom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com

Since we removed support for calling an init() callback from
the platform data, introduce a function which initializes
the chip by performing a hard reset, using the reset gpio
defined in the device properties.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 drivers/input/touchscreen/cyttsp_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index d91668d..0fd0956 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -240,6 +240,16 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
 	return retval;
 }
 
+static void cyttsp_hard_reset(struct cyttsp *ts)
+{
+	if (ts->reset_gpio) {
+		gpiod_set_value_cansleep(ts->reset_gpio, 1);
+		msleep(CY_DELAY_DFLT);
+		gpiod_set_value_cansleep(ts->reset_gpio, 0);
+		msleep(CY_DELAY_DFLT);
+	}
+}
+
 static int cyttsp_soft_reset(struct cyttsp *ts)
 {
 	unsigned long timeout;
@@ -663,6 +673,8 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	disable_irq(ts->irq);
 
+	cyttsp_hard_reset(ts);
+
 	error = cyttsp_power_on(ts);
 	if (error)
 		return ERR_PTR(error);
-- 
1.9.1

