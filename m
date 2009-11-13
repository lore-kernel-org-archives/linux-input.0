From: miguel.aguilar@ridgerun.com
Subject: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci Keyscan platform data
Date: Fri, 13 Nov 2009 13:43:54 -0600
Message-ID: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:51643 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757124AbZKMTnw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2009 14:43:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org
Cc: todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, Miguel Aguilar <miguel.aguilar@ridgerun.com>

From: Miguel Aguilar <miguel.aguilar@ridgerun.com>

Add a function pointer in the platform data of the DaVinci Keyscan driver
called device_enabled, in order to perform board specific actions when
the device is initialized, like setup the PINMUX configuration.

Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 arch/arm/mach-davinci/include/mach/keyscan.h |    1 +
 drivers/input/keyboard/davinci_keyscan.c     |    8 ++++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/keyscan.h b/arch/arm/mach-davinci/include/mach/keyscan.h
index b4e21a2..7a560e0 100644
--- a/arch/arm/mach-davinci/include/mach/keyscan.h
+++ b/arch/arm/mach-davinci/include/mach/keyscan.h
@@ -29,6 +29,7 @@ enum davinci_matrix_types {
 };
 
 struct davinci_ks_platform_data {
+	int		(*device_enable)(struct device *dev);
 	unsigned short	*keymap;
 	u32		keymapsize;
 	u8		rep:1;
diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index 6e52d85..d410d7a 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -174,6 +174,14 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 	struct davinci_ks_platform_data *pdata = pdev->dev.platform_data;
 	int error, i;
 
+	if (pdata->device_enable) {
+		error = pdata->device_enable(dev);
+		if (error < 0) {
+			dev_dbg(dev, "device enable function failed\n");
+			return error;
+		}
+	}
+
 	if (!pdata->keymap) {
 		dev_dbg(dev, "no keymap from pdata\n");
 		return -EINVAL;
-- 
1.6.0.4

