From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [RESEND PATCH 5/7] mfd: cros_ec: wait for completion of commands that return IN_PROGRESS
Date: Wed, 20 Aug 2014 14:13:30 +0200
Message-ID: <1408536812-7836-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:43153 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbaHTMOK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2014 08:14:10 -0400
In-Reply-To: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

From: Andrew Bresticker <abrestic@chromium.org>

When an EC command returns EC_RES_IN_PROGRESS, we need to query
the state of the EC until it indicates that it is no longer busy.
Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
it is working on the in-progress command.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
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
2.0.1

