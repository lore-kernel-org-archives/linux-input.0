Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5D936B932
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244592; cv=none; b=eIj/F5GH0QTyPaaLqoYL3e5balEKMjH9kJyxrOSHxgwt6QS0dmFnU3Sh826QRMc+4EKwK4kijduIbC3t0+BXOCqJW9LkIVPce6Zf3AMARjwndaVTeqZHCjRy86nh6N0W6HbVeZzKIwcQBFlbnmLrOsMTN6uRCN1lRQwx5SJTU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244592; c=relaxed/simple;
	bh=OK66Pj7nY5BbXH42rp4i9E2XMj8PlRkGTHWhbDbet0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OYdWOEYTdWOpyhhr8X1FQflzBOvx8W9PzGi5wsFTIOSij5e82VHLjLs4ZQ3uNbRVRU2u7j8cW4pVvCbFaYV4wvUeJ/XfgSyuHkhB0SsOoiO1AiU435FLtQTyIQPqcfXb6aRDsEsZE6WGpRSgKh2PcYjuadtdSF94vrUIuvfg0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEkJ3E/6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEkJ3E/6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso4650467a91.0
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244589; x=1788849389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++ydc5oOA7Xjdiv/75GclRci10VVs2LubMQfzql8oQk=;
        b=FEkJ3E/6vjWDPiifd5GvJDXdxAcgXfVkTRF990he4IEFgzSk6QRImz4udeXWcdHBox
         LZgw2Cv56XGekrC09JMvXUJf/J0AQV25jA/0ZIAxsz/QyBxzcnnCROGQhOB/DgW68XKn
         xnnmwrcHOJiiuKYSvKhq4psduX051La9l4twKYnzrFg4YeRJZUP4Swj+CA9digB6DukV
         y8osC8I2bj3IcaRw1eUpxsPc4JcryHuicCYcrlmyp3ku22pOFgWNCurOesEhzzf6gtZg
         MdfXf8pNncn+E3JOQummaOHHzzNp1l4+0canCUQWs7d2LOr3SXUoiQ6oTXvl/9CqTqxb
         oKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244589; x=1788849389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=++ydc5oOA7Xjdiv/75GclRci10VVs2LubMQfzql8oQk=;
        b=KwSL7Wsrb3xub12gnsknQMwLD4cUCJJyLaXZGB0IX6hTYC2UdSeXXJbH0dnR3flYJp
         BN6mDkR12XW4YJLuGdQBDEAdjwrnjcKt9VnjV5fGZfAIQWRTla1gAOcUjHYZc8LIrZ9V
         6WK0KMdPEaqMl5tW/tl2u067NpgCEgxYzyANRtg6vMIK/wDIq8SxWj1T8TLKhluTsuiL
         E222LKfEAaaFeiFx8ka+4qxj0ay/kpj0+/OZuo0xTEl4PLR2GMBLYtzzUjvsDC4xpv68
         ri4JhR7RcEltNkLqRaG2FolOOaGfsxNisdmA46Aw9vbk8kYh5QHrpR33nbuNQrzzDtV4
         V8Jw==
X-Gm-Message-State: AFuF++lEq3aSUmn+z7F6Pzzjr/cyMg4JiONNZ1OokBSjOkiBBtUHwCvi
	hmP3OK4/xG+Oirc61cVkA5+7nDmecUUUFqMgIQGmgJCpVmrF4zhqxftL
X-Gm-Gg: AYBFou0Cc2p02pHB0C5bl4lUuMvtqHTUAzIpGT7kNR0jW2alJz3cBGQQ6L0Z4GPe13/
	+rzigB0+UsJcTfGwEhKZVndREKwz0nxPxF+tcqLK24VM5E2GFwxZDT3+vcUkQNenCJdutyRFrnt
	U8VIKmKbRtlL1eJ9IThE9Y02Ky6KXUpifVsXe4QzN8VVwRvOQo3yGswV3ENmWmsKH/1sYh5ndBN
	wwfVTA6jxfh7iGSgRE+q70RiTkQex0e4Z3zFHNLpBTkl7LUUcLnF5DxFcJkcE6gW37Yo4b8lB83
	x9EQSbADNub/jGLkKSEFhWsyi9GFp2nTiECLxey175IODU1JOVhZAEm9T81WOiCXNZEnUr7iyfr
	05d8x2Zd74tZ2JAummB8/BlC2ebU5x4VtdC2YiA5Z66yfKf42+wT8PHtnxbtNj5fI32vpTR3Yh/
	nLPl5kb3tIdIJfKGP0CXkvpoESWJ4WrEwVxC9Yik1skH4MCDGwEUNpxW3iBd3tZlWRbV55oGvuz
	BM8wzmO2vf6Eg==
X-Received: by 2002:a17:90b:4c8a:b0:398:dcfe:967a with SMTP id 98e67ed59e1d1-398dcfe9ebfmr15735500a91.17.1788244588820;
        Mon, 31 Aug 2026 23:36:28 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:28 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] HID: hid-lenovo-go: return configuration request errors
Date: Tue,  1 Sep 2026 12:06:05 +0530
Message-ID: <28ecf20c7406e9416d38bac1e7b89ac796b39a59.1788222001.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788222001.git.mradityadash@gmail.com>
References: <cover.1788222001.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any decoded configuration reply completes the shared completion. The driver
also ignores the result of its interruptible wait. An unrelated reply, a
firmware error, an interrupted wait, or a timeout can therefore be reported
as success.

Add pending command state to the driver data. Match replies by command ID,
command, sub-command, and device, and return request errors to the caller.
Clear the pending request after an interruption or timeout so a late reply
cannot replace that result.

Keep the existing 50 ms wait for every configuration request. Corrected
calibration requests on an Original Legion Go received their matching SET
replies within 8 ms. The final calibration result remains asynchronous.

The firmware has no sequence number. A late reply with the same tuple can
still match a newer request.

Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 109 +++++++++++++++++++++++++++++-------
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 51e3112780e1..deed7acd2dc4 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -21,6 +21,7 @@
 #include <linux/led-class-multicolor.h>
 #include <linux/mutex.h>
 #include <linux/printk.h>
+#include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/unaligned.h>
@@ -31,13 +32,27 @@
 #include "hid-ids.h"
 
 #define GO_GP_INTF_IN		0x83
+#define GO_INPUT_REPORT_ID	0x04
 #define GO_OUTPUT_REPORT_ID	0x05
 #define GO_GP_RESET_SUCCESS	0x01
 #define GO_PACKET_SIZE		64
+#define GO_COMMAND_TIMEOUT_MS	50
+
+/* Lenovo replies identify a command and a sub-command, but have no sequence. */
+struct hid_go_cmd {
+	struct completion done;
+	spinlock_t lock; /* protects fields below */
+	bool pending;
+	u8 id;
+	u8 command;
+	u8 sub_command;
+	u8 device;
+	int result;
+};
 
 static struct hid_go_cfg {
 	struct delayed_work go_cfg_setup;
-	struct completion send_cmd_complete;
+	struct hid_go_cmd cmd;
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
@@ -331,6 +346,62 @@ static const char *const os_mode_text[] = {
 	[LINUX] = "linux",
 };
 
+static void hid_go_cmd_arm(u8 id, u8 command, u8 sub_command, u8 device)
+{
+	guard(spinlock_irqsave)(&drvdata.cmd.lock);
+
+	reinit_completion(&drvdata.cmd.done);
+	drvdata.cmd.pending = true;
+	drvdata.cmd.id = id;
+	drvdata.cmd.command = command;
+	drvdata.cmd.sub_command = sub_command;
+	drvdata.cmd.device = device;
+}
+
+static void hid_go_cmd_consume(const struct command_report *cmd_rep, int result)
+{
+	guard(spinlock_irqsave)(&drvdata.cmd.lock);
+
+	if (drvdata.cmd.pending && cmd_rep->id == drvdata.cmd.id &&
+	    cmd_rep->cmd == drvdata.cmd.command &&
+	    cmd_rep->sub_cmd == drvdata.cmd.sub_command &&
+	    cmd_rep->device_type == drvdata.cmd.device) {
+		drvdata.cmd.pending = false;
+		drvdata.cmd.result = result;
+		complete(&drvdata.cmd.done);
+	}
+}
+
+static int hid_go_cmd_finish(long wait_result)
+{
+	guard(spinlock_irqsave)(&drvdata.cmd.lock);
+
+	if (wait_result <= 0) {
+		drvdata.cmd.pending = false;
+		return wait_result < 0 ? wait_result : -ETIMEDOUT;
+	}
+
+	return drvdata.cmd.result;
+}
+
+static int hid_go_cmd_cancel(int result)
+{
+	guard(spinlock_irqsave)(&drvdata.cmd.lock);
+
+	drvdata.cmd.pending = false;
+	return result;
+}
+
+static int hid_go_send_output_report(struct hid_device *hdev, u8 *packet)
+{
+	int ret;
+
+	ret = hid_hw_output_report(hdev, packet, GO_PACKET_SIZE);
+	if (ret < 0)
+		return ret;
+	return ret == GO_PACKET_SIZE ? 0 : -EINVAL;
+}
+
 static int hid_go_version_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -654,7 +725,7 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 	struct command_report *cmd_rep;
 	int ep, ret;
 
-	if (size != GO_PACKET_SIZE)
+	if (size != GO_PACKET_SIZE || data[0] != GO_INPUT_REPORT_ID)
 		goto passthrough;
 
 	ep = get_endpoint_address(hdev);
@@ -707,7 +778,7 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_PACKET_SIZE, data);
 
-	complete(&drvdata.send_cmd_complete);
+	hid_go_cmd_consume(cmd_rep, ret);
 	return ret;
 
 passthrough:
@@ -722,7 +793,8 @@ static int mcu_property_out(struct hid_device *hdev, u8 id, u8 command,
 	unsigned char *dmabuf __free(kfree) = NULL;
 	u8 header[] = { GO_OUTPUT_REPORT_ID, id, command, index, device };
 	size_t header_size = ARRAY_SIZE(header);
-	int timeout = 50;
+	unsigned long timeout = msecs_to_jiffies(GO_COMMAND_TIMEOUT_MS);
+	long wait_result;
 	int ret;
 
 	if (header_size + len > GO_PACKET_SIZE)
@@ -740,22 +812,14 @@ static int mcu_property_out(struct hid_device *hdev, u8 id, u8 command,
 	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
 		GO_PACKET_SIZE, dmabuf);
 
-	ret = hid_hw_output_report(hdev, dmabuf, GO_PACKET_SIZE);
-	if (ret < 0)
-		return ret;
-
-	ret = ret == GO_PACKET_SIZE ? 0 : -EINVAL;
+	hid_go_cmd_arm(id, command, index, device);
+	ret = hid_go_send_output_report(hdev, dmabuf);
 	if (ret)
-		return ret;
-
-	ret = wait_for_completion_interruptible_timeout(&drvdata.send_cmd_complete,
-							msecs_to_jiffies(timeout));
-
-	if (ret == 0) /* timeout occurred */
-		ret = -EBUSY;
+		return hid_go_cmd_cancel(ret);
 
-	reinit_completion(&drvdata.send_cmd_complete);
-	return 0;
+	wait_result = wait_for_completion_interruptible_timeout(&drvdata.cmd.done,
+								timeout);
+	return hid_go_cmd_finish(wait_result);
 }
 
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
@@ -2362,9 +2426,9 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 	if (!buf)
 		return -ENOMEM;
 
+	mutex_init(&drvdata.cfg_mutex);
 	hid_set_drvdata(hdev, &drvdata);
 	drvdata.hdev = hdev;
-	mutex_init(&drvdata.cfg_mutex);
 
 	ret = sysfs_create_groups(&hdev->dev.kobj, top_level_attr_groups);
 	if (ret) {
@@ -2435,8 +2499,11 @@ static int hid_go_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	ep = get_endpoint_address(hdev);
-	if (ep == GO_GP_INTF_IN)
-		init_completion(&drvdata.send_cmd_complete);
+	if (ep == GO_GP_INTF_IN) {
+		init_completion(&drvdata.cmd.done);
+		spin_lock_init(&drvdata.cmd.lock);
+		drvdata.cmd.pending = false;
+	}
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
-- 
2.55.0

