From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH 4/7] mfd: cros_ec: move locking into cros_ec_cmd_xfer
Date: Mon, 28 Jul 2014 14:19:24 +0200
Message-ID: <1406549967-21291-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Now that there's a central cros_ec_cmd_xfer(), move the locking
out of the SPI and LPC drivers.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/mfd/cros_ec.c     | 10 +++++++++-
 drivers/mfd/cros_ec_spi.c | 11 -----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index a9faebd..c53804a 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -65,7 +65,13 @@ EXPORT_SYMBOL(cros_ec_check_result);
 int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg)
 {
-	return ec_dev->cmd_xfer(ec_dev, msg);
+	int ret;
+
+	mutex_lock(&ec_dev->lock);
+	ret = ec_dev->cmd_xfer(ec_dev, msg);
+	mutex_unlock(&ec_dev->lock);
+
+	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
@@ -98,6 +104,8 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 			return -ENOMEM;
 	}
 
+	mutex_init(&ec_dev->lock);
+
 	err = mfd_add_devices(dev, 0, cros_devs,
 			      ARRAY_SIZE(cros_devs),
 			      NULL, ec_dev->irq, NULL);
diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 6726f0a..2fcef1a 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -79,13 +79,11 @@
  *	if no record
  * @end_of_msg_delay: used to set the delay_usecs on the spi_transfer that
  *      is sent when we want to turn off CS at the end of a transaction.
- * @lock: mutex to ensure only one user of cros_ec_cmd_xfer_spi at a time
  */
 struct cros_ec_spi {
 	struct spi_device *spi;
 	s64 last_transfer_ns;
 	unsigned int end_of_msg_delay;
-	struct mutex lock;
 };
 
 static void debug_packet(struct device *dev, const char *name, u8 *ptr,
@@ -233,13 +231,6 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	int ret = 0, final_ret;
 	struct timespec ts;
 
-	/*
-	 * We have the shared ec_dev buffer plus we do lots of separate spi_sync
-	 * calls, so we need to make sure only one person is using this at a
-	 * time.
-	 */
-	mutex_lock(&ec_spi->lock);
-
 	len = cros_ec_prepare_tx(ec_dev, ec_msg);
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
@@ -331,7 +322,6 @@ exit:
 	if (ec_msg->command == EC_CMD_REBOOT_EC)
 		msleep(EC_REBOOT_DELAY_MS);
 
-	mutex_unlock(&ec_spi->lock);
 	return ret;
 }
 
@@ -363,7 +353,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	if (ec_spi == NULL)
 		return -ENOMEM;
 	ec_spi->spi = spi;
-	mutex_init(&ec_spi->lock);
 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
 	if (!ec_dev)
 		return -ENOMEM;
-- 
2.0.0.rc2
