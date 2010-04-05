From: Todd Fischer <todd.fischer@ridgerun.com>
Subject: [PATCH 2/2] TPS6507x touch screen driver board specific initialization values.
Date: Mon,  5 Apr 2010 17:53:13 -0600
Message-ID: <1270511593-4785-3-git-send-email-todd.fischer@ridgerun.com>
References: <1270511593-4785-1-git-send-email-todd.fischer@ridgerun.com>
 <1270511593-4785-2-git-send-email-todd.fischer@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fischerfamily.org ([71.216.156.246]:24917 "EHLO gw"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757018Ab0DEXwU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Apr 2010 19:52:20 -0400
In-Reply-To: <1270511593-4785-2-git-send-email-todd.fischer@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, sameo@linux.intel.com, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, todd.fischer@ridgerun.com

The touch screen controller in the TPS6507x chip needs values that are 
dependent on the characteristics of the touch screen hardware being used
in the board design.  In addition, the board provides version information
that is exposed via the kernel input sub-system.

Signed-off-by: Todd Fischer <todd.fischer@ridgerun.com>
---
 arch/arm/mach-davinci/board-da850-evm.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index d059924..b3cbb32 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -25,6 +25,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/regulator/machine.h>
+#include <linux/mfd/tps6507x.h>
+#include <linux/input/tps6507x-ts.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -534,8 +536,18 @@ struct regulator_init_data tps65070_regulator_data[] = {
 	},
 };
 
+static struct touchscreen_init_data tps6507x_touchscreen_data = {
+	.poll_period =  30,	/* ms between touch samples */
+	.min_pressure = 0x30,	/* minimum pressure to trigger touch */
+	.vref = 0,		/* turn off vref when not using A/D */
+	.vendor = 0,		/* /sys/class/input/input?/id/vendor */
+	.product = 65070,	/* /sys/class/input/input?/id/product */
+	.version = 0x100,	/* /sys/class/input/input?/id/version */
+};
+
 static struct tps6507x_board tps_board = {
 	.tps6507x_pmic_init_data = &tps65070_regulator_data[0],
+	.tps6507x_ts_init_data = &tps6507x_touchscreen_data,
 };
 
 static struct i2c_board_info __initdata da850evm_tps65070_info[] = {
-- 
1.6.0.4

