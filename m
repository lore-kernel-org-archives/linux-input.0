From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCHv2 2/2] Input: ads7846 - configure pendown gpio as input
Date: Thu,  3 Feb 2011 15:18:50 +0530
Message-ID: <1296726530-32199-1-git-send-email-sourav.poddar@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49738 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756060Ab1BCJs7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 3 Feb 2011 04:48:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, charu@ti.com, gadiyar@ti.com, linux-input@vger.kernel.org, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>

The ads7846 driver requests a gpio to detect pendown events,
but does not configure its direction. Configure this gpio
as an input after requesting it.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
changes between v2 and v1: Added return error support in v2. 
 
drivers/input/touchscreen/ads7846.c |    7 +++++++
1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 036f245..f30768b 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -962,6 +962,13 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 		return err;
 	}
 
+	err = gpio_direction_input(pdata->gpio_pendown);
+	if (err) {
+		dev_err(&spi->dev, "failed to configure pendown GPIO input direction %d\n",
+			pdata->gpio_pendown);
+		return err;
+        }
+
 	ts->gpio_pendown = pdata->gpio_pendown;
 
 	return 0;
-- 
1.7.0.4

