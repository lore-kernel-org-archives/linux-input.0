From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/7] mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC
Date: Mon, 28 Jul 2014 14:19:21 +0200
Message-ID: <1406549967-21291-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Doug Anderson <dianders@chromium.org>

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

Signed-off-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Randall Spangler <rspangler@chromium.org>
Reviewed-by: Vadim Bendebury <vbendeb@chromium.org>
---
 drivers/mfd/cros_ec_spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_spi.c b/drivers/mfd/cros_ec_spi.c
index ac52e36..6726f0a 100644
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
@@ -322,6 +328,9 @@ static int cros_ec_cmd_xfer_spi(struct cros_ec_device *ec_dev,
 
 	ret = len;
 exit:
+	if (ec_msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
 	mutex_unlock(&ec_spi->lock);
 	return ret;
 }
-- 
2.0.0.rc2
