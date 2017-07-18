From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv6 4/4] hwmon: da9052: add support for TSI channel
Date: Tue, 18 Jul 2017 11:20:24 +0200
Message-ID: <20170718092024.22552-5-sebastian.reichel@collabora.co.uk>
References: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718092024.22552-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

TSI channel has a 4 channel mux connected to it and is normally
used for touchscreen support. The hardware may alternatively
use it as general purpose adc.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/hwmon/da9052-hwmon.c | 249 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 245 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
index 708c91ac601f..97a62f5b9ea4 100644
--- a/drivers/hwmon/da9052-hwmon.c
+++ b/drivers/hwmon/da9052-hwmon.c
@@ -20,13 +20,19 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <linux/mfd/da9052/da9052.h>
 #include <linux/mfd/da9052/reg.h>
+#include <linux/regulator/consumer.h>
 
 struct da9052_hwmon {
-	struct da9052	*da9052;
-	struct mutex	hwmon_lock;
+	struct da9052		*da9052;
+	struct mutex		hwmon_lock;
+	bool			tsi_as_adc;
+	int			tsiref_mv;
+	struct regulator	*tsiref;
+	struct completion	tsidone;
 };
 
 static const char * const input_names[] = {
@@ -37,6 +43,10 @@ static const char * const input_names[] = {
 	[DA9052_ADC_IN4]	=	"ADC IN4",
 	[DA9052_ADC_IN5]	=	"ADC IN5",
 	[DA9052_ADC_IN6]	=	"ADC IN6",
+	[DA9052_ADC_TSI_XP]	=	"ADC TS X+",
+	[DA9052_ADC_TSI_YP]	=	"ADC TS Y+",
+	[DA9052_ADC_TSI_XN]	=	"ADC TS X-",
+	[DA9052_ADC_TSI_YN]	=	"ADC TS Y-",
 	[DA9052_ADC_TJUNC]	=	"BATTERY JUNCTION TEMP",
 	[DA9052_ADC_VBBAT]	=	"BACK-UP BATTERY VOLTAGE",
 };
@@ -59,6 +69,11 @@ static inline int vbbat_reg_to_mv(int value)
 	return DIV_ROUND_CLOSEST(value * 5000, 1023);
 }
 
+static inline int input_tsireg_to_mv(struct da9052_hwmon *hwmon, int value)
+{
+	return DIV_ROUND_CLOSEST(value * hwmon->tsiref_mv, 1023);
+}
+
 static inline int da9052_enable_vddout_channel(struct da9052 *da9052)
 {
 	return da9052_reg_update(da9052, DA9052_ADC_CONT_REG,
@@ -154,6 +169,97 @@ static ssize_t da9052_read_misc_channel(struct device *dev,
 	return sprintf(buf, "%d\n", input_reg_to_mv(ret));
 }
 
+static int da9052_request_tsi_read(struct da9052_hwmon *hwmon, int channel)
+{
+	u8 val = DA9052_TSICONTB_TSIMAN;
+
+	switch (channel) {
+	case DA9052_ADC_TSI_XP:
+		val |= DA9052_TSICONTB_TSIMUX_XP;
+		break;
+	case DA9052_ADC_TSI_YP:
+		val |= DA9052_TSICONTB_TSIMUX_YP;
+		break;
+	case DA9052_ADC_TSI_XN:
+		val |= DA9052_TSICONTB_TSIMUX_XN;
+		break;
+	case DA9052_ADC_TSI_YN:
+		val |= DA9052_TSICONTB_TSIMUX_YN;
+		break;
+	}
+
+	return da9052_reg_write(hwmon->da9052, DA9052_TSI_CONT_B_REG, val);
+}
+
+static int da9052_get_tsi_result(struct da9052_hwmon *hwmon, int channel)
+{
+	u8 regs[3];
+	int msb, lsb, err;
+
+	/* block read to avoid separation of MSB and LSB */
+	err = da9052_group_read(hwmon->da9052, DA9052_TSI_X_MSB_REG,
+				ARRAY_SIZE(regs), regs);
+	if (err)
+		return err;
+
+	switch (channel) {
+	case DA9052_ADC_TSI_XP:
+	case DA9052_ADC_TSI_XN:
+		msb = regs[0] << DA9052_TSILSB_TSIXL_BITS;
+		lsb = regs[2] & DA9052_TSILSB_TSIXL;
+		lsb >>= DA9052_TSILSB_TSIXL_SHIFT;
+		break;
+	case DA9052_ADC_TSI_YP:
+	case DA9052_ADC_TSI_YN:
+		msb = regs[1] << DA9052_TSILSB_TSIYL_BITS;
+		lsb = regs[2] & DA9052_TSILSB_TSIYL;
+		lsb >>= DA9052_TSILSB_TSIYL_SHIFT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return msb | lsb;
+}
+
+
+static ssize_t __da9052_read_tsi(struct device *dev, int channel)
+{
+	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
+	int ret;
+
+	reinit_completion(&hwmon->tsidone);
+
+	ret = da9052_request_tsi_read(hwmon, channel);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for an conversion done interrupt */
+	if (!wait_for_completion_timeout(&hwmon->tsidone,
+					 msecs_to_jiffies(500)))
+		return -ETIMEDOUT;
+
+	return da9052_get_tsi_result(hwmon, channel);
+}
+
+static ssize_t da9052_read_tsi(struct device *dev,
+			       struct device_attribute *devattr,
+			       char *buf)
+{
+	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
+	int channel = to_sensor_dev_attr(devattr)->index;
+	int ret;
+
+	mutex_lock(&hwmon->hwmon_lock);
+	ret = __da9052_read_tsi(dev, channel);
+	mutex_unlock(&hwmon->hwmon_lock);
+
+	if (ret < 0)
+		return ret;
+	else
+		return sprintf(buf, "%d\n", input_tsireg_to_mv(hwmon, ret));
+}
+
 static ssize_t da9052_read_tjunc(struct device *dev,
 				 struct device_attribute *devattr, char *buf)
 {
@@ -196,6 +302,28 @@ static ssize_t show_label(struct device *dev,
 		       input_names[to_sensor_dev_attr(devattr)->index]);
 }
 
+static umode_t da9052_channel_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int index)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct da9052_hwmon *hwmon = dev_get_drvdata(dev);
+	struct device_attribute *dattr = container_of(attr,
+				struct device_attribute, attr);
+	struct sensor_device_attribute *sattr = to_sensor_dev_attr(dattr);
+
+	if (!hwmon->tsi_as_adc) {
+		switch (sattr->index) {
+		case DA9052_ADC_TSI_XP:
+		case DA9052_ADC_TSI_YP:
+		case DA9052_ADC_TSI_XN:
+		case DA9052_ADC_TSI_YN:
+			return 0;
+		}
+	}
+
+	return attr->mode;
+}
+
 static SENSOR_DEVICE_ATTR(in0_input, 0444, da9052_read_vddout, NULL,
 			  DA9052_ADC_VDDOUT);
 static SENSOR_DEVICE_ATTR(in0_label, 0444, show_label, NULL,
@@ -221,6 +349,23 @@ static SENSOR_DEVICE_ATTR(in9_input, 0444, da9052_read_vbbat, NULL,
 static SENSOR_DEVICE_ATTR(in9_label, 0444, show_label, NULL,
 			  DA9052_ADC_VBBAT);
 
+static SENSOR_DEVICE_ATTR(in70_input, 0444, da9052_read_tsi, NULL,
+			  DA9052_ADC_TSI_XP);
+static SENSOR_DEVICE_ATTR(in70_label, 0444, show_label, NULL,
+			  DA9052_ADC_TSI_XP);
+static SENSOR_DEVICE_ATTR(in71_input, 0444, da9052_read_tsi, NULL,
+			  DA9052_ADC_TSI_XN);
+static SENSOR_DEVICE_ATTR(in71_label, 0444, show_label, NULL,
+			  DA9052_ADC_TSI_XN);
+static SENSOR_DEVICE_ATTR(in72_input, 0444, da9052_read_tsi, NULL,
+			  DA9052_ADC_TSI_YP);
+static SENSOR_DEVICE_ATTR(in72_label, 0444, show_label, NULL,
+			  DA9052_ADC_TSI_YP);
+static SENSOR_DEVICE_ATTR(in73_input, 0444, da9052_read_tsi, NULL,
+			  DA9052_ADC_TSI_YN);
+static SENSOR_DEVICE_ATTR(in73_label, 0444, show_label, NULL,
+			  DA9052_ADC_TSI_YN);
+
 static SENSOR_DEVICE_ATTR(curr1_input, 0444, da9052_read_ich, NULL,
 			  DA9052_ADC_ICH);
 static SENSOR_DEVICE_ATTR(curr1_label, 0444, show_label, NULL,
@@ -246,6 +391,14 @@ static struct attribute *da9052_attrs[] = {
 	&sensor_dev_attr_in5_label.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
 	&sensor_dev_attr_in6_label.dev_attr.attr,
+	&sensor_dev_attr_in70_input.dev_attr.attr,
+	&sensor_dev_attr_in70_label.dev_attr.attr,
+	&sensor_dev_attr_in71_input.dev_attr.attr,
+	&sensor_dev_attr_in71_label.dev_attr.attr,
+	&sensor_dev_attr_in72_input.dev_attr.attr,
+	&sensor_dev_attr_in72_label.dev_attr.attr,
+	&sensor_dev_attr_in73_input.dev_attr.attr,
+	&sensor_dev_attr_in73_label.dev_attr.attr,
 	&sensor_dev_attr_in9_input.dev_attr.attr,
 	&sensor_dev_attr_in9_label.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
@@ -257,29 +410,117 @@ static struct attribute *da9052_attrs[] = {
 	NULL
 };
 
-ATTRIBUTE_GROUPS(da9052);
+static const struct attribute_group da9052_group = {
+	.attrs = da9052_attrs,
+	.is_visible = da9052_channel_is_visible,
+};
+__ATTRIBUTE_GROUPS(da9052);
+
+static irqreturn_t da9052_tsi_datardy_irq(int irq, void *data)
+{
+	struct da9052_hwmon *hwmon = data;
+
+	complete(&hwmon->tsidone);
+	return IRQ_HANDLED;
+}
 
 static int da9052_hwmon_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct da9052_hwmon *hwmon;
 	struct device *hwmon_dev;
+	int err;
 
 	hwmon = devm_kzalloc(dev, sizeof(struct da9052_hwmon), GFP_KERNEL);
 	if (!hwmon)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, hwmon);
+
 	mutex_init(&hwmon->hwmon_lock);
 	hwmon->da9052 = dev_get_drvdata(pdev->dev.parent);
 
+	init_completion(&hwmon->tsidone);
+
+	hwmon->tsi_as_adc =
+		device_property_read_bool(pdev->dev.parent, "dlg,tsi-as-adc");
+
+	if (hwmon->tsi_as_adc) {
+		hwmon->tsiref = devm_regulator_get(pdev->dev.parent, "tsiref");
+		if (IS_ERR(hwmon->tsiref)) {
+			err = PTR_ERR(hwmon->tsiref);
+			dev_err(&pdev->dev, "failed to get tsiref: %d", err);
+			return err;
+		}
+
+		err = regulator_enable(hwmon->tsiref);
+		if (err)
+			return err;
+
+		hwmon->tsiref_mv = regulator_get_voltage(hwmon->tsiref);
+		if (hwmon->tsiref_mv < 0) {
+			err = hwmon->tsiref_mv;
+			goto exit_regulator;
+		}
+
+		/* convert from microvolt (DT) to millivolt (hwmon) */
+		hwmon->tsiref_mv /= 1000;
+
+		/* TSIREF limits from datasheet */
+		if (hwmon->tsiref_mv < 1800 || hwmon->tsiref_mv > 2600) {
+			dev_err(hwmon->da9052->dev, "invalid TSIREF voltage: %d",
+				hwmon->tsiref_mv);
+			err = -ENXIO;
+			goto exit_regulator;
+		}
+
+		/* disable touchscreen features */
+		da9052_reg_write(hwmon->da9052, DA9052_TSI_CONT_A_REG, 0x00);
+
+		err = da9052_request_irq(hwmon->da9052, DA9052_IRQ_TSIREADY,
+					 "tsiready-irq", da9052_tsi_datardy_irq,
+					 hwmon);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to register TSIRDY IRQ: %d",
+				err);
+			goto exit_regulator;
+		}
+	}
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, "da9052",
 							   hwmon,
 							   da9052_groups);
-	return PTR_ERR_OR_ZERO(hwmon_dev);
+	err = PTR_ERR_OR_ZERO(hwmon_dev);
+	if (err)
+		goto exit_irq;
+
+	return 0;
+
+exit_irq:
+	if (hwmon->tsi_as_adc)
+		da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);
+exit_regulator:
+	if (hwmon->tsiref)
+		regulator_disable(hwmon->tsiref);
+
+	return err;
+}
+
+static int da9052_hwmon_remove(struct platform_device *pdev)
+{
+	struct da9052_hwmon *hwmon = platform_get_drvdata(pdev);
+
+	if (hwmon->tsi_as_adc) {
+		da9052_free_irq(hwmon->da9052, DA9052_IRQ_TSIREADY, hwmon);
+		regulator_disable(hwmon->tsiref);
+	}
+
+	return 0;
 }
 
 static struct platform_driver da9052_hwmon_driver = {
 	.probe = da9052_hwmon_probe,
+	.remove = da9052_hwmon_remove,
 	.driver = {
 		.name = "da9052-hwmon",
 	},
-- 
2.13.2
