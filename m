From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 4/5] mfd: cros_ec: move locking into cros_ec_cmd_xfer
Date: Thu, 18 Sep 2014 17:18:57 +0200
Message-ID: <1411053538-17237-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Gwendal Grignou <gwendal@google.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-input@vger.kernel.org

From: Andrew Bresticker <abrestic@chromium.org>

Now that there's a central cros_ec_cmd_xfer(), move the locking
out of the SPI driver.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Changes since v1:
 - Remove mention of LPC driver in the commit message since it does not
   exist in mainline yet. Suggested by Doug Anderson.

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
index b396705..bf6e08e 100644
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
@@ -232,13 +230,6 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 	int sum;
 	int ret = 0, final_ret;
 
-	/*
-	 * We have the shared ec_dev buffer plus we do lots of separate spi_sync
-	 * calls, so we need to make sure only one person is using this at a
-	 * time.
-	 */
-	mutex_lock(&ec_spi->lock);
-
 	len = cros_ec_prepare_tx(ec_dev, ec_msg);
 	dev_dbg(ec_dev->dev, "prepared, len=%d\n", len);
 
@@ -327,7 +318,6 @@ exit:
 	if (ec_msg->command == EC_CMD_REBOOT_EC)
 		msleep(EC_REBOOT_DELAY_MS);
 
-	mutex_unlock(&ec_spi->lock);
 	return ret;
 }
 
@@ -359,7 +349,6 @@ static int cros_ec_spi_probe(struct spi_device *spi)
 	if (ec_spi == NULL)
 		return -ENOMEM;
 	ec_spi->spi = spi;
-	mutex_init(&ec_spi->lock);
 	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
 	if (!ec_dev)
 		return -ENOMEM;
-- 
2.1.0
