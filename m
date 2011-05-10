From: <michael.hennerich@analog.com>
Subject: [PATCH 4/5] input: misc: AD714x: Add option to specify irqflags
Date: Tue, 10 May 2011 13:35:08 +0200
Message-ID: <1305027309-17637-4-git-send-email-michael.hennerich@analog.com>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:1828 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795Ab1EJLoh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 May 2011 07:44:37 -0400
In-Reply-To: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Add option to specify irqflags.
Use IRQF_TRIGGER_LOW | IRQF_ONESHOT if not set otherwise.
Update copyright notice.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x.c  |    4 +++-
 include/linux/input/ad714x.h |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 89554eb..3e97879 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -1268,7 +1268,9 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	}
 
 	error = request_threaded_irq(ad714x->irq, NULL, ad714x_interrupt_thread,
-			IRQF_TRIGGER_FALLING, "ad714x_captouch", ad714x);
+			plat_data->irqflags ? plat_data->irqflags :
+			IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			"ad714x_captouch", ad714x);
 	if (error) {
 		dev_err(dev, "can't allocate irq %d\n", ad714x->irq);
 		goto err_unreg_dev;
diff --git a/include/linux/input/ad714x.h b/include/linux/input/ad714x.h
index 0cbe5e8..d388d85 100644
--- a/include/linux/input/ad714x.h
+++ b/include/linux/input/ad714x.h
@@ -6,7 +6,7 @@
  * The platform_data for the device's "struct device" holds this
  * information.
  *
- * Copyright 2009 Analog Devices Inc.
+ * Copyright 2009-2011 Analog Devices Inc.
  *
  * Licensed under the GPL-2 or later.
  */
@@ -58,6 +58,7 @@ struct ad714x_platform_data {
 	struct ad714x_button_plat *button;
 	unsigned short stage_cfg_reg[STAGE_NUM][STAGE_CFGREG_NUM];
 	unsigned short sys_cfg_reg[SYS_CFGREG_NUM];
+	unsigned long irqflags;
 };
 
 #endif
-- 
1.6.0.2


