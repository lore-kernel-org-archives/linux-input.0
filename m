From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH v4 1/5] mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC
Date: Thu, 18 Sep 2014 17:18:54 +0200
Message-ID: <1411053538-17237-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411053538-17237-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

If someone sends a EC_CMD_REBOOT_EC to the EC, the EC will likely be
unresponsive for quite a while.  Add a delay to the end of the command
to prevent random failures of future commands.

NOTES:
* This could be optimized a bit by simply delaying the next command
  sent, but EC_CMD_REBOOT_EC is such a rare command that the extra
  complexity doesn't seem worth it.
* This is a bit of an "ugly hack" since the SPI driver is effectively
  snooping on the communication and making a lot of assumptions.  It
  would be nice to architect in some better solution long term.
* This same logic probably needs to be applied to the i2c driver.

Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Randall Spangler <rspangler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Vadim Bendebury <vbendeb-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/mfd/cros_ec_spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index 588c700..b396705 100644
--- a/drivers/mfd/cros_ec_spi.c
+++ b/drivers/mfd/cros_ec_spi.c
@@ -65,6 +65,12 @@
   */
 #define EC_SPI_RECOVERY_TIME_NS	(200 * 1000)
 
+/*
+ * The EC is unresponsive for a time after a reboot command.  Add a
+ * simple delay to make sure that the bus stays locked.
+ */
+#define EC_REBOOT_DELAY_MS	50
+
 /**
  * struct cros_ec_spi - information about a SPI-connected EC
  *
@@ -318,6 +324,9 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 
 	ret = len;
 exit:
+	if (ec_msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
 	mutex_unlock(&ec_spi->lock);
 	return ret;
 }
-- 
2.1.0
