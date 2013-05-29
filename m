From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] drivers/iio: am335x_adc: cleanup on missing DT nodes
Date: Wed, 29 May 2013 19:09:52 +0200
Message-ID: <1369847397-27451-2-git-send-email-bigeasy@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57928 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759696Ab3E2RKD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 May 2013 13:10:03 -0400
In-Reply-To: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com, balbi@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Currently we leak indio_dev() if the DT has no "adc" node in it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index d0317fc..b2f27de 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -208,8 +208,10 @@ static int tiadc_probe(struct platform_device *pdev)
 	adc_dev->mfd_tscadc = tscadc_dev;
 
 	node = of_get_child_by_name(node, "adc");
-	if (!node)
-		return  -EINVAL;
+	if (!node) {
+		err = -EINVAL;
+		goto err_free_device;
+	}
 	err = of_property_read_u32(node,
 			"ti,adc-channels", &val32);
 	if (err < 0)
-- 
1.7.10.4

