From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH v3 2/9] mfd: max77693: Store I2C device type as enum and add default unknown
Date: Wed,  8 Jul 2015 20:00:10 +0900
Message-ID: <1436353217-1141-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1436353217-1141-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

Store the device type (obtained from i2c_device_id) as an enum and add a
default type of unknown to distinguish from case when this is not set
at all.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/max77693-private.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index ad67b8235a8d..e3c0afff38d3 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -529,13 +529,18 @@ enum max77693_irq_muic {
 	MAX77693_MUIC_IRQ_NR,
 };
 
+enum max77693_types {
+	TYPE_MAX77693_UNKNOWN,
+	TYPE_MAX77693,
+};
+
 struct max77693_dev {
 	struct device *dev;
 	struct i2c_client *i2c;		/* 0xCC , PMIC, Charger, Flash LED */
 	struct i2c_client *muic;	/* 0x4A , MUIC */
 	struct i2c_client *haptic;	/* 0x90 , Haptic */
 
-	int type;
+	enum max77693_types type;
 
 	struct regmap *regmap;
 	struct regmap *regmap_muic;
@@ -549,8 +554,4 @@ struct max77693_dev {
 	int irq;
 };
 
-enum max77693_types {
-	TYPE_MAX77693,
-};
-
 #endif /*  __LINUX_MFD_MAX77693_PRIV_H */
-- 
2.1.4

