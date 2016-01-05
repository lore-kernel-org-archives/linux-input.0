From: Oreste Salerno <oreste.salerno@tomtom.com>
Subject: [PATCH v2 3/3] Input: cyttsp - add default init function
Date: Tue, 5 Jan 2016 13:59:15 +0100
Message-ID: <bfd64d1a8478adb89c84c9d718505e82ad6e7a1f.1451997697.git.oreste.salerno@tomtom.com>
References: <cover.1451997697.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451997697.git.oreste.salerno@tomtom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, fery@cypress.com, dmitry.torokhov@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, oreste.salerno@tomtom.com
List-Id: linux-input@vger.kernel.org

When using device trees, it's not possible to assign an init()
function in the platform data.
In case the init function has not been assigned, attempt to
perform a hard reset of the chip, using reset gpio defined in the
platform data / device tree.

Signed-off-by: Oreste Salerno <oreste.salerno@tomtom.com>
---
 drivers/input/touchscreen/cyttsp_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 8390236..9872333 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -238,6 +238,16 @@ static int cyttsp_set_sysinfo_regs(struct cyttsp *ts)
 	return retval;
 }
 
+static void cyttsp_hard_reset(struct cyttsp *ts)
+{
+	if (ts->pdata->reset_gpio) {
+		gpiod_set_value_cansleep(ts->pdata->reset_gpio, 1);
+		msleep(CY_DELAY_DFLT);
+		gpiod_set_value_cansleep(ts->pdata->reset_gpio, 0);
+		msleep(CY_DELAY_DFLT);
+	}
+}
+
 static int cyttsp_soft_reset(struct cyttsp *ts)
 {
 	unsigned long timeout;
@@ -659,6 +669,8 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 				error);
 			goto err_free_mem;
 		}
+	} else {
+		cyttsp_hard_reset(ts);
 	}
 
 	input_dev->name = pdata->name;
-- 
1.9.1
