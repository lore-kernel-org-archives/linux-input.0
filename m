From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 01/10] mfd/extcon: max77693: Remove unused extern declarations and max77693_dev members
Date: Wed, 29 Apr 2015 19:58:26 +0900
Message-ID: <1430305114-23598-2-git-send-email-k.kozlowski.k@gmail.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

Clean up the max77693 private header file by removing:
1. Left-overs from previous way of interrupt handling (driver uses
   regmap_irq_chip).
2. Unused members of struct 'max77693_dev' related to interrupts in
   extcon driver.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/extcon/extcon-max77693.c     | 4 ----
 include/linux/mfd/max77693-private.h | 8 --------
 2 files changed, 12 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index a66bec8f6252..760e1e2cc1ce 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1218,10 +1218,6 @@ static int max77693_muic_probe(struct platform_device *pdev)
 			irq_src = MUIC_INT3;
 			break;
 		}
-
-		if (irq_src < MAX77693_IRQ_GROUP_NR)
-			info->max77693->irq_masks_cur[irq_src]
-				= init_data[i].data;
 	}
 
 	if (pdata && pdata->muic_data) {
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 51633ea6f910..ad67b8235a8d 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -547,18 +547,10 @@ struct max77693_dev {
 	struct regmap_irq_chip_data *irq_data_muic;
 
 	int irq;
-	int irq_gpio;
-	struct mutex irqlock;
-	int irq_masks_cur[MAX77693_IRQ_GROUP_NR];
-	int irq_masks_cache[MAX77693_IRQ_GROUP_NR];
 };
 
 enum max77693_types {
 	TYPE_MAX77693,
 };
 
-extern int max77693_irq_init(struct max77693_dev *max77686);
-extern void max77693_irq_exit(struct max77693_dev *max77686);
-extern int max77693_irq_resume(struct max77693_dev *max77686);
-
 #endif /*  __LINUX_MFD_MAX77693_PRIV_H */
-- 
2.1.4
