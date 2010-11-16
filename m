From: Chris Leech <christopher.leech@linux.intel.com>
Subject: [PATCH 0/4] qt602240_ts changes for Intel mid platform
Date: Tue, 16 Nov 2010 12:41:45 -0800
Message-ID: <20101116203914.28796.23141.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46758 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757111Ab0KPUlp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 15:41:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Joonyoung Shim <jy0922.shim@samsung.com>

The following changes were made while getting this driver to work on an Intel
mid platform.

---

Chris Leech (4):
      qt602240_ts: fix wrong sizeof in object table allocation
      qt602240_ts: move clearing of pending interrupt closer to request_threaded_irq
      qt602240_ts: Trust factory configuration of touchscreen.
      qt602240_ts: add optional hooks for board specific reset logic


 drivers/input/touchscreen/qt602240_ts.c |  138 +++++++++++++++++++++++--------
 include/linux/i2c/qt602240_ts.h         |   12 +++
 2 files changed, 114 insertions(+), 36 deletions(-)

---

Here is an example of the platform device setup code that makes use of these
changes.  The platform code will be sent upstream via a different channel.

diff --git a/arch/x86/kernel/mrst.c b/arch/x86/kernel/mrst.c
index 9ed9e6b..d1ebdc8 100644
--- a/arch/x86/kernel/mrst.c
+++ b/arch/x86/kernel/mrst.c
@@ -34,6 +34,7 @@
 #include <linux/i2c/tc35894xbg.h>
 #include <linux/bh1770glc.h>
 #include <linux/leds-lp5523.h>
+#include <linux/i2c/qt602240_ts.h>
 
 #include <asm/setup.h>
 #include <asm/mpspec_def.h>
@@ -1032,6 +1033,76 @@ void *tc35894xbg_n_platform_data(void *info)
 		&tc35894xbg_ncdk_data);
 }
 
+static int qt602240_reset;
+static int qt602240_intr;
+
+static int qt602240_hw_setup(struct i2c_client *client)
+{
+	int err;
+	int intr;
+
+	err = gpio_request(qt602240_intr, "maXTouch-intr");
+	if (err) {
+		dev_err(&client->dev, "GPIO-%d request failed (err %d)\n",
+			qt602240_intr, err);
+		goto err_request_intr;
+	}
+
+	err = gpio_request(qt602240_reset, "maXTouch-reset");
+	if (err) {
+		dev_err(&client->dev, "GPIO-%d request failed (err %d)\n",
+			qt602240_reset, err);
+		goto err_request_reset;
+	}
+
+	err = gpio_direction_output(qt602240_reset, 0);
+	if (err) {
+		dev_err(&client->dev, "GPIO-%d direction set failed (err %d)\n",
+			qt602240_reset, err);
+		goto err_reset_direction;
+	}
+
+	gpio_set_value(qt602240_reset, 1);
+	/* maXTouch wants 40mSec minimum after reset to get organized */
+	/* double that to be safe as a maximum required delay */
+	msleep(80);
+	return 0;
+
+err_reset_direction:
+	gpio_free(qt602240_reset);
+err_request_reset:
+	gpio_free(qt602240_intr);
+err_request_intr:
+	return -EIO;
+}
+
+static void qt602240_hw_teardown(struct i2c_client *client)
+{
+	gpio_set_value(qt602240_reset, 0);
+	gpio_free(qt602240_reset);
+	gpio_free(qt602240_intr);
+}
+
+static void *qt602240_platform_data(void *info)
+{
+	struct i2c_board_info *i2c_info = info;
+	static struct qt602240_platform_data pdata = {
+		.trust_nvm = 1,
+		.hw_setup = qt602240_hw_setup,
+		.hw_teardown = qt602240_hw_teardown,
+	};
+
+	qt602240_reset = get_gpio_by_name("TS0-reset");
+	qt602240_intr = get_gpio_by_name("TS0-intr");
+	if (qt602240_reset < 0  ||  qt602240_intr < 0) {
+		printk(KERN_ERR "Touchscreen-0 GPIOs not in SFI table\n");
+		return NULL;
+	}
+
+	i2c_info->irq = qt602240_intr + MRST_IRQ_OFFSET;
+	return &pdata;
+}
+
 static const struct devs_id device_ids[] = {
 	{"pmic_gpio", SFI_DEV_TYPE_SPI, 1, &pmic_gpio_platform_data},
 	{"pmic_gpio", SFI_DEV_TYPE_IPC, 1, &pmic_gpio_platform_data},
@@ -1053,6 +1124,7 @@ static const struct devs_id device_ids[] = {
 	{"pmic_audio", SFI_DEV_TYPE_IPC, 1, &no_platform_data},
 	{"msic_audio", SFI_DEV_TYPE_SPI, 1, &no_platform_data},
 	{"msic_audio", SFI_DEV_TYPE_IPC, 1, &no_platform_data},
+	{"mXT224", SFI_DEV_TYPE_I2C, 0, &qt602240_platform_data},
 	{"i2c_TC35894-nEB1", SFI_DEV_TYPE_I2C, 0, &tc35894xbg_n_platform_data},
 	{"i2c_TC35894-i", SFI_DEV_TYPE_I2C, 0, &tc35894xbg_i_platform_data},
 	{"bh1770glc", SFI_DEV_TYPE_I2C, 0, &bh1770glc_platform_data_init},

