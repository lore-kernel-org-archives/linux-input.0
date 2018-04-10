From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v3 06/11] iio: inkern: add module put/get on iio dev module when requesting channels
Date: Tue, 10 Apr 2018 11:57:52 +0300
Message-ID: <1523350677-27106-7-git-send-email-eugen.hristev@microchip.com>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

When requesting channels for a particular consumer device,
besides requesting the device (incrementing the reference counter), also
do it for the driver module of the iio dev. This will avoid the situation
where the producer IIO device can be removed and the consumer is still
present in the kernel.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/inkern.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ec98790..68d9b87 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -11,6 +11,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/module.h>
 
 #include <linux/iio/iio.h>
 #include "iio_core.h"
@@ -152,6 +153,7 @@ static int __of_iio_channel_get(struct iio_channel *channel,
 	if (index < 0)
 		goto err_put;
 	channel->channel = &indio_dev->channels[index];
+	try_module_get(channel->indio_dev->driver_module);
 
 	return 0;
 
@@ -256,8 +258,10 @@ static struct iio_channel *of_iio_channel_get_all(struct device *dev)
 	return chans;
 
 error_free_chans:
-	for (i = 0; i < mapind; i++)
+	for (i = 0; i < mapind; i++) {
+		module_put(chans[i].indio_dev->driver_module);
 		iio_device_put(chans[i].indio_dev);
+	}
 	kfree(chans);
 	return ERR_PTR(ret);
 }
@@ -351,6 +355,7 @@ void iio_channel_release(struct iio_channel *channel)
 {
 	if (!channel)
 		return;
+	module_put(channel->indio_dev->driver_module);
 	iio_device_put(channel->indio_dev);
 	kfree(channel);
 }
@@ -482,6 +487,7 @@ void iio_channel_release_all(struct iio_channel *channels)
 	struct iio_channel *chan = &channels[0];
 
 	while (chan->indio_dev) {
+		module_put(chan->indio_dev->driver_module);
 		iio_device_put(chan->indio_dev);
 		chan++;
 	}
-- 
2.7.4
