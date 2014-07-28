From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 5/7] mfd: cros_ec: wait for completion of commands that return IN_PROGRESS
Date: Mon, 28 Jul 2014 14:19:25 +0200
Message-ID: <1406549967-21291-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1406549967-21291-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Andrew Bresticker <abrestic@chromium.org>

When an EC command returns EC_RES_IN_PROGRESS, we need to query
the state of the EC until it indicates that it is no longer busy.
Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
it is working on the in-progress command.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/mfd/cros_ec.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index c53804a..634c434 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -23,6 +23,10 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
+#include <linux/delay.h>
+
+#define EC_COMMAND_RETRIES	50
+#define EC_RETRY_DELAY_MS	10
 
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg)
@@ -65,10 +69,39 @@ EXPORT_SYMBOL(cros_ec_check_result);
 int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg)
 {
-	int ret;
+	int ret, i;
 
 	mutex_lock(&ec_dev->lock);
 	ret = ec_dev->cmd_xfer(ec_dev, msg);
+	if (ret == -EAGAIN && msg->result == EC_RES_IN_PROGRESS) {
+		/*
+		 * Query the EC's status until it's no longer busy or
+		 * we encounter an error.
+		 */
+		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
+			struct cros_ec_command status_msg;
+			struct ec_response_get_comms_status status;
+
+			msleep(EC_RETRY_DELAY_MS);
+
+			status_msg.version = 0;
+			status_msg.command = EC_CMD_GET_COMMS_STATUS;
+			status_msg.outdata = NULL;
+			status_msg.outsize = 0;
+			status_msg.indata = (uint8_t *)&status;
+			status_msg.insize = sizeof(status);
+
+			ret = ec_dev->cmd_xfer(ec_dev, &status_msg);
+			if (ret < 0)
+				break;
+
+			msg->result = status_msg.result;
+			if (status_msg.result != EC_RES_SUCCESS)
+				break;
+			if (!(status.flags & EC_COMMS_STATUS_PROCESSING))
+				break;
+		}
+	}
 	mutex_unlock(&ec_dev->lock);
 
 	return ret;
-- 
2.0.0.rc2
