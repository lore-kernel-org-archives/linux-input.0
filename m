From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH V7 1/4] mfd: support 88pm80x in 80x driver
Date: Tue, 10 Jul 2012 17:17:35 +0800
Message-ID: <1341911858-10851-2-git-send-email-zhouqiao@marvell.com>
References: <1341911858-10851-1-git-send-email-zhouqiao@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:49384 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753274Ab2GJJRy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 05:17:54 -0400
In-Reply-To: <1341911858-10851-1-git-send-email-zhouqiao@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org
Cc: Qiao Zhou <zhouqiao@marvell.com>

88PM800 and 88PM805 are two discrete chips used for power management.
Hardware designer can use them together or only one of them according
to requirement.

88pm80x.c provides common i2c driver handling for both 800 and
805, such as i2c_driver init, regmap init, read/write api etc.

88pm800.c handles specifically for 800, such as chip init, irq
init/handle, mfd device register, including rtc, onkey, regulator(
to be add later) etc. besides that, 800 has three i2c device, one
regular i2c client, two other i2c dummy for gpadc and power purpose.

88pm805.c handles specifically for 805, such as chip init, irq
init/handle, mfd device register, including codec, headset/mic detect
etc.

the i2c operation of both 800 and 805 are via regmap, and 88pm80x-i2c
exported a group of r/w bulk r/w and bits set API for facility.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/88pm800.c       |  594 +++++++++++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm805.c       |  300 ++++++++++++++++++++++
 drivers/mfd/88pm80x.c       |  117 +++++++++
 drivers/mfd/Kconfig         |   24 ++
 drivers/mfd/Makefile        |    2 +
 include/linux/mfd/88pm80x.h |  368 ++++++++++++++++++++++++++
 6 files changed, 1405 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/88pm800.c
 create mode 100644 drivers/mfd/88pm805.c
 create mode 100644 drivers/mfd/88pm80x.c
 create mode 100644 include/linux/mfd/88pm80x.h

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
new file mode 100644
index 0000000..ec7d9b8
--- /dev/null
+++ b/drivers/mfd/88pm800.c
@@ -0,0 +1,594 @@
+/*
+ * Base driver for Marvell 88PM800
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Joseph(Yossi) Hanin <yhanin@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/slab.h>
+
+#define PM800_CHIP_ID			(0x00)
+
+/* Interrupt Registers */
+#define PM800_INT_STATUS1		(0x05)
+#define PM800_ONKEY_INT_STS1		(1 << 0)
+#define PM800_EXTON_INT_STS1		(1 << 1)
+#define PM800_CHG_INT_STS1			(1 << 2)
+#define PM800_BAT_INT_STS1			(1 << 3)
+#define PM800_RTC_INT_STS1			(1 << 4)
+#define PM800_CLASSD_OC_INT_STS1	(1 << 5)
+
+#define PM800_INT_STATUS2		(0x06)
+#define PM800_VBAT_INT_STS2		(1 << 0)
+#define PM800_VSYS_INT_STS2		(1 << 1)
+#define PM800_VCHG_INT_STS2		(1 << 2)
+#define PM800_TINT_INT_STS2		(1 << 3)
+#define PM800_GPADC0_INT_STS2	(1 << 4)
+#define PM800_TBAT_INT_STS2		(1 << 5)
+#define PM800_GPADC2_INT_STS2	(1 << 6)
+#define PM800_GPADC3_INT_STS2	(1 << 7)
+
+#define PM800_INT_STATUS3		(0x07)
+
+#define PM800_INT_STATUS4		(0x08)
+#define PM800_GPIO0_INT_STS4		(1 << 0)
+#define PM800_GPIO1_INT_STS4		(1 << 1)
+#define PM800_GPIO2_INT_STS4		(1 << 2)
+#define PM800_GPIO3_INT_STS4		(1 << 3)
+#define PM800_GPIO4_INT_STS4		(1 << 4)
+
+#define PM800_INT_ENA_1		(0x09)
+#define PM800_ONKEY_INT_ENA1		(1 << 0)
+#define PM800_EXTON_INT_ENA1		(1 << 1)
+#define PM800_CHG_INT_ENA1			(1 << 2)
+#define PM800_BAT_INT_ENA1			(1 << 3)
+#define PM800_RTC_INT_ENA1			(1 << 4)
+#define PM800_CLASSD_OC_INT_ENA1	(1 << 5)
+
+#define PM800_INT_ENA_2		(0x0A)
+#define PM800_VBAT_INT_ENA2		(1 << 0)
+#define PM800_VSYS_INT_ENA2		(1 << 1)
+#define PM800_VCHG_INT_ENA2		(1 << 2)
+#define PM800_TINT_INT_ENA2		(1 << 3)
+
+#define PM800_INT_ENA_3		(0x0B)
+#define PM800_GPADC0_INT_ENA3		(1 << 0)
+#define PM800_GPADC1_INT_ENA3		(1 << 1)
+#define PM800_GPADC2_INT_ENA3		(1 << 2)
+#define PM800_GPADC3_INT_ENA3		(1 << 3)
+#define PM800_GPADC4_INT_ENA3		(1 << 4)
+
+#define PM800_INT_ENA_4		(0x0C)
+#define PM800_GPIO0_INT_ENA4		(1 << 0)
+#define PM800_GPIO1_INT_ENA4		(1 << 1)
+#define PM800_GPIO2_INT_ENA4		(1 << 2)
+#define PM800_GPIO3_INT_ENA4		(1 << 3)
+#define PM800_GPIO4_INT_ENA4		(1 << 4)
+
+/* number of INT_ENA & INT_STATUS regs */
+#define PM800_INT_REG_NUM			(4)
+
+/* Interrupt Number in 88PM800 */
+enum {
+	PM800_IRQ_ONKEY,	/*EN1b0 *//*0 */
+	PM800_IRQ_EXTON,	/*EN1b1 */
+	PM800_IRQ_CHG,		/*EN1b2 */
+	PM800_IRQ_BAT,		/*EN1b3 */
+	PM800_IRQ_RTC,		/*EN1b4 */
+	PM800_IRQ_CLASSD,	/*EN1b5 *//*5 */
+	PM800_IRQ_VBAT,		/*EN2b0 */
+	PM800_IRQ_VSYS,		/*EN2b1 */
+	PM800_IRQ_VCHG,		/*EN2b2 */
+	PM800_IRQ_TINT,		/*EN2b3 */
+	PM800_IRQ_GPADC0,	/*EN3b0 *//*10 */
+	PM800_IRQ_GPADC1,	/*EN3b1 */
+	PM800_IRQ_GPADC2,	/*EN3b2 */
+	PM800_IRQ_GPADC3,	/*EN3b3 */
+	PM800_IRQ_GPADC4,	/*EN3b4 */
+	PM800_IRQ_GPIO0,	/*EN4b0 *//*15 */
+	PM800_IRQ_GPIO1,	/*EN4b1 */
+	PM800_IRQ_GPIO2,	/*EN4b2 */
+	PM800_IRQ_GPIO3,	/*EN4b3 */
+	PM800_IRQ_GPIO4,	/*EN4b4 *//*19 */
+	PM800_MAX_IRQ,
+};
+
+enum {
+	/* Procida */
+	PM800_CHIP_A0  = 0x60,
+	PM800_CHIP_A1  = 0x61,
+	PM800_CHIP_B0  = 0x62,
+	PM800_CHIP_C0  = 0x63,
+	PM800_CHIP_END = PM800_CHIP_C0,
+
+	/* Make sure to update this to the last stepping */
+	PM8XXX_CHIP_END = PM800_CHIP_END
+};
+
+static const struct i2c_device_id pm80x_id_table[] = {
+	{"88PM800", CHIP_PM800},
+	{} /* NULL terminated */
+};
+MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
+
+static struct resource rtc_resources[] = {
+	{
+	 .name = "88pm80x-rtc",
+	 .start = PM800_IRQ_RTC,
+	 .end = PM800_IRQ_RTC,
+	 .flags = IORESOURCE_IRQ,
+	 },
+};
+
+static struct mfd_cell rtc_devs[] = {
+	{
+	 .name = "88pm80x-rtc",
+	 .num_resources = ARRAY_SIZE(rtc_resources),
+	 .resources = &rtc_resources[0],
+	 .id = -1,
+	 },
+};
+
+static struct resource onkey_resources[] = {
+	{
+	 .name = "88pm80x-onkey",
+	 .start = PM800_IRQ_ONKEY,
+	 .end = PM800_IRQ_ONKEY,
+	 .flags = IORESOURCE_IRQ,
+	 },
+};
+
+static struct mfd_cell onkey_devs[] = {
+	{
+	 .name = "88pm80x-onkey",
+	 .num_resources = 1,
+	 .resources = &onkey_resources[0],
+	 .id = -1,
+	 },
+};
+
+static const struct regmap_irq pm800_irqs[] = {
+	/* INT0 */
+	[PM800_IRQ_ONKEY] = {
+		.mask = PM800_ONKEY_INT_ENA1,
+	},
+	[PM800_IRQ_EXTON] = {
+		.mask = PM800_EXTON_INT_ENA1,
+	},
+	[PM800_IRQ_CHG] = {
+		.mask = PM800_CHG_INT_ENA1,
+	},
+	[PM800_IRQ_BAT] = {
+		.mask = PM800_BAT_INT_ENA1,
+	},
+	[PM800_IRQ_RTC] = {
+		.mask = PM800_RTC_INT_ENA1,
+	},
+	[PM800_IRQ_CLASSD] = {
+		.mask = PM800_CLASSD_OC_INT_ENA1,
+	},
+	/* INT1 */
+	[PM800_IRQ_VBAT] = {
+		.reg_offset = 1,
+		.mask = PM800_VBAT_INT_ENA2,
+	},
+	[PM800_IRQ_VSYS] = {
+		.reg_offset = 1,
+		.mask = PM800_VSYS_INT_ENA2,
+	},
+	[PM800_IRQ_VCHG] = {
+		.reg_offset = 1,
+		.mask = PM800_VCHG_INT_ENA2,
+	},
+	[PM800_IRQ_TINT] = {
+		.reg_offset = 1,
+		.mask = PM800_TINT_INT_ENA2,
+	},
+	/* INT2 */
+	[PM800_IRQ_GPADC0] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC0_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC1] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC1_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC2] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC2_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC3] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC3_INT_ENA3,
+	},
+	[PM800_IRQ_GPADC4] = {
+		.reg_offset = 2,
+		.mask = PM800_GPADC4_INT_ENA3,
+	},
+	/* INT3 */
+	[PM800_IRQ_GPIO0] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO0_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO1] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO1_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO2] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO2_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO3] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO3_INT_ENA4,
+	},
+	[PM800_IRQ_GPIO4] = {
+		.reg_offset = 3,
+		.mask = PM800_GPIO4_INT_ENA4,
+	},
+};
+
+static int __devinit device_gpadc_init(struct pm80x_chip *chip,
+				       struct pm80x_platform_data *pdata)
+{
+	struct pm80x_subchip *subchip = chip->subchip;
+	struct regmap *map = subchip->regmap_gpadc;
+	int data = 0, mask = 0, ret = 0;
+
+	if (!map) {
+		dev_warn(chip->dev,
+			 "Warning: gpadc regmap is not available!\n");
+		return -EINVAL;
+	}
+	/*
+	 * initialize GPADC without activating it turn on GPADC
+	 * measurments
+	 */
+	ret = regmap_update_bits(map,
+				 PM800_GPADC_MISC_CONFIG2,
+				 PM800_GPADC_MISC_GPFSM_EN,
+				 PM800_GPADC_MISC_GPFSM_EN);
+	if (ret < 0)
+		goto out;
+	/*
+	 * This function configures the ADC as requires for
+	 * CP implementation.CP does not "own" the ADC configuration
+	 * registers and relies on AP.
+	 * Reason: enable automatic ADC measurements needed
+	 * for CP to get VBAT and RF temperature readings.
+	 */
+	ret = regmap_update_bits(map, PM800_GPADC_MEAS_EN1,
+				 PM800_MEAS_EN1_VBAT, PM800_MEAS_EN1_VBAT);
+	if (ret < 0)
+		goto out;
+	ret = regmap_update_bits(map, PM800_GPADC_MEAS_EN2,
+				 (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN),
+				 (PM800_MEAS_EN2_RFTMP | PM800_MEAS_GP0_EN));
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * the defult of PM800 is GPADC operates at 100Ks/s rate
+	 * and Number of GPADC slots with active current bias prior
+	 * to GPADC sampling = 1 slot for all GPADCs set for
+	 * Temprature mesurmants
+	 */
+	mask = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
+		PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
+
+	if (pdata && (pdata->batt_det == 0))
+		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN1 |
+			PM800_GPADC_GP_BIAS_EN2 | PM800_GPADC_GP_BIAS_EN3);
+	else
+		data = (PM800_GPADC_GP_BIAS_EN0 | PM800_GPADC_GP_BIAS_EN2 |
+			PM800_GPADC_GP_BIAS_EN3);
+
+	ret = regmap_update_bits(map, PM800_GP_BIAS_ENA1, mask, data);
+	if (ret < 0)
+		goto out;
+
+	dev_info(chip->dev, "pm800 device_gpadc_init: Done\n");
+	return 0;
+
+out:
+	dev_info(chip->dev, "pm800 device_gpadc_init: Failed!\n");
+	return ret;
+}
+
+static int __devinit device_irq_init_800(struct pm80x_chip *chip)
+{
+	struct regmap *map = chip->regmap;
+	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	int data, mask, ret = -EINVAL;
+
+	if (!map || !chip->irq) {
+		dev_err(chip->dev, "incorrect parameters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * irq_mode defines the way of clearing interrupt. it's read-clear by
+	 * default.
+	 */
+	mask =
+	    PM800_WAKEUP2_INV_INT | PM800_WAKEUP2_INT_CLEAR |
+	    PM800_WAKEUP2_INT_MASK;
+
+	data = PM800_WAKEUP2_INT_CLEAR;
+	ret = regmap_update_bits(map, PM800_WAKEUP2, mask, data);
+
+	if (ret < 0)
+		goto out;
+
+	ret =
+	    regmap_add_irq_chip(chip->regmap, chip->irq, flags, -1,
+				chip->regmap_irq_chip, &chip->irq_data);
+
+out:
+	return ret;
+}
+
+static void device_irq_exit_800(struct pm80x_chip *chip)
+{
+	regmap_del_irq_chip(chip->irq, chip->irq_data);
+}
+
+static struct regmap_irq_chip pm800_irq_chip = {
+	.name = "88pm800",
+	.irqs = pm800_irqs,
+	.num_irqs = ARRAY_SIZE(pm800_irqs),
+
+	.num_regs = 4,
+	.status_base = PM800_INT_STATUS1,
+	.mask_base = PM800_INT_ENA_1,
+	.ack_base = PM800_INT_STATUS1,
+};
+
+static int pm800_pages_init(struct pm80x_chip *chip)
+{
+	struct pm80x_subchip *subchip;
+	struct i2c_client *client = chip->client;
+
+	subchip = chip->subchip;
+	/* PM800 block power: i2c addr 0x31 */
+	if (subchip->power_page_addr) {
+		subchip->power_page =
+		    i2c_new_dummy(client->adapter, subchip->power_page_addr);
+		subchip->regmap_power =
+		    devm_regmap_init_i2c(subchip->power_page,
+					 &pm80x_regmap_config);
+		i2c_set_clientdata(subchip->power_page, chip);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block power 0x31: No power_page_addr\n");
+
+	/* PM800 block GPADC: i2c addr 0x32 */
+	if (subchip->gpadc_page_addr) {
+		subchip->gpadc_page = i2c_new_dummy(client->adapter,
+						    subchip->gpadc_page_addr);
+		subchip->regmap_gpadc =
+		    devm_regmap_init_i2c(subchip->gpadc_page,
+					 &pm80x_regmap_config);
+		i2c_set_clientdata(subchip->gpadc_page, chip);
+	} else
+		dev_info(chip->dev,
+			 "PM800 block GPADC 0x32: No gpadc_page_addr\n");
+
+	return 0;
+}
+
+static void pm800_pages_exit(struct pm80x_chip *chip)
+{
+	struct pm80x_subchip *subchip;
+
+	regmap_exit(chip->regmap);
+	i2c_unregister_device(chip->client);
+
+	subchip = chip->subchip;
+	if (subchip->power_page) {
+		regmap_exit(subchip->regmap_power);
+		i2c_unregister_device(subchip->power_page);
+	}
+	if (subchip->gpadc_page) {
+		regmap_exit(subchip->regmap_gpadc);
+		i2c_unregister_device(subchip->gpadc_page);
+	}
+}
+
+static int __devinit device_800_init(struct pm80x_chip *chip,
+				     struct pm80x_platform_data *pdata)
+{
+	int ret, pmic_id;
+
+	regmap_read(chip->regmap, PM800_CHIP_ID, &ret);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out;
+	}
+
+	pmic_id = ret & PM80X_VERSION_MASK;
+
+	if ((pmic_id >= PM800_CHIP_A0) && (pmic_id <= PM800_CHIP_END)) {
+		chip->version = ret;
+		dev_info(chip->dev,
+			 "88PM80x:Marvell 88PM800 (ID:0x%x) detected\n", ret);
+	} else {
+		dev_err(chip->dev,
+			"Failed to detect Marvell 88PM800:ChipID[0x%x]\n", ret);
+		goto out;
+	}
+
+	/*
+	 * alarm wake up bit will be clear in device_irq_init(),
+	 * read before that
+	 */
+	regmap_read(chip->regmap, PM800_RTC_CONTROL, &ret);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read RTC register: %d\n", ret);
+		goto out;
+	}
+	if (ret & PM800_ALARM_WAKEUP) {
+		if (pdata && pdata->rtc)
+			pdata->rtc->rtc_wakeup = 1;
+	}
+
+	ret = device_gpadc_init(chip, pdata);
+	if (ret < 0) {
+		dev_err(chip->dev, "[%s]Failed to init gpadc\n", __func__);
+		goto out;
+	}
+
+	chip->regmap_irq_chip = &pm800_irq_chip;
+
+	ret = device_irq_init_800(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "[%s]Failed to init pm800 irq\n", __func__);
+		goto out;
+	}
+
+	ret =
+	    mfd_add_devices(chip->dev, 0, &onkey_devs[0],
+			    ARRAY_SIZE(onkey_devs), &onkey_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add onkey subdev\n");
+		goto out_dev;
+	} else
+		dev_info(chip->dev, "[%s]:Added mfd onkey_devs\n", __func__);
+
+	if (pdata && pdata->rtc) {
+		rtc_devs[0].platform_data = pdata->rtc;
+		rtc_devs[0].pdata_size = sizeof(struct pm80x_rtc_pdata);
+		ret = mfd_add_devices(chip->dev, 0, &rtc_devs[0],
+				      ARRAY_SIZE(rtc_devs), NULL, 0);
+		if (ret < 0) {
+			dev_err(chip->dev, "Failed to add rtc subdev\n");
+			goto out_dev;
+		} else
+			dev_info(chip->dev,
+				 "[%s]:Added mfd rtc_devs\n", __func__);
+	}
+
+	return 0;
+out_dev:
+	mfd_remove_devices(chip->dev);
+	device_irq_exit_800(chip);
+out:
+	return ret;
+}
+
+static int __devinit pm800_probe(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct pm80x_chip *chip;
+	struct pm80x_platform_data *pdata = client->dev.platform_data;
+	struct pm80x_subchip *subchip;
+
+	ret = pm80x_init(client, id);
+	if (ret) {
+		dev_err(&client->dev, "pm800_init fail\n");
+		goto out_init;
+	}
+
+	chip = i2c_get_clientdata(client);
+
+	/* init subchip for PM800 */
+	subchip =
+	    devm_kzalloc(&client->dev, sizeof(struct pm80x_subchip),
+			 GFP_KERNEL);
+	if (!subchip) {
+		ret = -ENOMEM;
+		goto err_subchip_alloc;
+	}
+
+	subchip->power_page_addr = pdata->power_page_addr;
+	subchip->gpadc_page_addr = pdata->gpadc_page_addr;
+	chip->subchip = subchip;
+
+	ret = device_800_init(chip, pdata);
+	if (ret) {
+		dev_err(chip->dev, "%s id 0x%x failed!\n", __func__, chip->id);
+		goto err_800_init;
+	}
+
+	ret = pm800_pages_init(chip);
+	if (ret) {
+		dev_err(&client->dev, "pm800_pages_init failed!\n");
+		goto err_page_init;
+	}
+
+	if (pdata->plat_config)
+		pdata->plat_config(chip, pdata);
+
+err_page_init:
+	mfd_remove_devices(chip->dev);
+	device_irq_exit_800(chip);
+err_800_init:
+	devm_kfree(&client->dev, subchip);
+err_subchip_alloc:
+	pm80x_deinit(client);
+out_init:
+	return ret;
+}
+
+static int __devexit pm800_remove(struct i2c_client *client)
+{
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	mfd_remove_devices(chip->dev);
+	device_irq_exit_800(chip);
+
+	pm800_pages_exit(chip);
+	devm_kfree(&client->dev, chip->subchip);
+
+	pm80x_deinit(client);
+
+	return 0;
+}
+
+static struct i2c_driver pm800_driver = {
+	.driver = {
+		.name = "88PM80X",
+		.owner = THIS_MODULE,
+		.pm = &pm80x_pm_ops,
+		},
+	.probe = pm800_probe,
+	.remove = __devexit_p(pm800_remove),
+	.id_table = pm80x_id_table,
+};
+
+static int __init pm800_i2c_init(void)
+{
+	return i2c_add_driver(&pm800_driver);
+}
+subsys_initcall(pm800_i2c_init);
+
+static void __exit pm800_i2c_exit(void)
+{
+	i2c_del_driver(&pm800_driver);
+}
+module_exit(pm800_i2c_exit);
+
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM800");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm805.c b/drivers/mfd/88pm805.c
new file mode 100644
index 0000000..d59ca6b
--- /dev/null
+++ b/drivers/mfd/88pm805.c
@@ -0,0 +1,300 @@
+/*
+ * Base driver for Marvell 88PM805
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Joseph(Yossi) Hanin <yhanin@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#define PM805_CHIP_ID			(0x00)
+
+static const struct i2c_device_id pm80x_id_table[] = {
+	{"88PM805", CHIP_PM805},
+	{} /* NULL terminated */
+};
+MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
+
+/* Interrupt Number in 88PM805 */
+enum {
+	PM805_IRQ_LDO_OFF,	/*0 */
+	PM805_IRQ_SRC_DPLL_LOCK,	/*1 */
+	PM805_IRQ_CLIP_FAULT,
+	PM805_IRQ_MIC_CONFLICT,
+	PM805_IRQ_HP2_SHRT,
+	PM805_IRQ_HP1_SHRT,	/*5 */
+	PM805_IRQ_FINE_PLL_FAULT,
+	PM805_IRQ_RAW_PLL_FAULT,
+	PM805_IRQ_VOLP_BTN_DET,
+	PM805_IRQ_VOLM_BTN_DET,
+	PM805_IRQ_SHRT_BTN_DET,	/*10 */
+	PM805_IRQ_MIC_DET,	/*11 */
+
+	PM805_MAX_IRQ,
+};
+
+static struct resource codec_resources[] = {
+	{
+	 /* Headset microphone insertion or removal */
+	 .name = "micin",
+	 .start = PM805_IRQ_MIC_DET,
+	 .end = PM805_IRQ_MIC_DET,
+	 .flags = IORESOURCE_IRQ,
+	 },
+	{
+	 /* Audio short HP1 */
+	 .name = "audio-short1",
+	 .start = PM805_IRQ_HP1_SHRT,
+	 .end = PM805_IRQ_HP1_SHRT,
+	 .flags = IORESOURCE_IRQ,
+	 },
+	{
+	 /* Audio short HP2 */
+	 .name = "audio-short2",
+	 .start = PM805_IRQ_HP2_SHRT,
+	 .end = PM805_IRQ_HP2_SHRT,
+	 .flags = IORESOURCE_IRQ,
+	 },
+};
+
+static struct mfd_cell codec_devs[] = {
+	{
+	 .name = "88pm80x-codec",
+	 .num_resources = ARRAY_SIZE(codec_resources),
+	 .resources = &codec_resources[0],
+	 .id = -1,
+	 },
+};
+
+static struct regmap_irq pm805_irqs[] = {
+	/* INT0 */
+	[PM805_IRQ_LDO_OFF] = {
+		.mask = PM805_INT1_HP1_SHRT,
+	},
+	[PM805_IRQ_SRC_DPLL_LOCK] = {
+		.mask = PM805_INT1_HP2_SHRT,
+	},
+	[PM805_IRQ_CLIP_FAULT] = {
+		.mask = PM805_INT1_MIC_CONFLICT,
+	},
+	[PM805_IRQ_MIC_CONFLICT] = {
+		.mask = PM805_INT1_CLIP_FAULT,
+	},
+	[PM805_IRQ_HP2_SHRT] = {
+		.mask = PM805_INT1_LDO_OFF,
+	},
+	[PM805_IRQ_HP1_SHRT] = {
+		.mask = PM805_INT1_SRC_DPLL_LOCK,
+	},
+	/* INT1 */
+	[PM805_IRQ_FINE_PLL_FAULT] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_MIC_DET,
+	},
+	[PM805_IRQ_RAW_PLL_FAULT] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_SHRT_BTN_DET,
+	},
+	[PM805_IRQ_VOLP_BTN_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_VOLM_BTN_DET,
+	},
+	[PM805_IRQ_VOLM_BTN_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_VOLP_BTN_DET,
+	},
+	[PM805_IRQ_SHRT_BTN_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_RAW_PLL_FAULT,
+	},
+	[PM805_IRQ_MIC_DET] = {
+		.reg_offset = 1,
+		.mask = PM805_INT2_FINE_PLL_FAULT,
+	},
+};
+
+static int __devinit device_irq_init_805(struct pm80x_chip *chip)
+{
+	struct regmap *map = chip->regmap;
+	unsigned long flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	int data, mask, ret = -EINVAL;
+
+	if (!map || !chip->irq) {
+		dev_err(chip->dev, "incorrect parameters\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * irq_mode defines the way of clearing interrupt. it's read-clear by
+	 * default.
+	 */
+	mask =
+	    PM805_STATUS0_INT_CLEAR | PM805_STATUS0_INV_INT |
+	    PM800_STATUS0_INT_MASK;
+
+	data = PM805_STATUS0_INT_CLEAR;
+	ret = regmap_update_bits(map, PM805_INT_STATUS0, mask, data);
+	/*
+	 * PM805_INT_STATUS is under 32K clock domain, so need to
+	 * add proper delay before the next I2C register access.
+	 */
+	msleep(1);
+
+	if (ret < 0)
+		goto out;
+
+	ret =
+	    regmap_add_irq_chip(chip->regmap, chip->irq, flags, -1,
+				chip->regmap_irq_chip, &chip->irq_data);
+
+out:
+	return ret;
+}
+
+static void device_irq_exit_805(struct pm80x_chip *chip)
+{
+	regmap_del_irq_chip(chip->irq, chip->irq_data);
+}
+
+static struct regmap_irq_chip pm805_irq_chip = {
+	.name = "88pm805",
+	.irqs = pm805_irqs,
+	.num_irqs = ARRAY_SIZE(pm805_irqs),
+
+	.num_regs = 2,
+	.status_base = PM805_INT_STATUS1,
+	.mask_base = PM805_INT_MASK1,
+	.ack_base = PM805_INT_STATUS1,
+};
+
+static int __devinit device_805_init(struct pm80x_chip *chip)
+{
+	int ret = 0;
+	struct regmap *map = chip->regmap;
+
+	if (!map) {
+		dev_err(chip->dev, "regmap is invalid\n");
+		return -EINVAL;
+	}
+
+	regmap_read(map, PM805_CHIP_ID, &ret);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to read CHIP ID: %d\n", ret);
+		goto out_irq_init;
+	}
+	chip->version = ret;
+
+	chip->regmap_irq_chip = &pm805_irq_chip;
+
+	ret = device_irq_init_805(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to init pm805 irq!\n");
+		goto out_irq_init;
+	}
+
+	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
+			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to add codec subdev\n");
+		goto out_codec;
+	} else
+		dev_info(chip->dev, "[%s]:Added mfd codec_devs\n", __func__);
+
+	return 0;
+
+out_codec:
+	device_irq_exit_805(chip);
+out_irq_init:
+	return ret;
+}
+
+static int __devinit pm805_probe(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct pm80x_chip *chip;
+	struct pm80x_platform_data *pdata = client->dev.platform_data;
+
+	ret = pm80x_init(client, id);
+	if (ret) {
+		dev_err(&client->dev, "pm805_init fail!\n");
+		goto out_init;
+	}
+
+	chip = i2c_get_clientdata(client);
+
+	ret = device_805_init(chip);
+	if (ret) {
+		dev_err(chip->dev, "%s id 0x%x failed!\n", __func__, chip->id);
+		goto err_805_init;
+	}
+
+	if (pdata->plat_config)
+		pdata->plat_config(chip, pdata);
+
+err_805_init:
+	pm80x_deinit(client);
+out_init:
+	return ret;
+}
+
+static int __devexit pm805_remove(struct i2c_client *client)
+{
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	mfd_remove_devices(chip->dev);
+	device_irq_exit_805(chip);
+
+	pm80x_deinit(client);
+
+	return 0;
+}
+
+static struct i2c_driver pm805_driver = {
+	.driver = {
+		.name = "88PM80X",
+		.owner = THIS_MODULE,
+		.pm = &pm80x_pm_ops,
+		},
+	.probe = pm805_probe,
+	.remove = __devexit_p(pm805_remove),
+	.id_table = pm80x_id_table,
+};
+
+static int __init pm805_i2c_init(void)
+{
+	return i2c_add_driver(&pm805_driver);
+}
+subsys_initcall(pm805_i2c_init);
+
+static void __exit pm805_i2c_exit(void)
+{
+	i2c_del_driver(&pm805_driver);
+}
+module_exit(pm805_i2c_exit);
+
+MODULE_DESCRIPTION("PMIC Driver for Marvell 88PM805");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
new file mode 100644
index 0000000..5d73531
--- /dev/null
+++ b/drivers/mfd/88pm80x.c
@@ -0,0 +1,117 @@
+/*
+ * I2C driver for Marvell 88PM80x
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Haojian Zhuang <haojian.zhuang@marvell.com>
+ * Joseph(Yossi) Hanin <yhanin@marvell.com>
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/err.h>
+
+
+const struct regmap_config pm80x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+EXPORT_SYMBOL_GPL(pm80x_regmap_config);
+
+int __devinit pm80x_init(struct i2c_client *client,
+				 const struct i2c_device_id *id)
+{
+	struct pm80x_chip *chip;
+	struct regmap *map;
+	int ret = 0;
+
+	chip =
+	    devm_kzalloc(&client->dev, sizeof(struct pm80x_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	map = devm_regmap_init_i2c(client, &pm80x_regmap_config);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		dev_err(&client->dev, "Failed to allocate register map: %d\n",
+			ret);
+		goto err_regmap_init;
+	}
+
+	chip->id = id->driver_data;
+	if (chip->id < CHIP_PM800 || chip->id > CHIP_PM805) {
+		ret = -EINVAL;
+		goto err_chip_id;
+	}
+
+	chip->client = client;
+	chip->regmap = map;
+
+	chip->irq = client->irq;
+
+	chip->dev = &client->dev;
+	dev_set_drvdata(chip->dev, chip);
+	i2c_set_clientdata(chip->client, chip);
+
+	device_init_wakeup(&client->dev, 1);
+
+	return 0;
+
+err_chip_id:
+	regmap_exit(map);
+err_regmap_init:
+	devm_kfree(&client->dev, chip);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pm80x_init);
+
+int __devexit pm80x_deinit(struct i2c_client *client)
+{
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	regmap_exit(chip->regmap);
+	devm_kfree(&client->dev, chip);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pm80x_deinit);
+
+#ifdef CONFIG_PM_SLEEP
+static int pm80x_suspend(struct device *dev)
+{
+	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip && chip->wu_flag)
+		if (device_may_wakeup(chip->dev))
+			enable_irq_wake(chip->irq);
+
+	return 0;
+}
+
+static int pm80x_resume(struct device *dev)
+{
+	struct i2c_client *client = container_of(dev, struct i2c_client, dev);
+	struct pm80x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip && chip->wu_flag)
+		if (device_may_wakeup(chip->dev))
+			disable_irq_wake(chip->irq);
+
+	return 0;
+}
+#endif
+
+SIMPLE_DEV_PM_OPS(pm80x_pm_ops, pm80x_suspend, pm80x_resume);
+EXPORT_SYMBOL_GPL(pm80x_pm_ops);
+
+MODULE_DESCRIPTION("I2C Driver for Marvell 88PM80x");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e129c82..dc9bd97 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -20,6 +20,30 @@ config MFD_88PM860X
 	  select individual components like voltage regulators, RTC and
 	  battery-charger under the corresponding menus.
 
+config MFD_88PM800
+	tristate "Support Marvell 88PM800"
+	depends on I2C=y && GENERIC_HARDIRQS
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  This supports for Marvell 88PM800 Power Management IC.
+	  This includes the I2C driver and the core APIs _only_, you have to
+	  select individual components like voltage regulators, RTC and
+	  battery-charger under the corresponding menus.
+
+config MFD_88PM805
+	tristate "Support Marvell 88PM805"
+	depends on I2C=y && GENERIC_HARDIRQS
+	select REGMAP_I2C
+	select REGMAP_IRQ
+	select MFD_CORE
+	help
+	  This supports for Marvell 88PM805 Power Management IC. This includes
+	  the I2C driver and the core APIs _only_, you have to select individual
+	  components like codec device, headset/Mic device under the
+	  corresponding menus.
+
 config MFD_SM501
 	tristate "Support for Silicon Motion SM501"
 	 ---help---
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 75f6ed6..e056a52 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -4,6 +4,8 @@
 
 88pm860x-objs			:= 88pm860x-core.o 88pm860x-i2c.o
 obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
+obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
+obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_MFD_ASIC3)		+= asic3.o tmio_core.o
 
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
new file mode 100644
index 0000000..6c126e9
--- /dev/null
+++ b/include/linux/mfd/88pm80x.h
@@ -0,0 +1,368 @@
+/*
+ * Marvell 88PM80x Interface
+ *
+ * Copyright (C) 2012 Marvell International Ltd.
+ * Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_MFD_88PM80X_H
+#define __LINUX_MFD_88PM80X_H
+
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/regmap.h>
+#include <linux/atomic.h>
+
+#define PM80X_VERSION_MASK		(0xFF)	/* 80X chip ID mask */
+enum {
+	CHIP_INVALID = 0,
+	CHIP_PM800,
+	CHIP_PM805,
+	CHIP_MAX,
+};
+
+enum {
+	PM800_ID_BUCK1 = 0,
+	PM800_ID_BUCK2,
+	PM800_ID_BUCK3,
+	PM800_ID_BUCK4,
+	PM800_ID_BUCK5,
+
+	PM800_ID_LDO1,
+	PM800_ID_LDO2,
+	PM800_ID_LDO3,
+	PM800_ID_LDO4,
+	PM800_ID_LDO5,
+	PM800_ID_LDO6,
+	PM800_ID_LDO7,
+	PM800_ID_LDO8,
+	PM800_ID_LDO9,
+	PM800_ID_LDO10,
+	PM800_ID_LDO11,
+	PM800_ID_LDO12,
+	PM800_ID_LDO13,
+	PM800_ID_LDO14,
+	PM800_ID_LDO15,
+	PM800_ID_LDO16,
+	PM800_ID_LDO17,
+	PM800_ID_LDO18,
+	PM800_ID_LDO19,
+
+	PM800_ID_RG_MAX,
+};
+#define PM800_MAX_REGULATOR	PM800_ID_RG_MAX	/* 5 Bucks, 19 LDOs */
+#define PM800_NUM_BUCK (5)	/*5 Bucks */
+#define PM800_NUM_LDO (19)	/*19 Bucks */
+
+/* page 0 basic: slave adder 0x60 */
+
+#define PM800_STATUS_1			(0x01)
+#define PM800_ONKEY_STS1		(1 << 0)
+#define PM800_EXTON_STS1		(1 << 1)
+#define PM800_CHG_STS1			(1 << 2)
+#define PM800_BAT_STS1			(1 << 3)
+#define PM800_VBUS_STS1			(1 << 4)
+#define PM800_LDO_PGOOD_STS1	(1 << 5)
+#define PM800_BUCK_PGOOD_STS1	(1 << 6)
+
+#define PM800_STATUS_2			(0x02)
+#define PM800_RTC_ALARM_STS2	(1 << 0)
+
+/* Wakeup Registers */
+#define PM800_WAKEUP1		(0x0D)
+
+#define PM800_WAKEUP2		(0x0E)
+#define PM800_WAKEUP2_INV_INT		(1 << 0)
+#define PM800_WAKEUP2_INT_CLEAR		(1 << 1)
+#define PM800_WAKEUP2_INT_MASK		(1 << 2)
+
+#define PM800_POWER_UP_LOG	(0x10)
+
+/* Referance and low power registers */
+#define PM800_LOW_POWER1		(0x20)
+#define PM800_LOW_POWER2		(0x21)
+#define PM800_LOW_POWER_CONFIG3	(0x22)
+#define PM800_LOW_POWER_CONFIG4	(0x23)
+
+/* GPIO register */
+#define PM800_GPIO_0_1_CNTRL		(0x30)
+#define PM800_GPIO0_VAL				(1 << 0)
+#define PM800_GPIO0_GPIO_MODE(x)	(x << 1)
+#define PM800_GPIO1_VAL				(1 << 4)
+#define PM800_GPIO1_GPIO_MODE(x)	(x << 5)
+
+#define PM800_GPIO_2_3_CNTRL		(0x31)
+#define PM800_GPIO2_VAL				(1 << 0)
+#define PM800_GPIO2_GPIO_MODE(x)	(x << 1)
+#define PM800_GPIO3_VAL				(1 << 4)
+#define PM800_GPIO3_GPIO_MODE(x)	(x << 5)
+#define PM800_GPIO3_MODE_MASK		0x1F
+#define PM800_GPIO3_HEADSET_MODE	PM800_GPIO3_GPIO_MODE(6)
+
+#define PM800_GPIO_4_CNTRL			(0x32)
+#define PM800_GPIO4_VAL				(1 << 0)
+#define PM800_GPIO4_GPIO_MODE(x)	(x << 1)
+
+#define PM800_HEADSET_CNTRL		(0x38)
+#define PM800_HEADSET_DET_EN		(1 << 7)
+#define PM800_HSDET_SLP			(1 << 1)
+/* PWM register */
+#define PM800_PWM1		(0x40)
+#define PM800_PWM2		(0x41)
+#define PM800_PWM3		(0x42)
+#define PM800_PWM4		(0x43)
+
+/* RTC Registers */
+#define PM800_RTC_CONTROL		(0xD0)
+#define PM800_RTC_MISC1			(0xE1)
+#define PM800_RTC_MISC2			(0xE2)
+#define PM800_RTC_MISC3			(0xE3)
+#define PM800_RTC_MISC4			(0xE4)
+#define PM800_RTC_MISC5			(0xE7)
+/* bit definitions of RTC Register 1 (0xD0) */
+#define PM800_ALARM1_EN			(1 << 0)
+#define PM800_ALARM_WAKEUP		(1 << 4)
+#define PM800_ALARM			(1 << 5)
+#define PM800_RTC1_USE_XO		(1 << 7)
+
+/* Regulator Control Registers: BUCK1,BUCK5,LDO1 have DVC */
+
+/* buck registers */
+#define PM800_SLEEP_BUCK1	(0x30)
+
+/* BUCK Sleep Mode Register 1: BUCK[1..4] */
+#define PM800_BUCK_SLP1		(0x5A)
+#define PM800_BUCK1_SLP1_SHIFT	0
+#define PM800_BUCK1_SLP1_MASK	(0x3 << PM800_BUCK1_SLP1_SHIFT)
+
+/* page 2 GPADC: slave adder 0x02 */
+#define PM800_GPADC_MEAS_EN1		(0x01)
+#define PM800_MEAS_EN1_VBAT         (1 << 2)
+#define PM800_GPADC_MEAS_EN2		(0x02)
+#define PM800_MEAS_EN2_RFTMP        (1 << 0)
+#define PM800_MEAS_GP0_EN			(1 << 2)
+#define PM800_MEAS_GP1_EN			(1 << 3)
+#define PM800_MEAS_GP2_EN			(1 << 4)
+#define PM800_MEAS_GP3_EN			(1 << 5)
+#define PM800_MEAS_GP4_EN			(1 << 6)
+
+#define PM800_GPADC_MISC_CONFIG1	(0x05)
+#define PM800_GPADC_MISC_CONFIG2	(0x06)
+#define PM800_GPADC_MISC_GPFSM_EN	(1 << 0)
+#define PM800_GPADC_SLOW_MODE(x)	(x << 3)
+
+#define PM800_GPADC_MISC_CONFIG3		(0x09)
+#define PM800_GPADC_MISC_CONFIG4		(0x0A)
+
+#define PM800_GPADC_PREBIAS1			(0x0F)
+#define PM800_GPADC0_GP_PREBIAS_TIME(x)	(x << 0)
+#define PM800_GPADC_PREBIAS2			(0x10)
+
+#define PM800_GP_BIAS_ENA1				(0x14)
+#define PM800_GPADC_GP_BIAS_EN0			(1 << 0)
+#define PM800_GPADC_GP_BIAS_EN1			(1 << 1)
+#define PM800_GPADC_GP_BIAS_EN2			(1 << 2)
+#define PM800_GPADC_GP_BIAS_EN3			(1 << 3)
+
+#define PM800_GP_BIAS_OUT1		(0x15)
+#define PM800_BIAS_OUT_GP0		(1 << 0)
+#define PM800_BIAS_OUT_GP1		(1 << 1)
+#define PM800_BIAS_OUT_GP2		(1 << 2)
+#define PM800_BIAS_OUT_GP3		(1 << 3)
+
+#define PM800_GPADC0_LOW_TH		0x20
+#define PM800_GPADC1_LOW_TH		0x21
+#define PM800_GPADC2_LOW_TH		0x22
+#define PM800_GPADC3_LOW_TH		0x23
+#define PM800_GPADC4_LOW_TH		0x24
+
+#define PM800_GPADC0_UPP_TH		0x30
+#define PM800_GPADC1_UPP_TH		0x31
+#define PM800_GPADC2_UPP_TH		0x32
+#define PM800_GPADC3_UPP_TH		0x33
+#define PM800_GPADC4_UPP_TH		0x34
+
+#define PM800_VBBAT_MEAS1		0x40
+#define PM800_VBBAT_MEAS2		0x41
+#define PM800_VBAT_MEAS1		0x42
+#define PM800_VBAT_MEAS2		0x43
+#define PM800_VSYS_MEAS1		0x44
+#define PM800_VSYS_MEAS2		0x45
+#define PM800_VCHG_MEAS1		0x46
+#define PM800_VCHG_MEAS2		0x47
+#define PM800_TINT_MEAS1		0x50
+#define PM800_TINT_MEAS2		0x51
+#define PM800_PMOD_MEAS1		0x52
+#define PM800_PMOD_MEAS2		0x53
+
+#define PM800_GPADC0_MEAS1		0x54
+#define PM800_GPADC0_MEAS2		0x55
+#define PM800_GPADC1_MEAS1		0x56
+#define PM800_GPADC1_MEAS2		0x57
+#define PM800_GPADC2_MEAS1		0x58
+#define PM800_GPADC2_MEAS2		0x59
+#define PM800_GPADC3_MEAS1		0x5A
+#define PM800_GPADC3_MEAS2		0x5B
+#define PM800_GPADC4_MEAS1		0x5C
+#define PM800_GPADC4_MEAS2		0x5D
+
+#define PM800_GPADC4_AVG1		0xA8
+#define PM800_GPADC4_AVG2		0xA9
+
+/* 88PM805 Registers */
+#define PM805_MAIN_POWERUP		(0x01)
+#define PM805_INT_STATUS0		(0x02)	/* for ena/dis all interrupts */
+
+#define PM805_STATUS0_INT_CLEAR		(1 << 0)
+#define PM805_STATUS0_INV_INT		(1 << 1)
+#define PM800_STATUS0_INT_MASK		(1 << 2)
+
+#define PM805_INT_STATUS1		(0x03)
+
+#define PM805_INT1_HP1_SHRT		(1 << 0)
+#define PM805_INT1_HP2_SHRT		(1 << 1)
+#define PM805_INT1_MIC_CONFLICT		(1 << 2)
+#define PM805_INT1_CLIP_FAULT		(1 << 3)
+#define PM805_INT1_LDO_OFF			(1 << 4)
+#define PM805_INT1_SRC_DPLL_LOCK	(1 << 5)
+
+#define PM805_INT_STATUS2		(0x04)
+
+#define PM805_INT2_MIC_DET			(1 << 0)
+#define PM805_INT2_SHRT_BTN_DET		(1 << 1)
+#define PM805_INT2_VOLM_BTN_DET		(1 << 2)
+#define PM805_INT2_VOLP_BTN_DET		(1 << 3)
+#define PM805_INT2_RAW_PLL_FAULT	(1 << 4)
+#define PM805_INT2_FINE_PLL_FAULT	(1 << 5)
+
+#define PM805_INT_MASK1			(0x05)
+#define PM805_INT_MASK2			(0x06)
+#define PM805_SHRT_BTN_DET		(1 << 1)
+
+/* number of status and int reg in a row */
+#define PM805_INT_REG_NUM		(2)
+
+#define PM805_MIC_DET1			(0x07)
+#define PM805_MIC_DET_EN_MIC_DET (1 << 0)
+#define PM805_MIC_DET2			(0x08)
+#define PM805_MIC_DET_STATUS1	(0x09)
+
+#define PM805_MIC_DET_STATUS3	(0x0A)
+#define PM805_AUTO_SEQ_STATUS1	(0x0B)
+#define PM805_AUTO_SEQ_STATUS2	(0x0C)
+
+#define PM805_ADC_SETTING1		(0x10)
+#define PM805_ADC_SETTING2		(0x11)
+#define PM805_ADC_SETTING3		(0x11)
+#define PM805_ADC_GAIN1			(0x12)
+#define PM805_ADC_GAIN2			(0x13)
+#define PM805_DMIC_SETTING		(0x15)
+#define PM805_DWS_SETTING		(0x16)
+#define PM805_MIC_CONFLICT_STS	(0x17)
+
+#define PM805_PDM_SETTING1		(0x20)
+#define PM805_PDM_SETTING2		(0x21)
+#define PM805_PDM_SETTING3		(0x22)
+#define PM805_PDM_CONTROL1		(0x23)
+#define PM805_PDM_CONTROL2		(0x24)
+#define PM805_PDM_CONTROL3		(0x25)
+
+#define PM805_HEADPHONE_SETTING			(0x26)
+#define PM805_HEADPHONE_GAIN_A2A		(0x27)
+#define PM805_HEADPHONE_SHORT_STATE		(0x28)
+#define PM805_EARPHONE_SETTING			(0x29)
+#define PM805_AUTO_SEQ_SETTING			(0x2A)
+
+struct pm80x_rtc_pdata {
+	int		vrtc;
+	int		rtc_wakeup;
+};
+
+struct pm80x_subchip {
+	struct i2c_client *power_page;	/* chip client for power page */
+	struct i2c_client *gpadc_page;	/* chip client for gpadc page */
+	struct regmap *regmap_power;
+	struct regmap *regmap_gpadc;
+	unsigned short power_page_addr;	/* power page I2C address */
+	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
+};
+
+struct pm80x_chip {
+	struct pm80x_subchip *subchip;
+	struct device *dev;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	struct regmap_irq_chip *regmap_irq_chip;
+	struct regmap_irq_chip_data *irq_data;
+	unsigned char version;
+	int id;
+	int irq;
+	int irq_mode;
+	unsigned long wu_flag;
+	spinlock_t lock;
+};
+
+struct pm80x_platform_data {
+	struct pm80x_rtc_pdata *rtc;
+	unsigned short power_page_addr;	/* power page I2C address */
+	unsigned short gpadc_page_addr;	/* gpadc page I2C address */
+	int irq_mode;		/* Clear interrupt by read/write(0/1) */
+	int batt_det;		/* enable/disable */
+	int (*plat_config)(struct pm80x_chip *chip,
+				struct pm80x_platform_data *pdata);
+};
+
+extern const struct dev_pm_ops pm80x_pm_ops;
+extern const struct regmap_config pm80x_regmap_config;
+
+static inline int pm80x_request_irq(struct pm80x_chip *pm80x, int irq,
+				     irq_handler_t handler, unsigned long flags,
+				     const char *name, void *data)
+{
+	if (!pm80x->irq_data)
+		return -EINVAL;
+	return request_threaded_irq(regmap_irq_get_virq(pm80x->irq_data, irq),
+				    NULL, handler, flags, name, data);
+}
+
+static inline void pm80x_free_irq(struct pm80x_chip *pm80x, int irq, void *data)
+{
+	if (!pm80x->irq_data)
+		return;
+	free_irq(regmap_irq_get_virq(pm80x->irq_data, irq), data);
+}
+
+#ifdef CONFIG_PM
+static inline int pm80x_dev_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	int irq = platform_get_irq(pdev, 0);
+
+	if (device_may_wakeup(dev))
+		set_bit((1 << irq), &chip->wu_flag);
+
+	return 0;
+}
+
+static inline int pm80x_dev_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	int irq = platform_get_irq(pdev, 0);
+
+	if (device_may_wakeup(dev))
+		clear_bit((1 << irq), &chip->wu_flag);
+
+	return 0;
+}
+#endif
+
+extern int pm80x_init(struct i2c_client *client,
+			     const struct i2c_device_id *id) __devinit;
+extern int pm80x_deinit(struct i2c_client *client) __devexit;
+#endif /* __LINUX_MFD_88PM80X_H */
-- 
1.7.0.4

