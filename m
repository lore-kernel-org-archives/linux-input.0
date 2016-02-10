From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: colibri ts: include linux/of.h explicitly
Date: Wed, 10 Feb 2016 16:10:42 +0100
Message-ID: <1455117056-2975628-1-git-send-email-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:51825 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcBJPL2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2016 10:11:28 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Sanchayan Maity <maitysanchayan@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The newly added driver calls functions for accessing the DT but
does not include the header they are defined in, which fails
in configurations in which we don't get the header implicitly
through something else:

drivers/input/touchscreen/colibri-vf50-ts.c: In function 'vf50_ts_probe':
drivers/input/touchscreen/colibri-vf50-ts.c:302:10: error: implicit declaration of function 'of_property_read_u32' [-Werror=implicit-function-declaration]

This adds an explict #include, to ensure we can always build it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 48ead50c1dd8 ("Input: Add touchscreen support for Colibri VF50")
---
 drivers/input/touchscreen/colibri-vf50-ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
index 5d4903a402cc..69828d015d45 100644
--- a/drivers/input/touchscreen/colibri-vf50-ts.c
+++ b/drivers/input/touchscreen/colibri-vf50-ts.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-- 
2.7.0

