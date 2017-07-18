From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 1/4] mfd: da9052: add register details for TSI
Date: Tue, 18 Jul 2017 11:20:21 +0200
Message-ID: <20170718092024.22552-2-sebastian.reichel@collabora.co.uk>
References: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

Add register details an channels definition for using the TSI
registers in the hwmon driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 include/linux/mfd/da9052/da9052.h |  6 ++++++
 include/linux/mfd/da9052/reg.h    | 11 ++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/da9052/da9052.h b/include/linux/mfd/da9052/da9052.h
index ce9230af09c2..ae5b663836d0 100644
--- a/include/linux/mfd/da9052/da9052.h
+++ b/include/linux/mfd/da9052/da9052.h
@@ -45,6 +45,12 @@
 #define DA9052_ADC_TJUNC	8
 #define DA9052_ADC_VBBAT	9
 
+/* TSI channel has its own 4 channel mux */
+#define DA9052_ADC_TSI_XP	70
+#define DA9052_ADC_TSI_XN	71
+#define DA9052_ADC_TSI_YP	72
+#define DA9052_ADC_TSI_YN	73
+
 #define DA9052_IRQ_DCIN	0
 #define DA9052_IRQ_VBUS	1
 #define DA9052_IRQ_DCINREM	2
diff --git a/include/linux/mfd/da9052/reg.h b/include/linux/mfd/da9052/reg.h
index 5010f978725c..76780ea8849c 100644
--- a/include/linux/mfd/da9052/reg.h
+++ b/include/linux/mfd/da9052/reg.h
@@ -690,7 +690,10 @@
 /* TSI CONTROL REGISTER B BITS */
 #define DA9052_TSICONTB_ADCREF		0X80
 #define DA9052_TSICONTB_TSIMAN		0X40
-#define DA9052_TSICONTB_TSIMUX		0X30
+#define DA9052_TSICONTB_TSIMUX_XP	0X00
+#define DA9052_TSICONTB_TSIMUX_YP	0X10
+#define DA9052_TSICONTB_TSIMUX_XN	0X20
+#define DA9052_TSICONTB_TSIMUX_YN	0X30
 #define DA9052_TSICONTB_TSISEL3	0X08
 #define DA9052_TSICONTB_TSISEL2	0X04
 #define DA9052_TSICONTB_TSISEL1	0X02
@@ -705,8 +708,14 @@
 /* TSI CO-ORDINATE LSB RESULT REGISTER BITS */
 #define DA9052_TSILSB_PENDOWN		0X40
 #define DA9052_TSILSB_TSIZL		0X30
+#define DA9052_TSILSB_TSIZL_SHIFT	4
+#define DA9052_TSILSB_TSIZL_BITS	2
 #define DA9052_TSILSB_TSIYL		0X0C
+#define DA9052_TSILSB_TSIYL_SHIFT	2
+#define DA9052_TSILSB_TSIYL_BITS	2
 #define DA9052_TSILSB_TSIXL		0X03
+#define DA9052_TSILSB_TSIXL_SHIFT	0
+#define DA9052_TSILSB_TSIXL_BITS	2
 
 /* TSI Z MEASUREMENT MSB RESULT REGISTER BIT */
 #define DA9052_TSIZMSB_TSIZM		0XFF
-- 
2.13.2
