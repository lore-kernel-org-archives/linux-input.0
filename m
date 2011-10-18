From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 1/5] input/cma3000_d0x: Support devices without pdata
Date: Tue, 18 Oct 2011 10:28:02 +0200
Message-ID: <1318926486-10330-2-git-send-email-ricardo.ribalda__40951.0362231687$1318926531$gmane$org@gmail.com>
References: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55184 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595Ab1JRI23 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 04:28:29 -0400
In-Reply-To: <1318926486-10330-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Architechtures based on device-tree does not have platform data
associated to the spi/i2c devices.
This patch allows those architechtures to use the cma3000 driver with
a default configuration.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/input/misc/cma3000_d0x.c |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index 1633b63..2f993d5 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -62,6 +62,18 @@
 #define BIT_TO_2G  18
 #define BIT_TO_8G  71
 
+static struct cma3000_platform_data cma3000_default_pdata = {
+	.mdthr = 0x8,
+	.mdfftmr = 0x33,
+	.ffthr = 0x8,
+	.mode = CMAMODE_MEAS400,
+	.g_range = CMARANGE_2G,
+	.fuzz_x = BIT_TO_2G,
+	.fuzz_y = BIT_TO_2G,
+	.fuzz_z = BIT_TO_2G,
+	.irqflags = 0,
+};
+
 struct cma3000_accl_data {
 	const struct cma3000_bus_ops *bus_ops;
 	const struct cma3000_platform_data *pdata;
@@ -283,19 +295,24 @@ EXPORT_SYMBOL(cma3000_resume);
 struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 				       const struct cma3000_bus_ops *bops)
 {
-	const struct cma3000_platform_data *pdata = dev->platform_data;
+	const struct cma3000_platform_data *pdata;
 	struct cma3000_accl_data *data;
 	struct input_dev *input_dev;
 	int rev;
 	int error;
 
+	if (!dev->platform_data) {
+		dev_info(dev, "platform data not found, using default\n");
+		pdata = &cma3000_default_pdata;
+	} else
+		pdata = dev->platform_data;
+
 	if (!pdata) {
 		dev_err(dev, "platform data not found\n");
 		error = -EINVAL;
 		goto err_out;
 	}
 
-
 	/* if no IRQ return error */
 	if (irq == 0) {
 		error = -EINVAL;
-- 
1.7.7

