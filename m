From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] Revert "Input: bma150 - avoid binding to bma180 if IIO bma180 driver present" and "Input: bma150 - extend chip detection for bma180"
Date: Sat,  1 Apr 2017 16:44:45 +0200
Message-ID: <631685e1205d8b1b45d61e57070310d89d535b74.1491057884.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:29715 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdDAOo4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 10:44:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Hans de Goede <hdegoede@redhat.com>, Aniroop Mathur <a.mathur@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org

This reverts commit baf28d91e7b1 ("Input: bma150 - avoid binding to bma180 if IIO bma180 driver present")
and commit ef3714fdbc8d ("Input: bma150 - extend chip detection for bma180")

Rationale: initially (2012) the GTA04 device using a bma180 chip simply refereced
the bma150 platform driver in its board file [1] which happened to work in all
scenarios that were tested.

When conversion to DT started (2014), we needed to make the driver be still
recognised. Hence we introduced the compatibility to the bma180 chip in
Linux 3.15-rc5 [2] without further checks if it is really 100% compatible. This
worked flawlessly for years with the GTA04 device.

Recently (2016), Hans de Goede pointed out that the chips are not as similar
as they appeared and the driver works with the bma180 for the GTA04 only
by good luck. He proposed to remove the bma180 support completely [3], but
we still did need it until we have a replacement. Thus, a condifional compile
was added.

We have now developed a generic iio-input-bridge which works with any 2 or
3 axis iio based accelerometer. It has been tested on GTA04 and Pyra and
works as expected. Therefore we can remove the bma180 support from this
driver completely. User-space API compatibility can be restored by using the
iio-input-bridge.

Maybe it is time to convert the bma150 driver to iio as well and retire the
accelerometer input drivers completely but this is a different story and task.

[1]: https://github.com/neilbrown/linux/blob/gta04/3.2.y/arch/arm/mach-omap2/board-omap3gta04.c#L976
[2]: https://patchwork.kernel.org/patch/3961171/
[3]: https://patchwork.kernel.org/patch/9325481/

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/input/misc/bma150.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 1fa8537..1efcfdf 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -70,7 +70,6 @@
 #define BMA150_CFG_5_REG	0x11
 
 #define BMA150_CHIP_ID		2
-#define BMA180_CHIP_ID		3
 #define BMA150_CHIP_ID_REG	BMA150_DATA_0_REG
 
 #define BMA150_ACC_X_LSB_REG	BMA150_DATA_2_REG
@@ -538,13 +537,8 @@ static int bma150_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	/*
-	 * Note if the IIO CONFIG_BMA180 driver is enabled we want to fail
-	 * the probe for the bma180 as the iio driver is preferred.
-	 */
 	chip_id = i2c_smbus_read_byte_data(client, BMA150_CHIP_ID_REG);
-	if (chip_id != BMA150_CHIP_ID &&
-	    (IS_ENABLED(CONFIG_BMA180) || chip_id != BMA180_CHIP_ID)) {
+	if (chip_id != BMA150_CHIP_ID) {
 		dev_err(&client->dev, "BMA150 chip id error: %d\n", chip_id);
 		return -EINVAL;
 	}
@@ -648,9 +642,6 @@ static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
-#if !IS_ENABLED(CONFIG_BMA180)
-	{ "bma180", 0 },
-#endif
 	{ "smb380", 0 },
 	{ "bma023", 0 },
 	{ }
-- 
2.7.3

