From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 07/10] mfd/extcon: max77693: Rename defines to allow inclusion with max77843
Date: Wed, 29 Apr 2015 19:58:32 +0900
Message-ID: <1430305114-23598-8-git-send-email-k.kozlowski.k@gmail.com>
References: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1430305114-23598-1-git-send-email-k.kozlowski.k@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
List-Id: linux-input@vger.kernel.org

Add MAX77693 prefix to some of the defines used in max77693 extcon
driver so the max77693-private.h can be included simultaneously with
max77843-private.h.

Additionally use BIT() macro in header.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/extcon/extcon-max77693.c     |  76 +++++++++++++-------------
 include/linux/mfd/max77693-private.h | 102 +++++++++++++++++------------------
 2 files changed, 91 insertions(+), 87 deletions(-)

diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 5bbf15a2d3d7..fa6c2161a138 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -43,7 +43,7 @@ static struct max77693_reg_data default_init_data[] = {
 	{
 		/* STATUS2 - [3]ChgDetRun */
 		.addr = MAX77693_MUIC_REG_STATUS2,
-		.data = STATUS2_CHGDETRUN_MASK,
+		.data = MAX77693_STATUS2_CHGDETRUN_MASK,
 	}, {
 		/* INTMASK1 - Unmask [3]ADC1KM,[0]ADCM */
 		.addr = MAX77693_MUIC_REG_INTMASK1,
@@ -263,7 +263,7 @@ static int max77693_muic_set_debounce_time(struct max77693_muic_info *info,
 		 */
 		ret = regmap_write(info->max77693->regmap_muic,
 				  MAX77693_MUIC_REG_CTRL3,
-				  time << CONTROL3_ADCDBSET_SHIFT);
+				  time << MAX77693_CONTROL3_ADCDBSET_SHIFT);
 		if (ret) {
 			dev_err(info->dev, "failed to set ADC debounce time\n");
 			return ret;
@@ -296,7 +296,7 @@ static int max77693_muic_set_path(struct max77693_muic_info *info,
 	if (attached)
 		ctrl1 = val;
 	else
-		ctrl1 = CONTROL1_SW_OPEN;
+		ctrl1 = MAX77693_CONTROL1_SW_OPEN;
 
 	ret = regmap_update_bits(info->max77693->regmap_muic,
 			MAX77693_MUIC_REG_CTRL1, COMP_SW_MASK, ctrl1);
@@ -306,13 +306,14 @@ static int max77693_muic_set_path(struct max77693_muic_info *info,
 	}
 
 	if (attached)
-		ctrl2 |= CONTROL2_CPEN_MASK;	/* LowPwr=0, CPEn=1 */
+		ctrl2 |= MAX77693_CONTROL2_CPEN_MASK;	/* LowPwr=0, CPEn=1 */
 	else
-		ctrl2 |= CONTROL2_LOWPWR_MASK;	/* LowPwr=1, CPEn=0 */
+		ctrl2 |= MAX77693_CONTROL2_LOWPWR_MASK;	/* LowPwr=1, CPEn=0 */
 
 	ret = regmap_update_bits(info->max77693->regmap_muic,
 			MAX77693_MUIC_REG_CTRL2,
-			CONTROL2_LOWPWR_MASK | CONTROL2_CPEN_MASK, ctrl2);
+			MAX77693_CONTROL2_LOWPWR_MASK | MAX77693_CONTROL2_CPEN_MASK,
+			ctrl2);
 	if (ret < 0) {
 		dev_err(info->dev, "failed to update MUIC register\n");
 		return ret;
@@ -354,8 +355,8 @@ static int max77693_muic_get_cable_type(struct max77693_muic_info *info,
 		 * Read ADC value to check cable type and decide cable state
 		 * according to cable type
 		 */
-		adc = info->status[0] & STATUS1_ADC_MASK;
-		adc >>= STATUS1_ADC_SHIFT;
+		adc = info->status[0] & MAX77693_STATUS1_ADC_MASK;
+		adc >>= MAX77693_STATUS1_ADC_SHIFT;
 
 		/*
 		 * Check current cable state/cable type and store cable type
@@ -378,8 +379,8 @@ static int max77693_muic_get_cable_type(struct max77693_muic_info *info,
 		 * Read ADC value to check cable type and decide cable state
 		 * according to cable type
 		 */
-		adc = info->status[0] & STATUS1_ADC_MASK;
-		adc >>= STATUS1_ADC_SHIFT;
+		adc = info->status[0] & MAX77693_STATUS1_ADC_MASK;
+		adc >>= MAX77693_STATUS1_ADC_SHIFT;
 
 		/*
 		 * Check current cable state/cable type and store cable type
@@ -394,13 +395,13 @@ static int max77693_muic_get_cable_type(struct max77693_muic_info *info,
 		} else {
 			*attached = true;
 
-			adclow = info->status[0] & STATUS1_ADCLOW_MASK;
-			adclow >>= STATUS1_ADCLOW_SHIFT;
-			adc1k = info->status[0] & STATUS1_ADC1K_MASK;
-			adc1k >>= STATUS1_ADC1K_SHIFT;
+			adclow = info->status[0] & MAX77693_STATUS1_ADCLOW_MASK;
+			adclow >>= MAX77693_STATUS1_ADCLOW_SHIFT;
+			adc1k = info->status[0] & MAX77693_STATUS1_ADC1K_MASK;
+			adc1k >>= MAX77693_STATUS1_ADC1K_SHIFT;
 
-			vbvolt = info->status[1] & STATUS2_VBVOLT_MASK;
-			vbvolt >>= STATUS2_VBVOLT_SHIFT;
+			vbvolt = info->status[1] & MAX77693_STATUS2_VBVOLT_MASK;
+			vbvolt >>= MAX77693_STATUS2_VBVOLT_SHIFT;
 
 			/**
 			 * [0x1|VBVolt|ADCLow|ADC1K]
@@ -425,8 +426,8 @@ static int max77693_muic_get_cable_type(struct max77693_muic_info *info,
 		 * Read charger type to check cable type and decide cable state
 		 * according to type of charger cable.
 		 */
-		chg_type = info->status[1] & STATUS2_CHGTYP_MASK;
-		chg_type >>= STATUS2_CHGTYP_SHIFT;
+		chg_type = info->status[1] & MAX77693_STATUS2_CHGTYP_MASK;
+		chg_type >>= MAX77693_STATUS2_CHGTYP_SHIFT;
 
 		if (chg_type == MAX77693_CHARGER_TYPE_NONE) {
 			*attached = false;
@@ -450,10 +451,10 @@ static int max77693_muic_get_cable_type(struct max77693_muic_info *info,
 		 * Read ADC value to check cable type and decide cable state
 		 * according to cable type
 		 */
-		adc = info->status[0] & STATUS1_ADC_MASK;
-		adc >>= STATUS1_ADC_SHIFT;
-		chg_type = info->status[1] & STATUS2_CHGTYP_MASK;
-		chg_type >>= STATUS2_CHGTYP_SHIFT;
+		adc = info->status[0] & MAX77693_STATUS1_ADC_MASK;
+		adc >>= MAX77693_STATUS1_ADC_SHIFT;
+		chg_type = info->status[1] & MAX77693_STATUS2_CHGTYP_MASK;
+		chg_type >>= MAX77693_STATUS2_CHGTYP_SHIFT;
 
 		if (adc == MAX77693_MUIC_ADC_OPEN
 				&& chg_type == MAX77693_CHARGER_TYPE_NONE)
@@ -465,8 +466,8 @@ static int max77693_muic_get_cable_type(struct max77693_muic_info *info,
 		 * Read vbvolt field, if vbvolt is 1,
 		 * this cable is used for charging.
 		 */
-		vbvolt = info->status[1] & STATUS2_VBVOLT_MASK;
-		vbvolt >>= STATUS2_VBVOLT_SHIFT;
+		vbvolt = info->status[1] & MAX77693_STATUS2_VBVOLT_MASK;
+		vbvolt >>= MAX77693_STATUS2_VBVOLT_SHIFT;
 
 		cable_type = vbvolt;
 		break;
@@ -548,7 +549,8 @@ static int max77693_muic_dock_handler(struct max77693_muic_info *info,
 	}
 
 	/* Dock-Car/Desk/Audio, PATH:AUDIO */
-	ret = max77693_muic_set_path(info, CONTROL1_SW_AUDIO, attached);
+	ret = max77693_muic_set_path(info, MAX77693_CONTROL1_SW_AUDIO,
+					attached);
 	if (ret < 0)
 		return ret;
 	extcon_set_cable_state(info->edev, dock_name, attached);
@@ -613,14 +615,16 @@ static int max77693_muic_adc_ground_handler(struct max77693_muic_info *info)
 	case MAX77693_MUIC_GND_USB_HOST:
 	case MAX77693_MUIC_GND_USB_HOST_VB:
 		/* USB_HOST, PATH: AP_USB */
-		ret = max77693_muic_set_path(info, CONTROL1_SW_USB, attached);
+		ret = max77693_muic_set_path(info, MAX77693_CONTROL1_SW_USB,
+						attached);
 		if (ret < 0)
 			return ret;
 		extcon_set_cable_state(info->edev, "USB-Host", attached);
 		break;
 	case MAX77693_MUIC_GND_AV_CABLE_LOAD:
 		/* Audio Video Cable with load, PATH:AUDIO */
-		ret = max77693_muic_set_path(info, CONTROL1_SW_AUDIO, attached);
+		ret = max77693_muic_set_path(info, MAX77693_CONTROL1_SW_AUDIO,
+						attached);
 		if (ret < 0)
 			return ret;
 		extcon_set_cable_state(info->edev,
@@ -645,7 +649,7 @@ static int max77693_muic_jig_handler(struct max77693_muic_info *info,
 {
 	char cable_name[32];
 	int ret = 0;
-	u8 path = CONTROL1_SW_OPEN;
+	u8 path = MAX77693_CONTROL1_SW_OPEN;
 
 	dev_info(info->dev,
 		"external connector is %s (adc:0x%02x)\n",
@@ -655,22 +659,22 @@ static int max77693_muic_jig_handler(struct max77693_muic_info *info,
 	case MAX77693_MUIC_ADC_FACTORY_MODE_USB_OFF:	/* ADC_JIG_USB_OFF */
 		/* PATH:AP_USB */
 		strcpy(cable_name, "JIG-USB-OFF");
-		path = CONTROL1_SW_USB;
+		path = MAX77693_CONTROL1_SW_USB;
 		break;
 	case MAX77693_MUIC_ADC_FACTORY_MODE_USB_ON:	/* ADC_JIG_USB_ON */
 		/* PATH:AP_USB */
 		strcpy(cable_name, "JIG-USB-ON");
-		path = CONTROL1_SW_USB;
+		path = MAX77693_CONTROL1_SW_USB;
 		break;
 	case MAX77693_MUIC_ADC_FACTORY_MODE_UART_OFF:	/* ADC_JIG_UART_OFF */
 		/* PATH:AP_UART */
 		strcpy(cable_name, "JIG-UART-OFF");
-		path = CONTROL1_SW_UART;
+		path = MAX77693_CONTROL1_SW_UART;
 		break;
 	case MAX77693_MUIC_ADC_FACTORY_MODE_UART_ON:	/* ADC_JIG_UART_ON */
 		/* PATH:AP_UART */
 		strcpy(cable_name, "JIG-UART-ON");
-		path = CONTROL1_SW_UART;
+		path = MAX77693_CONTROL1_SW_UART;
 		break;
 	default:
 		dev_err(info->dev, "failed to detect %s jig cable\n",
@@ -1232,12 +1236,12 @@ static int max77693_muic_probe(struct platform_device *pdev)
 		if (muic_pdata->path_uart)
 			info->path_uart = muic_pdata->path_uart;
 		else
-			info->path_uart = CONTROL1_SW_UART;
+			info->path_uart = MAX77693_CONTROL1_SW_UART;
 
 		if (muic_pdata->path_usb)
 			info->path_usb = muic_pdata->path_usb;
 		else
-			info->path_usb = CONTROL1_SW_USB;
+			info->path_usb = MAX77693_CONTROL1_SW_USB;
 
 		/*
 		 * Default delay time for detecting cable state
@@ -1249,8 +1253,8 @@ static int max77693_muic_probe(struct platform_device *pdev)
 		else
 			delay_jiffies = msecs_to_jiffies(DELAY_MS_DEFAULT);
 	} else {
-		info->path_usb = CONTROL1_SW_USB;
-		info->path_uart = CONTROL1_SW_UART;
+		info->path_usb = MAX77693_CONTROL1_SW_USB;
+		info->path_uart = MAX77693_CONTROL1_SW_UART;
 		delay_jiffies = msecs_to_jiffies(DELAY_MS_DEFAULT);
 	}
 
diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 8c4143c0c651..7201c0b61bd5 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -310,30 +310,30 @@ enum max77693_muic_reg {
 #define INTMASK2_CHGTYP_MASK		(1 << INTMASK2_CHGTYP_SHIFT)
 
 /* MAX77693 MUIC - STATUS1~3 Register */
-#define STATUS1_ADC_SHIFT		(0)
-#define STATUS1_ADCLOW_SHIFT		(5)
-#define STATUS1_ADCERR_SHIFT		(6)
-#define STATUS1_ADC1K_SHIFT		(7)
-#define STATUS1_ADC_MASK		(0x1f << STATUS1_ADC_SHIFT)
-#define STATUS1_ADCLOW_MASK		(0x1 << STATUS1_ADCLOW_SHIFT)
-#define STATUS1_ADCERR_MASK		(0x1 << STATUS1_ADCERR_SHIFT)
-#define STATUS1_ADC1K_MASK		(0x1 << STATUS1_ADC1K_SHIFT)
-
-#define STATUS2_CHGTYP_SHIFT		(0)
-#define STATUS2_CHGDETRUN_SHIFT		(3)
-#define STATUS2_DCDTMR_SHIFT		(4)
-#define STATUS2_DXOVP_SHIFT		(5)
-#define STATUS2_VBVOLT_SHIFT		(6)
-#define STATUS2_VIDRM_SHIFT		(7)
-#define STATUS2_CHGTYP_MASK		(0x7 << STATUS2_CHGTYP_SHIFT)
-#define STATUS2_CHGDETRUN_MASK		(0x1 << STATUS2_CHGDETRUN_SHIFT)
-#define STATUS2_DCDTMR_MASK		(0x1 << STATUS2_DCDTMR_SHIFT)
-#define STATUS2_DXOVP_MASK		(0x1 << STATUS2_DXOVP_SHIFT)
-#define STATUS2_VBVOLT_MASK		(0x1 << STATUS2_VBVOLT_SHIFT)
-#define STATUS2_VIDRM_MASK		(0x1 << STATUS2_VIDRM_SHIFT)
-
-#define STATUS3_OVP_SHIFT		(2)
-#define STATUS3_OVP_MASK		(0x1 << STATUS3_OVP_SHIFT)
+#define MAX77693_STATUS1_ADC_SHIFT		(0)
+#define MAX77693_STATUS1_ADCLOW_SHIFT		(5)
+#define MAX77693_STATUS1_ADCERR_SHIFT		(6)
+#define MAX77693_STATUS1_ADC1K_SHIFT		(7)
+#define MAX77693_STATUS1_ADC_MASK		(0x1f << MAX77693_STATUS1_ADC_SHIFT)
+#define MAX77693_STATUS1_ADCLOW_MASK		BIT(MAX77693_STATUS1_ADCLOW_SHIFT)
+#define MAX77693_STATUS1_ADCERR_MASK		BIT(MAX77693_STATUS1_ADCERR_SHIFT)
+#define MAX77693_STATUS1_ADC1K_MASK		BIT(MAX77693_STATUS1_ADC1K_SHIFT)
+
+#define MAX77693_STATUS2_CHGTYP_SHIFT		(0)
+#define MAX77693_STATUS2_CHGDETRUN_SHIFT	(3)
+#define MAX77693_STATUS2_DCDTMR_SHIFT		(4)
+#define MAX77693_STATUS2_DXOVP_SHIFT		(5)
+#define MAX77693_STATUS2_VBVOLT_SHIFT		(6)
+#define MAX77693_STATUS2_VIDRM_SHIFT		(7)
+#define MAX77693_STATUS2_CHGTYP_MASK		(0x7 << MAX77693_STATUS2_CHGTYP_SHIFT)
+#define MAX77693_STATUS2_CHGDETRUN_MASK		BIT(MAX77693_STATUS2_CHGDETRUN_SHIFT)
+#define MAX77693_STATUS2_DCDTMR_MASK		BIT(MAX77693_STATUS2_DCDTMR_SHIFT)
+#define MAX77693_STATUS2_DXOVP_MASK		BIT(MAX77693_STATUS2_DXOVP_SHIFT)
+#define MAX77693_STATUS2_VBVOLT_MASK		BIT(MAX77693_STATUS2_VBVOLT_SHIFT)
+#define MAX77693_STATUS2_VIDRM_MASK		BIT(MAX77693_STATUS2_VIDRM_SHIFT)
+
+#define MAX77693_STATUS3_OVP_SHIFT		(2)
+#define MAX77693_STATUS3_OVP_MASK		BIT(MAX77693_STATUS3_OVP_SHIFT)
 
 /* MAX77693 CDETCTRL1~2 register */
 #define CDETCTRL1_CHGDETEN_SHIFT	(0)
@@ -362,38 +362,38 @@ enum max77693_muic_reg {
 #define COMN1SW_MASK			(0x7 << COMN1SW_SHIFT)
 #define COMP2SW_MASK			(0x7 << COMP2SW_SHIFT)
 #define COMP_SW_MASK			(COMP2SW_MASK | COMN1SW_MASK)
-#define CONTROL1_SW_USB			((1 << COMP2SW_SHIFT) \
+#define MAX77693_CONTROL1_SW_USB	((1 << COMP2SW_SHIFT) \
 						| (1 << COMN1SW_SHIFT))
-#define CONTROL1_SW_AUDIO		((2 << COMP2SW_SHIFT) \
+#define MAX77693_CONTROL1_SW_AUDIO	((2 << COMP2SW_SHIFT) \
 						| (2 << COMN1SW_SHIFT))
-#define CONTROL1_SW_UART		((3 << COMP2SW_SHIFT) \
+#define MAX77693_CONTROL1_SW_UART	((3 << COMP2SW_SHIFT) \
 						| (3 << COMN1SW_SHIFT))
-#define CONTROL1_SW_OPEN		((0 << COMP2SW_SHIFT) \
+#define MAX77693_CONTROL1_SW_OPEN	((0 << COMP2SW_SHIFT) \
 						| (0 << COMN1SW_SHIFT))
 
-#define CONTROL2_LOWPWR_SHIFT		(0)
-#define CONTROL2_ADCEN_SHIFT		(1)
-#define CONTROL2_CPEN_SHIFT		(2)
-#define CONTROL2_SFOUTASRT_SHIFT	(3)
-#define CONTROL2_SFOUTORD_SHIFT		(4)
-#define CONTROL2_ACCDET_SHIFT		(5)
-#define CONTROL2_USBCPINT_SHIFT		(6)
-#define CONTROL2_RCPS_SHIFT		(7)
-#define CONTROL2_LOWPWR_MASK		(0x1 << CONTROL2_LOWPWR_SHIFT)
-#define CONTROL2_ADCEN_MASK		(0x1 << CONTROL2_ADCEN_SHIFT)
-#define CONTROL2_CPEN_MASK		(0x1 << CONTROL2_CPEN_SHIFT)
-#define CONTROL2_SFOUTASRT_MASK		(0x1 << CONTROL2_SFOUTASRT_SHIFT)
-#define CONTROL2_SFOUTORD_MASK		(0x1 << CONTROL2_SFOUTORD_SHIFT)
-#define CONTROL2_ACCDET_MASK		(0x1 << CONTROL2_ACCDET_SHIFT)
-#define CONTROL2_USBCPINT_MASK		(0x1 << CONTROL2_USBCPINT_SHIFT)
-#define CONTROL2_RCPS_MASK		(0x1 << CONTROL2_RCPS_SHIFT)
-
-#define CONTROL3_JIGSET_SHIFT		(0)
-#define CONTROL3_BTLDSET_SHIFT		(2)
-#define CONTROL3_ADCDBSET_SHIFT		(4)
-#define CONTROL3_JIGSET_MASK		(0x3 << CONTROL3_JIGSET_SHIFT)
-#define CONTROL3_BTLDSET_MASK		(0x3 << CONTROL3_BTLDSET_SHIFT)
-#define CONTROL3_ADCDBSET_MASK		(0x3 << CONTROL3_ADCDBSET_SHIFT)
+#define MAX77693_CONTROL2_LOWPWR_SHIFT		(0)
+#define MAX77693_CONTROL2_ADCEN_SHIFT		(1)
+#define MAX77693_CONTROL2_CPEN_SHIFT		(2)
+#define MAX77693_CONTROL2_SFOUTASRT_SHIFT	(3)
+#define MAX77693_CONTROL2_SFOUTORD_SHIFT	(4)
+#define MAX77693_CONTROL2_ACCDET_SHIFT		(5)
+#define MAX77693_CONTROL2_USBCPINT_SHIFT	(6)
+#define MAX77693_CONTROL2_RCPS_SHIFT		(7)
+#define MAX77693_CONTROL2_LOWPWR_MASK		BIT(MAX77693_CONTROL2_LOWPWR_SHIFT)
+#define MAX77693_CONTROL2_ADCEN_MASK		BIT(MAX77693_CONTROL2_ADCEN_SHIFT)
+#define MAX77693_CONTROL2_CPEN_MASK		BIT(MAX77693_CONTROL2_CPEN_SHIFT)
+#define MAX77693_CONTROL2_SFOUTASRT_MASK	BIT(MAX77693_CONTROL2_SFOUTASRT_SHIFT)
+#define MAX77693_CONTROL2_SFOUTORD_MASK		BIT(MAX77693_CONTROL2_SFOUTORD_SHIFT)
+#define MAX77693_CONTROL2_ACCDET_MASK		BIT(MAX77693_CONTROL2_ACCDET_SHIFT)
+#define MAX77693_CONTROL2_USBCPINT_MASK		BIT(MAX77693_CONTROL2_USBCPINT_SHIFT)
+#define MAX77693_CONTROL2_RCPS_MASK		BIT(MAX77693_CONTROL2_RCPS_SHIFT)
+
+#define MAX77693_CONTROL3_JIGSET_SHIFT		(0)
+#define MAX77693_CONTROL3_BTLDSET_SHIFT		(2)
+#define MAX77693_CONTROL3_ADCDBSET_SHIFT	(4)
+#define MAX77693_CONTROL3_JIGSET_MASK		(0x3 << MAX77693_CONTROL3_JIGSET_SHIFT)
+#define MAX77693_CONTROL3_BTLDSET_MASK		(0x3 << MAX77693_CONTROL3_BTLDSET_SHIFT)
+#define MAX77693_CONTROL3_ADCDBSET_MASK		(0x3 << MAX77693_CONTROL3_ADCDBSET_SHIFT)
 
 /* Slave addr = 0x90: Haptic */
 enum max77693_haptic_reg {
-- 
2.1.4

