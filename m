From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v4 4/4] Input: cyttsp - perform hard reset of the chip during probe
Date: Thu, 21 Jan 2016 20:21:16 +0100
Message-ID: <016c9826d32dfdac5ef660cb755b0bcb9a173d59.1453403916.git.oreste.salerno@tomtom.com>
References: <cover.1453403916.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1453403916.git.oreste.salerno@tomtom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

Since we removed support for calling an init() callback from
the platform data, introduce a function which initializes
the chip by performing a hard reset, using the reset gpio
defined in the device properties.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 drivers/input/touchscreen/cyttsp_core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 92b459d..19499a6 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -240,6 +240,14 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
 	return retval;
 }
 
+static void cyttsp_hard_reset(struct cyttsp *ts)
+{
+	gpiod_set_value_cansleep(ts->reset_gpio, 1);
+	msleep(CY_DELAY_DFLT);
+	gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	msleep(CY_DELAY_DFLT);
+}
+
 static int cyttsp_soft_reset(struct cyttsp *ts)
 {
 	unsigned long timeout;
@@ -668,6 +676,8 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	disable_irq(ts->irq);
 
+	cyttsp_hard_reset(ts);
+
 	error = cyttsp_power_on(ts);
 	if (error)
 		return ERR_PTR(error);
-- 
1.9.1
