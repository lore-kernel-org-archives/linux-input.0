From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] input: keyboard: remove duplicated include from mtk-pmic-keys.c
Date: Tue, 11 Dec 2018 17:32:00 +0800
Message-ID: <20181211093200.18140-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, matthias.bgg@gmail.com, lee.jones@linaro.org, chen.zhong@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

alphabetise the header files and remove duplicated include
file linux/kernel.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: alphabetise the header files
---
 drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1..8e6ebab 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -14,18 +14,17 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/regmap.h>
 #include <linux/mfd/mt6323/registers.h>
-#include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/registers.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
 #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
-- 
2.7.4
