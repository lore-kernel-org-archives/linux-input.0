From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V3 3/3] rtc: da9063: Add DA9062 RTC capability to DA9063 RTC
 driver
Date: Tue, 21 Jul 2015 11:29:07 +0100
Message-ID: <b79c0b5d1b96bd06ab81a2459c493e68ec6b1971.1437474547.git.stwiss.opensource@diasemi.com>
References: <cover.1437474547.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437474547.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, DEVICETREE <devicetree@vger.kernel.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, RTCLINUX <rtc-linux@googlegroups.com>, S Twiss <stwiss.opensource@diasemi.com>
Cc: David Dajun Chen <david.chen@diasemi.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: S Twiss <stwiss.opensource@diasemi.com>

Add DA9062 RTC support into the existing DA9063 RTC driver component by
using generic access tables for common register and bit mask definitions.

The following change will add generic register and bit mask support to the
DA9063 RTC. The changes are slightly complicated by requiring support for
three register sets: DA9063-AD, DA9063-BB and DA9062-AA.

The following alterations have been made to the DA9063 RTC:

- Addition of a da9063_compatible_rtc_regmap structure to hold all generic
  registers and bitmasks for this type of RTC component.
- A re-write of struct da9063 to use pointers for regmap and compatible
  registers/masks definitions
- Addition of a of_device_id table for DA9063 and DA9062 defaults
- Refactoring functions to use struct da9063_compatible_rtc accesses to
  generic registers/masks instead of using defines from registers.h
- Re-work of da9063_rtc_probe() to use of_match_node() and dev_get_regmap()
  to provide initialisation of generic registers and masks and access to
  regmap

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Checks performed with linux-next/next-20150708/scripts/checkpatch.pl
 Kconfig                   total: 0 errors, 15 warnings, 1600 lines checked
 rtc-da9063.c              total: 0 errors, 0 warnings, 519 lines checked

Changes in V3:
 - Revert MODULE_LICENSE("GPL v2") in the license change
 - Remove the need for an else branch and make rtc->config = match->data
   explicitly assign BB silicon by default.
 - Remove extra brackets in if (val & (config->rtc_event_alarm_mask))
Changes in V2:
 - Remove the re-try when reading the RTC inside da9063_rtc_read_time()
 - Revert the copyright header change
 - Remove strncmp in favour of of_device_is_compatible()
 - Do not check for NULL struct of_device_id * return from of_match_node()
 - Make a check for the existance of pdev->dev.of_node

This patch applies against linux-next and next-20150708 


 drivers/rtc/Kconfig      |   6 +-
 drivers/rtc/rtc-da9063.c | 391 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 282 insertions(+), 115 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 83b4b89..1eaa268 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -945,11 +945,11 @@ config RTC_DRV_DA9055
 	  will be called rtc-da9055
 
 config RTC_DRV_DA9063
-	tristate "Dialog Semiconductor DA9063 RTC"
-	depends on MFD_DA9063
+	tristate "Dialog Semiconductor DA9063/DA9062 RTC"
+	depends on MFD_DA9063 || MFD_DA9062
 	help
 	  If you say yes here you will get support for the RTC subsystem
-	  of the Dialog Semiconductor DA9063.
+	  for the Dialog Semiconductor PMIC chips DA9063 and DA9062.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called "rtc-da9063".
diff --git a/drivers/rtc/rtc-da9063.c b/drivers/rtc/rtc-da9063.c
index 7ffc570..5f38a5c 100644
--- a/drivers/rtc/rtc-da9063.c
+++ b/drivers/rtc/rtc-da9063.c
@@ -12,15 +12,18 @@
  * Library General Public License for more details.
  */
 
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/interrupt.h>
+#include <linux/regmap.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/regmap.h>
+
+#include <linux/mfd/da9062/registers.h>
 #include <linux/mfd/da9063/registers.h>
 #include <linux/mfd/da9063/core.h>
 
@@ -29,99 +32,230 @@
 #define YEARS_FROM_DA9063(year)		((year) + 100)
 #define MONTHS_FROM_DA9063(month)	((month) - 1)
 
-#define RTC_ALARM_DATA_LEN (DA9063_AD_REG_ALARM_Y - DA9063_AD_REG_ALARM_MI + 1)
-
-#define RTC_DATA_LEN	(DA9063_REG_COUNT_Y - DA9063_REG_COUNT_S + 1)
-#define RTC_SEC		0
-#define RTC_MIN		1
-#define RTC_HOUR	2
-#define RTC_DAY		3
-#define RTC_MONTH	4
-#define RTC_YEAR	5
-
-struct da9063_rtc {
-	struct rtc_device	*rtc_dev;
-	struct da9063		*hw;
-	struct rtc_time		alarm_time;
-	bool			rtc_sync;
-	int			alarm_year;
-	int			alarm_start;
-	int			alarm_len;
-	int			data_start;
+enum {
+	RTC_SEC	= 0,
+	RTC_MIN	= 1,
+	RTC_HOUR = 2,
+	RTC_DAY	= 3,
+	RTC_MONTH = 4,
+	RTC_YEAR = 5,
+	RTC_DATA_LEN
+};
+
+struct da9063_compatible_rtc_regmap {
+	/* REGS */
+	int rtc_enable_reg;
+	int rtc_enable_32k_crystal_reg;
+	int rtc_alarm_secs_reg;
+	int rtc_alarm_year_reg;
+	int rtc_count_secs_reg;
+	int rtc_count_year_reg;
+	int rtc_event_reg;
+	/* MASKS */
+	int rtc_enable_mask;
+	int rtc_crystal_mask;
+	int rtc_event_alarm_mask;
+	int rtc_alarm_on_mask;
+	int rtc_alarm_status_mask;
+	int rtc_tick_on_mask;
+	int rtc_ready_to_read_mask;
+	int rtc_count_sec_mask;
+	int rtc_count_min_mask;
+	int rtc_count_hour_mask;
+	int rtc_count_day_mask;
+	int rtc_count_month_mask;
+	int rtc_count_year_mask;
+	/* ALARM CONFIG */
+	int rtc_data_start;
+	int rtc_alarm_len;
+};
+
+struct da9063_compatible_rtc {
+	struct rtc_device *rtc_dev;
+	struct rtc_time alarm_time;
+	struct regmap *regmap;
+	const struct da9063_compatible_rtc_regmap *config;
+	bool rtc_sync;
+};
+
+static const struct da9063_compatible_rtc_regmap da9063_ad_regs = {
+	/* REGS */
+	.rtc_enable_reg             = DA9063_REG_CONTROL_E,
+	.rtc_alarm_secs_reg         = DA9063_AD_REG_ALARM_MI,
+	.rtc_alarm_year_reg         = DA9063_AD_REG_ALARM_Y,
+	.rtc_count_secs_reg         = DA9063_REG_COUNT_S,
+	.rtc_count_year_reg         = DA9063_REG_COUNT_Y,
+	.rtc_event_reg              = DA9063_REG_EVENT_A,
+	/* MASKS */
+	.rtc_enable_mask            = DA9063_RTC_EN,
+	.rtc_crystal_mask           = DA9063_CRYSTAL,
+	.rtc_enable_32k_crystal_reg = DA9063_REG_EN_32K,
+	.rtc_event_alarm_mask       = DA9063_E_ALARM,
+	.rtc_alarm_on_mask          = DA9063_ALARM_ON,
+	.rtc_alarm_status_mask      = DA9063_ALARM_STATUS_ALARM |
+				      DA9063_ALARM_STATUS_TICK,
+	.rtc_tick_on_mask           = DA9063_TICK_ON,
+	.rtc_ready_to_read_mask     = DA9063_RTC_READ,
+	.rtc_count_sec_mask         = DA9063_COUNT_SEC_MASK,
+	.rtc_count_min_mask         = DA9063_COUNT_MIN_MASK,
+	.rtc_count_hour_mask        = DA9063_COUNT_HOUR_MASK,
+	.rtc_count_day_mask         = DA9063_COUNT_DAY_MASK,
+	.rtc_count_month_mask       = DA9063_COUNT_MONTH_MASK,
+	.rtc_count_year_mask        = DA9063_COUNT_YEAR_MASK,
+	/* ALARM CONFIG */
+	.rtc_data_start             = RTC_MIN,
+	.rtc_alarm_len              = RTC_DATA_LEN - 1,
+};
+
+static const struct da9063_compatible_rtc_regmap da9063_bb_regs = {
+	/* REGS */
+	.rtc_enable_reg             = DA9063_REG_CONTROL_E,
+	.rtc_alarm_secs_reg         = DA9063_BB_REG_ALARM_S,
+	.rtc_alarm_year_reg         = DA9063_BB_REG_ALARM_Y,
+	.rtc_count_secs_reg         = DA9063_REG_COUNT_S,
+	.rtc_count_year_reg         = DA9063_REG_COUNT_Y,
+	.rtc_event_reg              = DA9063_REG_EVENT_A,
+	/* MASKS */
+	.rtc_enable_mask            = DA9063_RTC_EN,
+	.rtc_crystal_mask           = DA9063_CRYSTAL,
+	.rtc_enable_32k_crystal_reg = DA9063_REG_EN_32K,
+	.rtc_event_alarm_mask       = DA9063_E_ALARM,
+	.rtc_alarm_on_mask          = DA9063_ALARM_ON,
+	.rtc_alarm_status_mask      = DA9063_ALARM_STATUS_ALARM |
+				      DA9063_ALARM_STATUS_TICK,
+	.rtc_tick_on_mask           = DA9063_TICK_ON,
+	.rtc_ready_to_read_mask     = DA9063_RTC_READ,
+	.rtc_count_sec_mask         = DA9063_COUNT_SEC_MASK,
+	.rtc_count_min_mask         = DA9063_COUNT_MIN_MASK,
+	.rtc_count_hour_mask        = DA9063_COUNT_HOUR_MASK,
+	.rtc_count_day_mask         = DA9063_COUNT_DAY_MASK,
+	.rtc_count_month_mask       = DA9063_COUNT_MONTH_MASK,
+	.rtc_count_year_mask        = DA9063_COUNT_YEAR_MASK,
+	/* ALARM CONFIG */
+	.rtc_data_start             = RTC_SEC,
+	.rtc_alarm_len              = RTC_DATA_LEN,
+};
+
+static const struct da9063_compatible_rtc_regmap da9062_aa_regs = {
+	/* REGS */
+	.rtc_enable_reg             = DA9062AA_CONTROL_E,
+	.rtc_alarm_secs_reg         = DA9062AA_ALARM_S,
+	.rtc_alarm_year_reg         = DA9062AA_ALARM_Y,
+	.rtc_count_secs_reg         = DA9062AA_COUNT_S,
+	.rtc_count_year_reg         = DA9062AA_COUNT_Y,
+	.rtc_event_reg              = DA9062AA_EVENT_A,
+	/* MASKS */
+	.rtc_enable_mask            = DA9062AA_RTC_EN_MASK,
+	.rtc_crystal_mask           = DA9062AA_CRYSTAL_MASK,
+	.rtc_enable_32k_crystal_reg = DA9062AA_EN_32K,
+	.rtc_event_alarm_mask       = DA9062AA_M_ALARM_MASK,
+	.rtc_alarm_on_mask          = DA9062AA_ALARM_ON_MASK,
+	.rtc_alarm_status_mask      = (0x02 << 6),
+	.rtc_tick_on_mask           = DA9062AA_TICK_ON_MASK,
+	.rtc_ready_to_read_mask     = DA9062AA_RTC_READ_MASK,
+	.rtc_count_sec_mask         = DA9062AA_COUNT_SEC_MASK,
+	.rtc_count_min_mask         = DA9062AA_COUNT_MIN_MASK,
+	.rtc_count_hour_mask        = DA9062AA_COUNT_HOUR_MASK,
+	.rtc_count_day_mask         = DA9062AA_COUNT_DAY_MASK,
+	.rtc_count_month_mask       = DA9062AA_COUNT_MONTH_MASK,
+	.rtc_count_year_mask        = DA9062AA_COUNT_YEAR_MASK,
+	/* ALARM CONFIG */
+	.rtc_data_start             = RTC_SEC,
+	.rtc_alarm_len              = RTC_DATA_LEN,
+};
+
+static const struct of_device_id da9063_compatible_reg_id_table[] = {
+	{ .compatible = "dlg,da9063-rtc", .data = &da9063_bb_regs },
+	{ .compatible = "dlg,da9062-rtc", .data = &da9062_aa_regs },
+	{ },
 };
 
-static void da9063_data_to_tm(u8 *data, struct rtc_time *tm)
+static void da9063_data_to_tm(u8 *data, struct rtc_time *tm,
+			      struct da9063_compatible_rtc *rtc)
 {
-	tm->tm_sec  = data[RTC_SEC]  & DA9063_COUNT_SEC_MASK;
-	tm->tm_min  = data[RTC_MIN]  & DA9063_COUNT_MIN_MASK;
-	tm->tm_hour = data[RTC_HOUR] & DA9063_COUNT_HOUR_MASK;
-	tm->tm_mday = data[RTC_DAY]  & DA9063_COUNT_DAY_MASK;
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
+
+	tm->tm_sec  = data[RTC_SEC]  & config->rtc_count_sec_mask;
+	tm->tm_min  = data[RTC_MIN]  & config->rtc_count_min_mask;
+	tm->tm_hour = data[RTC_HOUR] & config->rtc_count_hour_mask;
+	tm->tm_mday = data[RTC_DAY]  & config->rtc_count_day_mask;
 	tm->tm_mon  = MONTHS_FROM_DA9063(data[RTC_MONTH] &
-					 DA9063_COUNT_MONTH_MASK);
+					 config->rtc_count_month_mask);
 	tm->tm_year = YEARS_FROM_DA9063(data[RTC_YEAR] &
-					DA9063_COUNT_YEAR_MASK);
+					config->rtc_count_year_mask);
 }
 
-static void da9063_tm_to_data(struct rtc_time *tm, u8 *data)
+static void da9063_tm_to_data(struct rtc_time *tm, u8 *data,
+			      struct da9063_compatible_rtc *rtc)
 {
-	data[RTC_SEC] &= ~DA9063_COUNT_SEC_MASK;
-	data[RTC_SEC] |= tm->tm_sec & DA9063_COUNT_SEC_MASK;
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
+
+	data[RTC_SEC] &= ~config->rtc_count_sec_mask;
+	data[RTC_SEC] |= tm->tm_sec & config->rtc_count_sec_mask;
 
-	data[RTC_MIN] &= ~DA9063_COUNT_MIN_MASK;
-	data[RTC_MIN] |= tm->tm_min & DA9063_COUNT_MIN_MASK;
+	data[RTC_MIN] &= ~config->rtc_count_min_mask;
+	data[RTC_MIN] |= tm->tm_min & config->rtc_count_min_mask;
 
-	data[RTC_HOUR] &= ~DA9063_COUNT_HOUR_MASK;
-	data[RTC_HOUR] |= tm->tm_hour & DA9063_COUNT_HOUR_MASK;
+	data[RTC_HOUR] &= ~config->rtc_count_hour_mask;
+	data[RTC_HOUR] |= tm->tm_hour & config->rtc_count_hour_mask;
 
-	data[RTC_DAY] &= ~DA9063_COUNT_DAY_MASK;
-	data[RTC_DAY] |= tm->tm_mday & DA9063_COUNT_DAY_MASK;
+	data[RTC_DAY] &= ~config->rtc_count_day_mask;
+	data[RTC_DAY] |= tm->tm_mday & config->rtc_count_day_mask;
 
-	data[RTC_MONTH] &= ~DA9063_COUNT_MONTH_MASK;
+	data[RTC_MONTH] &= ~config->rtc_count_month_mask;
 	data[RTC_MONTH] |= MONTHS_TO_DA9063(tm->tm_mon) &
-				DA9063_COUNT_MONTH_MASK;
+				config->rtc_count_month_mask;
 
-	data[RTC_YEAR] &= ~DA9063_COUNT_YEAR_MASK;
+	data[RTC_YEAR] &= ~config->rtc_count_year_mask;
 	data[RTC_YEAR] |= YEARS_TO_DA9063(tm->tm_year) &
-				DA9063_COUNT_YEAR_MASK;
+				config->rtc_count_year_mask;
 }
 
 static int da9063_rtc_stop_alarm(struct device *dev)
 {
-	struct da9063_rtc *rtc = dev_get_drvdata(dev);
+	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 
-	return regmap_update_bits(rtc->hw->regmap, rtc->alarm_year,
-				  DA9063_ALARM_ON, 0);
+	return regmap_update_bits(rtc->regmap,
+				  config->rtc_alarm_year_reg,
+				  config->rtc_alarm_on_mask,
+				  0);
 }
 
 static int da9063_rtc_start_alarm(struct device *dev)
 {
-	struct da9063_rtc *rtc = dev_get_drvdata(dev);
+	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 
-	return regmap_update_bits(rtc->hw->regmap, rtc->alarm_year,
-				  DA9063_ALARM_ON, DA9063_ALARM_ON);
+	return regmap_update_bits(rtc->regmap,
+				  config->rtc_alarm_year_reg,
+				  config->rtc_alarm_on_mask,
+				  config->rtc_alarm_on_mask);
 }
 
 static int da9063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct da9063_rtc *rtc = dev_get_drvdata(dev);
+	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 	unsigned long tm_secs;
 	unsigned long al_secs;
 	u8 data[RTC_DATA_LEN];
 	int ret;
 
-	ret = regmap_bulk_read(rtc->hw->regmap, DA9063_REG_COUNT_S,
+	ret = regmap_bulk_read(rtc->regmap,
+			       config->rtc_count_secs_reg,
 			       data, RTC_DATA_LEN);
 	if (ret < 0) {
 		dev_err(dev, "Failed to read RTC time data: %d\n", ret);
 		return ret;
 	}
 
-	if (!(data[RTC_SEC] & DA9063_RTC_READ)) {
+	if (!(data[RTC_SEC] & config->rtc_ready_to_read_mask)) {
 		dev_dbg(dev, "RTC not yet ready to be read by the host\n");
 		return -EINVAL;
 	}
 
-	da9063_data_to_tm(data, tm);
+	da9063_data_to_tm(data, tm, rtc);
 
 	rtc_tm_to_time(tm, &tm_secs);
 	rtc_tm_to_time(&rtc->alarm_time, &al_secs);
@@ -137,12 +271,14 @@ static int da9063_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 static int da9063_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct da9063_rtc *rtc = dev_get_drvdata(dev);
+	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 	u8 data[RTC_DATA_LEN];
 	int ret;
 
-	da9063_tm_to_data(tm, data);
-	ret = regmap_bulk_write(rtc->hw->regmap, DA9063_REG_COUNT_S,
+	da9063_tm_to_data(tm, data, rtc);
+	ret = regmap_bulk_write(rtc->regmap,
+				config->rtc_count_secs_reg,
 				data, RTC_DATA_LEN);
 	if (ret < 0)
 		dev_err(dev, "Failed to set RTC time data: %d\n", ret);
@@ -152,26 +288,31 @@ static int da9063_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 static int da9063_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct da9063_rtc *rtc = dev_get_drvdata(dev);
+	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 	u8 data[RTC_DATA_LEN];
 	int ret;
 	unsigned int val;
 
 	data[RTC_SEC] = 0;
-	ret = regmap_bulk_read(rtc->hw->regmap, rtc->alarm_start,
-			       &data[rtc->data_start], rtc->alarm_len);
+	ret = regmap_bulk_read(rtc->regmap,
+			       config->rtc_alarm_secs_reg,
+			       &data[config->rtc_data_start],
+			       config->rtc_alarm_len);
 	if (ret < 0)
 		return ret;
 
-	da9063_data_to_tm(data, &alrm->time);
+	da9063_data_to_tm(data, &alrm->time, rtc);
 
-	alrm->enabled = !!(data[RTC_YEAR] & DA9063_ALARM_ON);
+	alrm->enabled = !!(data[RTC_YEAR] & config->rtc_alarm_on_mask);
 
-	ret = regmap_read(rtc->hw->regmap, DA9063_REG_EVENT_A, &val);
+	ret = regmap_read(rtc->regmap,
+			  config->rtc_event_reg,
+			  &val);
 	if (ret < 0)
 		return ret;
 
-	if (val & (DA9063_E_ALARM))
+	if (val & config->rtc_event_alarm_mask)
 		alrm->pending = 1;
 	else
 		alrm->pending = 0;
@@ -181,11 +322,12 @@ static int da9063_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int da9063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct da9063_rtc *rtc = dev_get_drvdata(dev);
+	struct da9063_compatible_rtc *rtc = dev_get_drvdata(dev);
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 	u8 data[RTC_DATA_LEN];
 	int ret;
 
-	da9063_tm_to_data(&alrm->time, data);
+	da9063_tm_to_data(&alrm->time, data, rtc);
 
 	ret = da9063_rtc_stop_alarm(dev);
 	if (ret < 0) {
@@ -193,14 +335,16 @@ static int da9063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 		return ret;
 	}
 
-	ret = regmap_bulk_write(rtc->hw->regmap, rtc->alarm_start,
-			       &data[rtc->data_start], rtc->alarm_len);
+	ret = regmap_bulk_write(rtc->regmap,
+				config->rtc_alarm_secs_reg,
+				&data[config->rtc_data_start],
+				config->rtc_alarm_len);
 	if (ret < 0) {
 		dev_err(dev, "Failed to write alarm: %d\n", ret);
 		return ret;
 	}
 
-	da9063_data_to_tm(data, &rtc->alarm_time);
+	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
 
 	if (alrm->enabled) {
 		ret = da9063_rtc_start_alarm(dev);
@@ -213,7 +357,8 @@ static int da9063_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	return ret;
 }
 
-static int da9063_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+static int da9063_rtc_alarm_irq_enable(struct device *dev,
+				       unsigned int enabled)
 {
 	if (enabled)
 		return da9063_rtc_start_alarm(dev);
@@ -223,10 +368,13 @@ static int da9063_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
 
 static irqreturn_t da9063_alarm_event(int irq, void *data)
 {
-	struct da9063_rtc *rtc = data;
+	struct da9063_compatible_rtc *rtc = data;
+	const struct da9063_compatible_rtc_regmap *config = rtc->config;
 
-	regmap_update_bits(rtc->hw->regmap, rtc->alarm_year,
-			   DA9063_ALARM_ON, 0);
+	regmap_update_bits(rtc->regmap,
+			   config->rtc_alarm_year_reg,
+			   config->rtc_alarm_on_mask,
+			   0);
 
 	rtc->rtc_sync = true;
 	rtc_update_irq(rtc->rtc_dev, 1, RTC_IRQF | RTC_AF);
@@ -244,72 +392,92 @@ static const struct rtc_class_ops da9063_rtc_ops = {
 
 static int da9063_rtc_probe(struct platform_device *pdev)
 {
-	struct da9063 *da9063 = dev_get_drvdata(pdev->dev.parent);
-	struct da9063_rtc *rtc;
+	struct da9063_compatible_rtc *rtc;
+	const struct da9063_compatible_rtc_regmap *config;
+	const struct of_device_id *match;
 	int irq_alarm;
 	u8 data[RTC_DATA_LEN];
 	int ret;
 
-	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_E,
-				 DA9063_RTC_EN, DA9063_RTC_EN);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to enable RTC\n");
-		goto err;
-	}
+	if (!pdev->dev.of_node)
+		return -ENXIO;
 
-	ret = regmap_update_bits(da9063->regmap, DA9063_REG_EN_32K,
-				 DA9063_CRYSTAL, DA9063_CRYSTAL);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to run 32kHz oscillator\n");
-		goto err;
-	}
+	match = of_match_node(da9063_compatible_reg_id_table,
+			      pdev->dev.of_node);
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
 		return -ENOMEM;
 
-	if (da9063->variant_code == PMIC_DA9063_AD) {
-		rtc->alarm_year = DA9063_AD_REG_ALARM_Y;
-		rtc->alarm_start = DA9063_AD_REG_ALARM_MI;
-		rtc->alarm_len = RTC_ALARM_DATA_LEN;
-		rtc->data_start = RTC_MIN;
-	} else {
-		rtc->alarm_year = DA9063_BB_REG_ALARM_Y;
-		rtc->alarm_start = DA9063_BB_REG_ALARM_S;
-		rtc->alarm_len = RTC_DATA_LEN;
-		rtc->data_start = RTC_SEC;
+	rtc->config = match->data;
+	if (of_device_is_compatible(pdev->dev.of_node, "dlg,da9063-rtc")) {
+		struct da9063 *chip = dev_get_drvdata(pdev->dev.parent);
+
+		if (chip->variant_code == PMIC_DA9063_AD)
+			rtc->config = &da9063_ad_regs;
 	}
 
-	ret = regmap_update_bits(da9063->regmap, rtc->alarm_start,
-			DA9063_ALARM_STATUS_TICK | DA9063_ALARM_STATUS_ALARM,
-			0);
+	rtc->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!rtc->regmap) {
+		dev_warn(&pdev->dev, "Parent regmap unavailable.\n");
+		return -ENXIO;
+	}
+
+	config = rtc->config;
+	ret = regmap_update_bits(rtc->regmap,
+				 config->rtc_enable_reg,
+				 config->rtc_enable_mask,
+				 config->rtc_enable_mask);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to enable RTC\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(rtc->regmap,
+				 config->rtc_enable_32k_crystal_reg,
+				 config->rtc_crystal_mask,
+				 config->rtc_crystal_mask);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to run 32kHz oscillator\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(rtc->regmap,
+				 config->rtc_alarm_secs_reg,
+				 config->rtc_alarm_status_mask,
+				 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
-		goto err;
+		return ret;
 	}
 
-	ret = regmap_update_bits(da9063->regmap, rtc->alarm_start,
+	ret = regmap_update_bits(rtc->regmap,
+				 config->rtc_alarm_secs_reg,
 				 DA9063_ALARM_STATUS_ALARM,
 				 DA9063_ALARM_STATUS_ALARM);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to access RTC alarm register\n");
-		goto err;
+		return ret;
 	}
 
-	ret = regmap_update_bits(da9063->regmap, rtc->alarm_year,
-				 DA9063_TICK_ON, 0);
+	ret = regmap_update_bits(rtc->regmap,
+				 config->rtc_alarm_year_reg,
+				 config->rtc_tick_on_mask,
+				 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to disable TICKs\n");
-		goto err;
+		return ret;
 	}
 
 	data[RTC_SEC] = 0;
-	ret = regmap_bulk_read(da9063->regmap, rtc->alarm_start,
-			       &data[rtc->data_start], rtc->alarm_len);
+	ret = regmap_bulk_read(rtc->regmap,
+			       config->rtc_alarm_secs_reg,
+			       &data[config->rtc_data_start],
+			       config->rtc_alarm_len);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to read initial alarm data: %d\n",
 			ret);
-		goto err;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, rtc);
@@ -322,18 +490,16 @@ static int da9063_rtc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request ALARM IRQ %d: %d\n",
 			irq_alarm, ret);
-		goto err;
+		return ret;
 	}
 
-	rtc->hw = da9063;
 	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, DA9063_DRVNAME_RTC,
 					   &da9063_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev))
 		return PTR_ERR(rtc->rtc_dev);
 
-	da9063_data_to_tm(data, &rtc->alarm_time);
+	da9063_data_to_tm(data, &rtc->alarm_time, rtc);
 	rtc->rtc_sync = false;
-err:
 	return ret;
 }
 
@@ -341,6 +507,7 @@ static struct platform_driver da9063_rtc_driver = {
 	.probe		= da9063_rtc_probe,
 	.driver		= {
 		.name	= DA9063_DRVNAME_RTC,
+		.of_match_table = da9063_compatible_reg_id_table,
 	},
 };
 
-- 
end-of-patch for PATCH V3
