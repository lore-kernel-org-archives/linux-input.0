From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 4/6] Input: pm8xxx-vib: handle separate enable register
Date: Fri, 31 Mar 2017 12:15:36 -0400
Message-ID: <20170331161538.11657-4-damien.riegel@savoirfairelinux.com>
References: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:36838 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbdCaQQk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Mar 2017 12:16:40 -0400
In-Reply-To: <20170331161538.11657-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Some PMIC vibrator IPs use a separate enable register to turn the
vibrator on and off. To detect if a vibrator uses this feature, rely on
the enable_mask being non-zero.

If they use it, the device tree is queried to retrieve the base address
of the control and enable registers.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index f1daae08a8c2..803bc75d5531 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -26,6 +27,9 @@
 #define MAX_FF_SPEED		0xff
 
 struct pm8xxx_regs {
+	unsigned int enable_addr;
+	unsigned int enable_mask;
+
 	unsigned int drv_addr;
 	unsigned int drv_mask;
 	unsigned int drv_shift;
@@ -82,7 +86,14 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 		return rc;
 
 	vib->reg_vib_drv = val;
-	return 0;
+
+	if (regs->enable_mask) {
+		unsigned int val = on ? regs->enable_mask : 0;
+		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
+					regs->enable_mask, val);
+	}
+
+	return rc;
 }
 
 /**
@@ -179,6 +190,22 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 
 	regs = (struct pm8xxx_regs *)of_device_get_match_data(&pdev->dev);
 
+	/*
+	 * If enable_mask is not zero, that means we're using a vibrator that
+	 * requires multiple registers to be controlled, the value read in the
+	 * device tree is the base address of these registers.
+	 */
+	if (regs->enable_mask) {
+		u32 base;
+
+		error = of_property_read_u32(pdev->dev.of_node, "reg", &base);
+		if (error)
+			return error;
+
+		regs->drv_addr += base;
+		regs->enable_addr += base;
+	}
+
 	/* operate in manual mode */
 	error = regmap_read(vib->regmap, regs->drv_addr, &val);
 	if (error < 0)
-- 
2.12.0

