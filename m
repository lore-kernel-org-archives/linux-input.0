From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH v2] input: ads7846: fix gpio_pendown configuration
Date: Sun,  8 May 2011 11:44:50 +0300
Message-ID: <1304844290-31233-1-git-send-email-grinberg@compulab.co.il>
References: <20110505161356.GF27251@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:41810
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751999Ab1EHIo5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 8 May 2011 04:44:57 -0400
In-Reply-To: <20110505161356.GF27251@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Igor Grinberg <grinberg@compulab.co.il>

The pendown gpio was requested but not configured for input.
Configure it for input.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
v2:	add a separate gpio_direction_input() call
	instead of a single gpio_request_one() call
	so the driver will compile with !CONFIG_GENERIC_GPIO

 drivers/input/touchscreen/ads7846.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1de1c19..886ec55 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -969,6 +969,13 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 				pdata->gpio_pendown);
 			return err;
 		}
+		err = gpio_direction_input(pdata->gpio_pendown);
+		if (err) {
+			dev_err(&spi->dev, "failed to setup pendown GPIO%d\n",
+				pdata->gpio_pendown);
+			gpio_free(pdata->gpio_pendown);
+			return err;
+		}
 
 		ts->gpio_pendown = pdata->gpio_pendown;
 
-- 
1.7.3.4

