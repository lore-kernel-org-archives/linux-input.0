From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Date: Fri, 17 Apr 2015 15:23:33 +0100
Message-ID: <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1429280614.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, S Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource@diasemi.com>

Add RTC driver support for DA9062

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---

This patch applies against linux-next and v4.0 



 drivers/rtc/Kconfig      |  10 ++
 drivers/rtc/Makefile     |   1 +
 drivers/rtc/rtc-da9062.c | 367 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 378 insertions(+)
 create mode 100644 drivers/rtc/rtc-da9062.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index b5b5c3d..c4d21bd 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -927,6 +927,16 @@ config RTC_DRV_DA9055
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-da9055
 
+config RTC_DRV_DA9062
+	tristate "Dialog Semiconductor DA9062 RTC"
+	depends on MFD_DA9062
+	help
+	  If you say yes here you will get support for the RTC subsystem
+	  of the Dialog Semiconductor DA9062.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called "rtc-da9062".
+
 config RTC_DRV_DA9063
 	tristate "Dialog Semiconductor DA9063 RTC"
 	depends on MFD_DA9063
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 69c8706..9108e62 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc-cmos.o
 obj-$(CONFIG_RTC_DRV_COH901331)	+= rtc-coh901331.o
 obj-$(CONFIG_RTC_DRV_DA9052)	+= rtc-da9052.o
 obj-$(CONFIG_RTC_DRV_DA9055)	+= rtc-da9055.o
+obj-$(CONFIG_RTC_DRV_DA9062)	+= rtc-da9062.o
 obj-$(CONFIG_RTC_DRV_DA9063)	+= rtc-da9063.o
 obj-$(CONFIG_RTC_DRV_DAVINCI)	+= rtc-davinci.o
 obj-$(CONFIG_RTC_DRV_DM355EVM)	+= rtc-dm355evm.o
diff --git a/drivers/rtc/rtc-da9062.c b/drivers/rtc/rtc-da9062.c
new file mode 100644
index 0000000..0f3d646
--- /dev/null
+++ b/drivers/rtc/rtc-da9062.c
@@ -0,0 +1,367 @@
+/*
+ * rtc-da9062.c - RTC device driver for DA9062
+ * Copyright (C) 2015  Dialog Semiconductor Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/mfd/da9062/registers.h>
+#include <linux/mfd/da9062/core.h>
+
+#define DA9062_GET_TIME_RETRIES	5
+
+#define YEARS_TO_DA9062(year)		((year) - 100)
+#define MONTHS_TO_DA9062(month)		((month) + 1)
+#define YEARS_FROM_DA9062(year)		((year) + 100)
+#define MONTHS_FROM_DA9062(month)	((month) - 1)
+
+#define RTC_DATA_LEN	(DA9062AA_COUNT_Y - DA9062AA_COUNT_S + 1)
+enum {
+	RTC_SEC = 0,
+	RTC_MIN = 1,
+	RTC_HOUR = 2,
+	RTC_DAY = 3,
+	RTC_MONTH = 4,
+	RTC_YEAR = 5,
+};
+
+#define DA9062AA_ALARM_STATUS_ENUM_TIMER (0x02 << 6)
+
+struct da9062_rtc {
+	struct rtc_device *rtc_dev;
+	struct da9062 *hw;
+	struct rtc_time alarm_time;
+	bool rtc_sync;
+};
+
+static void da9062_data_to_tm(u8 *data, struct rtc_time *tm)
+{
+	tm->tm_sec  = data[RTC_SEC]  & DA9062AA_COUNT_SEC_MASK;
+	tm->tm_min  = data[RTC_MIN]  & DA9062AA_COUNT_MIN_MASK;
+	tm->tm_hour = data[RTC_HOUR] & DA9062AA_COUNT_HOUR_MASK;
+	tm->tm_mday = data[RTC_DAY]  & DA9062AA_COUNT_DAY_MASK;
+	tm->tm_mon  = MONTHS_FROM_DA9062(data[RTC_MONTH] &
+					 DA9062AA_COUNT_MONTH_MASK);
+	tm->tm_year = YEARS_FROM_DA9062(data[RTC_YEAR] &
+					DA9062AA_COUNT_YEAR_MASK);
+}
+
+static void da9062_tm_to_data(struct rtc_time *tm, u8 *data)
+{
+	data[RTC_SEC] &= ~DA9062AA_COUNT_SEC_MASK;
+	data[RTC_SEC] |= tm->tm_sec & DA9062AA_COUNT_SEC_MASK;
+
+	data[RTC_MIN] &= ~DA9062AA_COUNT_MIN_MASK;
+	data[RTC_MIN] |= tm->tm_min & DA9062AA_COUNT_MIN_MASK;
+
+	data[RTC_HOUR] &= ~DA9062AA_COUNT_HOUR_MASK;
+	data[RTC_HOUR] |= tm->tm_hour & DA9062AA_COUNT_HOUR_MASK;
+
+	data[RTC_DAY] &= ~DA9062AA_COUNT_DAY_MASK;
+	data[RTC_DAY] |= tm->tm_mday & DA9062AA_COUNT_DAY_MASK;
+
+	data[RTC_MONTH] &= ~DA9062AA_COUNT_MONTH_MASK;
+	data[RTC_MONTH] |= MONTHS_TO_DA9062(tm->tm_mon) &
+				DA9062AA_COUNT_MONTH_MASK;
+
+	data[RTC_YEAR] &= ~DA9062AA_COUNT_YEAR_MASK;
+	data[RTC_YEAR] |= YEARS_TO_DA9062(tm->tm_year) &
+				DA9062AA_COUNT_YEAR_MASK;
+}
+
+static int da9062_rtc_stop_alarm(struct device *dev)
+{
+	struct da9062_rtc *rtc = dev_get_drvdata(dev);
+
+	return regmap_update_bits(rtc->hw->regmap,
+				  DA9062AA_ALARM_Y,
+				  DA9062AA_ALARM_ON_MASK,
+				  0);
+}
+
+static int da9062_rtc_start_alarm(struct device *dev)
+{
+	struct da9062_rtc *rtc = dev_get_drvdata(dev);
+
+	return regmap_update_bits(rtc->hw->regmap,
+				  DA9062AA_ALARM_Y,
+				  DA9062AA_ALARM_ON_MASK,
+				  DA9062AA_ALARM_ON_MASK);
+}
+
+static int da9062_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct da9062_rtc *rtc = dev_get_drvdata(dev);
+	unsigned long tm_secs;
+	unsigned long al_secs;
+	u8 data[RTC_DATA_LEN];
+	int timeout = DA9062_GET_TIME_RETRIES;
+	bool read_done = false;
+	int ret;
+
+	while (timeout--) {
+		ret = regmap_bulk_read(rtc->hw->regmap, DA9062AA_COUNT_S,
+				       data, RTC_DATA_LEN);
+		if (ret < 0) {
+			dev_err(dev, "Failed to read RTC time data: %d\n", ret);
+			return ret;
+		}
+
+		/* rtc ready to be read by the host */
+		if (data[RTC_SEC] & DA9062AA_RTC_READ_MASK) {
+			timeout = 0;
+			read_done = true;
+		}
+
+		msleep(20);
+	}
+
+	if (!read_done) {
+		dev_err(dev, "Failed to read the RTC time\n");
+		return -EIO;
+	}
+
+	da9062_data_to_tm(data, tm);
+
+	rtc_tm_to_time(tm, &tm_secs);
+	rtc_tm_to_time(&rtc->alarm_time, &al_secs);
+
+	/* handle the rtc synchronisation delay */
+	if (rtc->rtc_sync == true && al_secs - tm_secs == 1)
+		memcpy(tm, &rtc->alarm_time, sizeof(struct rtc_time));
+	else
+		rtc->rtc_sync = false;
+
+	return rtc_valid_tm(tm);
+}
+
+static int da9062_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct da9062_rtc *rtc = dev_get_drvdata(dev);
+	u8 data[RTC_DATA_LEN];
+	int ret;
+
+	da9062_tm_to_data(tm, data);
+	ret = regmap_bulk_write(rtc->hw->regmap, DA9062AA_COUNT_S,
+				data, RTC_DATA_LEN);
+	if (ret < 0)
+		dev_err(dev, "Failed to set RTC time data: %d\n", ret);
+
+	return ret;
+}
+
+static int da9062_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct da9062_rtc *rtc = dev_get_drvdata(dev);
+	u8 data[RTC_DATA_LEN];
+	int ret;
+	unsigned int val;
+
+	data[RTC_SEC] = 0;
+	ret = regmap_bulk_read(rtc->hw->regmap, DA9062AA_ALARM_S,
+			       &data[RTC_SEC], RTC_DATA_LEN);
+	if (ret < 0)
+		return ret;
+
+	da9062_data_to_tm(data, &alrm->time);
+
+	alrm->enabled = !!(data[RTC_YEAR] & DA9062AA_ALARM_ON_MASK);
+
+	ret = regmap_read(rtc->hw->regmap, DA9062AA_EVENT_A, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val & DA9062AA_M_ALARM_MASK)
+		alrm->pending = 1;
+	else
+		alrm->pending = 0;
+
+	return 0;
+}
+
+static int da9062_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct da9062_rtc *rtc = dev_get_drvdata(dev);
+	u8 data[RTC_DATA_LEN];
+	int ret;
+
+	da9062_tm_to_data(&alrm->time, data);
+
+	ret = da9062_rtc_stop_alarm(dev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to stop alarm: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_write(rtc->hw->regmap, DA9062AA_ALARM_S,
+			       &data[RTC_SEC], RTC_DATA_LEN);
+	if (ret < 0) {
+		dev_err(dev, "Failed to write alarm: %d\n", ret);
+		return ret;
+	}
+
+	da9062_data_to_tm(data, &rtc->alarm_time);
+
+	if (alrm->enabled) {
+		ret = da9062_rtc_start_alarm(dev);
+		if (ret < 0) {
+			dev_err(dev, "Failed to start alarm: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int da9062_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	if (enabled)
+		return da9062_rtc_start_alarm(dev);
+	else
+		return da9062_rtc_stop_alarm(dev);
+}
+
+static irqreturn_t da9062_alarm_event(int irq, void *data)
+{
+	struct da9062_rtc *rtc = data;
+
+	regmap_update_bits(rtc->hw->regmap,
+			   DA9062AA_ALARM_Y,
+			   DA9062AA_ALARM_ON_MASK,
+			   0);
+
+	rtc->rtc_sync = true;
+	rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
+
+	return IRQ_HANDLED;
+}
+
+static const struct rtc_class_ops da9062_rtc_ops = {
+	.read_time = da9062_rtc_read_time,
+	.set_time = da9062_rtc_set_time,
+	.read_alarm = da9062_rtc_read_alarm,
+	.set_alarm = da9062_rtc_set_alarm,
+	.alarm_irq_enable = da9062_rtc_alarm_irq_enable,
+};
+
+static int da9062_rtc_probe(struct platform_device *pdev)
+{
+	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
+	struct da9062_rtc *rtc;
+	int irq_alarm;
+	u8 data[RTC_DATA_LEN];
+	int ret;
+
+	ret = regmap_update_bits(chip->regmap,
+				 DA9062AA_CONTROL_E,
+				 DA9062AA_RTC_EN_MASK,
+				 DA9062AA_RTC_EN_MASK);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to enable RTC\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(chip->regmap,
+				 DA9062AA_EN_32K,
+				 DA9062AA_CRYSTAL_MASK,
+				 DA9062AA_CRYSTAL_MASK);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to run 32kHz oscillator\n");
+		return ret;
+	}
+
+	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
+	if (!rtc)
+		return -ENOMEM;
+
+	ret = regmap_update_bits(chip->regmap,
+				 DA9062AA_ALARM_S,
+				 DA9062AA_ALARM_STATUS_MASK,
+				 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(chip->regmap,
+				 DA9062AA_ALARM_S,
+				 DA9062AA_ALARM_STATUS_ENUM_TIMER,
+				 DA9062AA_ALARM_STATUS_ENUM_TIMER);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(chip->regmap,
+				 DA9062AA_ALARM_Y,
+				 DA9062AA_TICK_ON_MASK,
+				 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to disable TICKs\n");
+		return ret;
+	}
+
+	data[RTC_SEC] = 0;
+	ret = regmap_bulk_read(chip->regmap, DA9062AA_ALARM_S,
+			       &data[RTC_SEC], RTC_DATA_LEN);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to read initial alarm data: %d\n",
+			ret);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, rtc);
+
+	irq_alarm = platform_get_irq_byname(pdev, "ALARM");
+	ret = devm_request_threaded_irq(&pdev->dev, irq_alarm, NULL,
+					da9062_alarm_event,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					"ALARM", rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
+			irq_alarm, ret);
+		return ret;
+	}
+
+	rtc->hw = chip;
+	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, "da9062-rtc",
+					   &da9062_rtc_ops, THIS_MODULE);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
+
+	da9062_data_to_tm(data, &rtc->alarm_time);
+	rtc->rtc_sync = false;
+	return ret;
+}
+
+static struct platform_driver da9062_rtc_driver = {
+	.probe		= da9062_rtc_probe,
+	.driver		= {
+		.name	= "da9062-rtc",
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(da9062_rtc_driver);
+
+MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
+MODULE_DESCRIPTION("RTC device driver for Dialog DA9062");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform: da9062-rtc");
-- 
end-of-patch for PATCH V1
