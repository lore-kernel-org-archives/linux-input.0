From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 3/5] Input: pm8xxx-vib: handle separate enable register
Date: Tue,  4 Apr 2017 11:41:51 -0400
Message-ID: <20170404154153.19901-3-damien.riegel@savoirfairelinux.com>
References: <20170404154153.19901-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:55442 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752202AbdDDPmw (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 11:42:52 -0400
In-Reply-To: <20170404154153.19901-1-damien.riegel@savoirfairelinux.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>

Some PMIC vibrator IPs use a separate enable register to turn the
vibrator on and off. To detect if a vibrator uses this feature, rely on
the enable_mask being non-zero.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
Changes in v2:
 - Removed reading register base address from device tree as it can
   already be infered from the compatible string.

 drivers/input/misc/pm8xxx-vibrator.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index b9b73957a48f..50b874e6f678 100644
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
-- 
2.12.1

