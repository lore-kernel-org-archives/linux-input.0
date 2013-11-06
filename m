From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] Input: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Wed, 6 Nov 2013 15:54:32 +0800
Message-ID: <1383724472-15475-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>
List-Id: linux-input@vger.kernel.org

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 drivers/input/touchscreen/cyttsp4_spi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_spi.c b/drivers/input/touchscreen/cyttsp4_spi.c
index a71e114..b19434c 100644
--- a/drivers/input/touchscreen/cyttsp4_spi.c
+++ b/drivers/input/touchscreen/cyttsp4_spi.c
@@ -171,10 +171,7 @@ static int cyttsp4_spi_probe(struct spi_device *spi)
 	ts = cyttsp4_probe(&cyttsp_spi_bus_ops, &spi->dev, spi->irq,
 			  CY_SPI_DATA_BUF_SIZE);
 
-	if (IS_ERR(ts))
-		return PTR_ERR(ts);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ts);
 }
 
 static int cyttsp4_spi_remove(struct spi_device *spi)
-- 
1.8.3.1
