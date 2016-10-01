From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] Input: synaptics-rmi4 - Fix error handling in SPI transport driver
Date: Fri, 30 Sep 2016 20:12:53 -0700
Message-ID: <1475291573-20393-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Andrew Duggan <aduggan@synaptics.com>
List-Id: linux-input@vger.kernel.org

Instantiating the rmi4 SPI transport driver without an interrupt assigned
caused the driver to fail to load, but it does not clean up its transport
device registration. Result may be a crash at a later time, for example
when rebooting the system.

Fixes: 8d99758dee31 ("Input: synaptics-rmi4 - add SPI transport driver")
Cc: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/rmi4/rmi_spi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_spi.c b/drivers/input/rmi4/rmi_spi.c
index 55bd1b34970c..f8484b7cdead 100644
--- a/drivers/input/rmi4/rmi_spi.c
+++ b/drivers/input/rmi4/rmi_spi.c
@@ -466,8 +466,10 @@ static int rmi_spi_probe(struct spi_device *spi)
 	}
 
 	retval = rmi_spi_init_irq(spi);
-	if (retval < 0)
+	if (retval < 0) {
+		rmi_unregister_transport_device(&rmi_spi->xport);
 		return retval;
+	}
 
 	dev_info(&spi->dev, "registered RMI SPI driver\n");
 	return 0;
-- 
2.5.0
