From: S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH V4 3/3] mfd: da9063: MFD support for OnKey driver
Date: Tue, 12 May 2015 14:31:06 +0100
Message-ID: <81dec245f0d1a3a0713e6e2966d2278e422208f2.1431437466.git.stwiss.opensource@diasemi.com>
References: <cover.1431437466.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431437466.git.stwiss.opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Steve Twiss <stwiss.opensource@diasemi.com>
Cc: DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Add MFD support for the DA9063 OnKey driver

The function da9063_clear_fault_log() is added to mitigate the case of a
hardware power-cut after a long-long OnKey press. Although there is no
software intervention in this case (by definition) such a shutdown would
cause persistent information within the DA9063 FAULT_LOG that would be
available during the next device restart.

Clearance of this persistent register must be completed after such a
hardware power-cut operation has happened so that the FAULT_LOG does not
continue with previous values. The clearance function has been added here
in the kernel driver because wiping the fault-log cannot be counted on
outside the Linux kernel.


Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
Version History

Changes in V4
 - Additional description of MFD patch changes for FAULT_LOG in relation to
   the requirements of the OnKey driver. Please see a further explanation of
   the OnKey's operation in this thread: https://lkml.org/lkml/2015/4/29/406

Changes in V3
 - The MFD code was originally in [PATCH V2 1/2]. This is now been moved into
   this patch [PATCH V3 3/3].
 - Whitespace cleanup

This patch applies against linux-next and v4.1-rc3 


 drivers/mfd/da9063-core.c        | 54 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/da9063/pdata.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index facd361..af841c1 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -60,6 +60,7 @@ static struct resource da9063_rtc_resources[] = {
 
 static struct resource da9063_onkey_resources[] = {
 	{
+		.name	= "ONKEY",
 		.start	= DA9063_IRQ_ONKEY,
 		.end	= DA9063_IRQ_ONKEY,
 		.flags	= IORESOURCE_IRQ,
@@ -97,6 +98,7 @@ static const struct mfd_cell da9063_devs[] = {
 		.name		= DA9063_DRVNAME_ONKEY,
 		.num_resources	= ARRAY_SIZE(da9063_onkey_resources),
 		.resources	= da9063_onkey_resources,
+		.of_compatible = "dlg,da9063-onkey",
 	},
 	{
 		.name		= DA9063_DRVNAME_RTC,
@@ -109,12 +111,64 @@ static const struct mfd_cell da9063_devs[] = {
 	},
 };
 
+static int da9063_clear_fault_log(struct da9063 *da9063)
+{
+	int ret = 0;
+	int fault_log = 0;
+
+	ret = regmap_read(da9063->regmap, DA9063_REG_FAULT_LOG, &fault_log);
+	if (ret < 0) {
+		dev_err(da9063->dev, "Cannot read FAULT_LOG.\n");
+		return -EIO;
+	}
+
+	if (fault_log) {
+		if (fault_log & DA9063_TWD_ERROR)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_TWD_ERROR\n");
+		if (fault_log & DA9063_POR)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_POR\n");
+		if (fault_log & DA9063_VDD_FAULT)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_VDD_FAULT\n");
+		if (fault_log & DA9063_VDD_START)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_VDD_START\n");
+		if (fault_log & DA9063_TEMP_CRIT)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_TEMP_CRIT\n");
+		if (fault_log & DA9063_KEY_RESET)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_KEY_RESET\n");
+		if (fault_log & DA9063_NSHUTDOWN)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_NSHUTDOWN\n");
+		if (fault_log & DA9063_WAIT_SHUT)
+			dev_dbg(da9063->dev,
+				"Fault log entry detected: DA9063_WAIT_SHUT\n");
+	}
+
+	ret = regmap_write(da9063->regmap,
+			   DA9063_REG_FAULT_LOG,
+			   fault_log);
+	if (ret < 0)
+		dev_err(da9063->dev,
+			"Cannot reset FAULT_LOG values %d\n", ret);
+
+	return ret;
+}
+
 int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 {
 	struct da9063_pdata *pdata = da9063->dev->platform_data;
 	int model, variant_id, variant_code;
 	int ret;
 
+	ret = da9063_clear_fault_log(da9063);
+	if (ret < 0)
+		dev_err(da9063->dev, "Cannot clear fault log\n");
+
 	if (pdata) {
 		da9063->flags = pdata->flags;
 		da9063->irq_base = pdata->irq_base;
diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
index 95c8742..612383b 100644
--- a/include/linux/mfd/da9063/pdata.h
+++ b/include/linux/mfd/da9063/pdata.h
@@ -103,6 +103,7 @@ struct da9063;
 struct da9063_pdata {
 	int				(*init)(struct da9063 *da9063);
 	int				irq_base;
+	bool				key_power;
 	unsigned			flags;
 	struct da9063_regulators_pdata	*regulators_pdata;
 	struct led_platform_data	*leds_pdata;
-- 
end-of-patch for PATCH V4
