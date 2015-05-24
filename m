From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH v2 2/9] mfd: max77693: Store I2C device type as enum and add default unknown
Date: Sun, 24 May 2015 14:43:26 +0900
Message-ID: <1432446213-4886-3-git-send-email-k.kozlowski.k@gmail.com>
References: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432446213-4886-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

Store the device type (obtained from i2c_device_id) as an enum and add a
default type of unknown to distinguish from case when this is not set
at all.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
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
