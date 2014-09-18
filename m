From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCH v4 5/5] mfd: cros_ec: wait for completion of commands that return IN_PROGRESS
Date: Thu, 18 Sep 2014 17:18:58 +0200
Message-ID: <1411053538-17237-6-git-send-email-javier.martinez@collabora.co.uk>
References: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1411053538-17237-1-git-send-email-javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Gwendal Grignou <gwendal-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

When an EC command returns EC_RES_IN_PROGRESS, we need to query
the state of the EC until it indicates that it is no longer busy.
Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
commands (e.g. keyboard, I2C passtru) aren't issued to the EC while
it is working on the in-progress command.

The 10 milliseconds delay and the number of retries are the values
that were used by the flashrom tool when retrying commands.

Signed-off-by: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Reviewed-by: Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
---

Changes since v3:
 - Fix us time and use raw values instead of a define. Suggested by Lee Jones.

Changes since v2:
 - Explain in the commit message from where the delay and retry values come from.
   Commented by Andrew Bresticker.
 - Move the needed definitions inside the if block. Suggested by Lee Jones.
 - Only check if result is EC_RES_IN_PROGRESS instead of checking also if ret is
   -EAGAIN since the former implies the later. Suggested by Lee Jones.
 - Use usleep_range() instead of msleep() since doesn't handle values between 1~20.
   Suggested by Lee Jones.

Changes since v1:
 - The *xfer() calls don't modify the passed cros_ec_command so there is
   no need to populate it inside the for loop. Suggested by Lee Jones.

 drivers/mfd/cros_ec.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index c53804a..fc0c81e 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -23,6 +23,9 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/cros_ec.h>
 #include <linux/mfd/cros_ec_commands.h>
+#include <linux/delay.h>
+
+#define EC_COMMAND_RETRIES	50
 
 int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 		       struct cros_ec_command *msg)
@@ -69,6 +72,36 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 
 	mutex_lock(&ec_dev->lock);
 	ret = ec_dev->cmd_xfer(ec_dev, msg);
+	if (msg->result == EC_RES_IN_PROGRESS) {
+		int i;
+		struct cros_ec_command status_msg;
+		struct ec_response_get_comms_status status;
+
+		status_msg.version = 0;
+		status_msg.command = EC_CMD_GET_COMMS_STATUS;
+		status_msg.outdata = NULL;
+		status_msg.outsize = 0;
+		status_msg.indata = (uint8_t *)&status;
+		status_msg.insize = sizeof(status);
+
+		/*
+		 * Query the EC's status until it's no longer busy or
+		 * we encounter an error.
+		 */
+		for (i = 0; i < EC_COMMAND_RETRIES; i++) {
+			usleep_range(10000, 11000);
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
2.1.0
