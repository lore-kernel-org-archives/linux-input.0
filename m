From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v9 9/9] Input: goodix - sort includes using inverse Xmas tree order
Date: Mon, 12 Oct 2015 18:24:37 +0300
Message-ID: <1444663477-30062-10-git-send-email-irina.tirdea@intel.com>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Tested-by: Bastien Nocera <hadess@hadess.net>
Tested-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 drivers/input/touchscreen/goodix.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index b958b37..22bfc4b 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -14,21 +14,22 @@
  * Software Foundation; version 2 of the License.
  */
 
-#include <linux/kernel.h>
-#include <linux/dmi.h>
+#include <linux/pm_runtime.h>
+#include <linux/interrupt.h>
 #include <linux/firmware.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
+#include <linux/input.h>
 #include <linux/acpi.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/dmi.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
 #include <linux/of.h>
-#include <linux/pm_runtime.h>
+
 #include <asm/unaligned.h>
 
 struct goodix_ts_data {
-- 
1.9.1
