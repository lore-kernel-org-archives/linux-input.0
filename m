From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] input: keyboard: remove duplicated include from mtk-pmic-keys.c
Date: Sun, 9 Dec 2018 14:34:40 +0800
Message-ID: <20181209063440.27820-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, matthias.bgg@gmail.com, lee.jones@linaro.org, chen.zhong@mediatek.com
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-input@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1..5027ebb 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -19,7 +19,6 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
-- 
2.7.0
