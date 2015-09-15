From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v6 1/9] Input: goodix - sort includes alphabetically
Date: Tue, 15 Sep 2015 17:31:15 +0300
Message-ID: <1442327483-19407-2-git-send-email-irina.tirdea@intel.com>
References: <1442327483-19407-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442327483-19407-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/touchscreen/goodix.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index e36162b..6ae28c5 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -14,18 +14,18 @@
  * Software Foundation; version 2 of the License.
  */
 
-#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
-#include <linux/slab.h>
-#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 #include <asm/unaligned.h>
 
 struct goodix_ts_data {
-- 
1.9.1
