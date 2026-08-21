Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB603CFF61
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348917; cv=none; b=ltLHGEE0Jsf9xHIZyU4/+xL6/gKMh5XKgy7fA9TL5REBBcWCU8CrbKQL0eUSRGj98eLKUNo3995stUY2vBojIJ0giOVfJ6jswibFrzIDUWIytRvYq0WIF5Zl7uDUOeod1ZleNDfq2iuAKv1l+mEZ4UvFat5VWBd+7Xox5RzlXE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348917; c=relaxed/simple;
	bh=CfZT21P85GEFf8O8Ncaky7KiVbD3FZFYVMHqL0pmP0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ShYIN2sbn0NDCoj3SHs8oqHLRsmYdR3oGi+IDGqGK7CqhiIB4P9qiCU1yXjbgEXf+5c06ir8vf6AWHv93nnT89R03//I/XHq3FlTDHlcZz4CnEd2N6mpPvxUs99OwegV6M283Bmu7ALJt1GaFAfcL8AZgILwku+UTXdQoNDfANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYO82/v6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYO82/v6"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1752434a91.2
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 14:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348915; x=1787953715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/zTx8W+lWqDDj6Gv0eCWp/oq1vmj6sVAKi6L2a7La8=;
        b=UYO82/v6mrUr9LYbSRltXMOVzEC+CdKgXSnBK7Wbzks5cmHn2aasJ493ZRE+jY+JKl
         pnELy+cNf4VUPNiUxrLijyXKvK7Ezny4esO0jq8lvSo7Bh+zW21Q+qKDW60GpDIs5eTY
         LmHS9P+RuNUqPWSM4SaAABxZikVB44evaVK5N/i6S6ihZw0CwKGltIwPGF0hkEhwT5Dr
         q962GVR4UzUwPTVKWekbb2Nis7lULwwCSLYIJFzgbtDIXBXH64vC7Yzj2uQqU6YP1cBA
         PePhnM3nKSqgdIxgHfv97RQnS3SUB03zYT7Ldwun+Xe9KefhdfFGKo0apNj/q/f3Jya9
         EJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348915; x=1787953715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/zTx8W+lWqDDj6Gv0eCWp/oq1vmj6sVAKi6L2a7La8=;
        b=lOxQkmwdDBegqexDF8q0UhgYLstwgDLPlaWrnUzVu/ZyKFoCc7polaeVxr7s2Qb27s
         98eLSIC5jRNH85nJB0fWzo5nAVhnWSZ49Jdx5iJaLXYFcKwc4JvEmGzKo282hO3FuaMB
         wDzmB5E0ma+2IqrNzkSObW0MuzAzRcULZtGnOD2YV1Spoxf3UeLL44tNynR0il1SNq19
         gZB/QKfazS5RFXKecoyRiNRDkCjWVSwpvRgm3BipFTkLUvDArzirYzsvdvSZOfmGx4rp
         iHU+8xNr/Rciep45aU7XGmn628EHB9fzpf73paoufBO1w+V0MXWuPOTh0vgp6HxJU/ia
         pBGA==
X-Gm-Message-State: AFuF++mBiG67pWvhXNKSOYge6sWr4JYb3o/SOm65HV33YQ5Ll5BYb+Jf
	W4ihVYePVzlBTZfU8TgMrvllz4Uwy6R2Bb+Q9vHsOAFRVSh+wYwbseXL
X-Gm-Gg: AR+sD10lb+LEKqoO5h93OzV7TA3kB0q8rW+t9/jsHsP+5kEWGjL0VHmpwLPkBMJ1Fru
	qvyhSs4MxYCkO2o21N1lI0zXbiKXFOwjh1RRzcSImR4CA69lvWxBlLtPd6hK7HyBPm+TbvrPooY
	7fZmmfJaJoVGU/GH5oEYhoS5cQqcVD3gFdJN8/1dAH81nBaejKMHit2QCZm3n83R2D0Bo+DEAdz
	f8jhWWIyHtGxy9M5yv0NANZZMPPpMeq+ul125yA3yAq2sgbTtN/y/+hK/CKTPHkSgoKn+ccNGpl
	ZhI2MJUOroaUh4KpdYSHvFIAcQx8w+qTGIttDuR3xhzJt/zhM3W+QJADWuPwPRWkpEPup+cnszX
	bCtWziz9090A0fjHdIFujTQa6wtSj6pJ7j30Sfc8tcGPQaFcxYZKNOdR4AdMKZu5oDw91fTLIT5
	qkl1i2drPj580EVhVxcT1KTuNIcOYvFlFh62Qk2EpPkCO8ySO2N7aRdAlI3eAP51969lsWWHRvG
	pfY0p1Yph50bItYbdQ=
X-Received: by 2002:a17:90b:164a:b0:390:b41a:b92a with SMTP id 98e67ed59e1d1-395deeaa2dfmr2561703a91.4.1787348914967;
        Fri, 21 Aug 2026 14:48:34 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm27276942eec.3.2026.08.21.14.48.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:48:34 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] HID: hid-lenovo-go: return configuration request errors
Date: Sat, 22 Aug 2026 03:18:10 +0530
Message-ID: <20260821214810.87826-6-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821214810.87826-1-mradityadash@gmail.com>
References: <20260821214810.87826-1-mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver completes a pending request when it receives any decoded
configuration reply. It also discards the result of its interruptible wait.
A configuration operation can therefore report success after an unrelated
reply, firmware error, interrupted wait, or timeout.

Track one pending request and match replies by command ID, command,
sub-command, and device. Return output errors, firmware errors, interrupted
waits, and timeouts to the caller. Treat a timeout or interruption as final
if a matching reply arrives after the wait finishes.

Calibration completion is asynchronous, and some Start commands do not send
an immediate reply. Submit each exact calibration command and sub-command
pair once and return its HID output status without a synchronous wait.

The firmware does not include a sequence number. A late reply with the same
complete tuple can still match a newer request.

Fixes: d69ccfcbc955 ("HID: hid-lenovo-go: Add Lenovo Legion Go Series HID Driver")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
On an Original Legion Go, left-joystick Start did not return an
immediate reply in two controller sessions although firmware began
calibration. A focused target-kernel KUnit test covered timeout,
interruption, firmware error, and reply ownership. No natural firmware
rejection was reproduced.

 drivers/hid/hid-lenovo-go.c | 118 ++++++++++++++++++++++++++++++------
 1 file changed, 100 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 1e6915c969d8..a1a255c28e2d 100644
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
@@ -31,13 +32,30 @@
 #include "hid-ids.h"
 
 #define GO_GP_INTF_IN		0x83
+#define GO_INPUT_REPORT_ID	0x04
 #define GO_OUTPUT_REPORT_ID	0x05
 #define GO_GP_RESET_SUCCESS	0x01
 #define GO_PACKET_SIZE		64
 
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
+
+static struct hid_go_cmd go_cmd = {
+	.done = COMPLETION_INITIALIZER(go_cmd.done),
+	.lock = __SPIN_LOCK_UNLOCKED(go_cmd.lock),
+};
+
 static struct hid_go_cfg {
 	struct delayed_work go_cfg_setup;
-	struct completion send_cmd_complete;
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
@@ -331,6 +349,72 @@ static const char *const os_mode_text[] = {
 	[LINUX] = "linux",
 };
 
+static void hid_go_cmd_arm(u8 id, u8 command, u8 sub_command, u8 device)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&go_cmd.lock, flags);
+	reinit_completion(&go_cmd.done);
+	go_cmd.pending = true;
+	go_cmd.id = id;
+	go_cmd.command = command;
+	go_cmd.sub_command = sub_command;
+	go_cmd.device = device;
+	spin_unlock_irqrestore(&go_cmd.lock, flags);
+}
+
+static void hid_go_cmd_consume(const struct command_report *cmd_rep, int result)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&go_cmd.lock, flags);
+	if (go_cmd.pending && cmd_rep->id == go_cmd.id &&
+	    cmd_rep->cmd == go_cmd.command &&
+	    cmd_rep->sub_cmd == go_cmd.sub_command &&
+	    cmd_rep->device_type == go_cmd.device) {
+		go_cmd.pending = false;
+		go_cmd.result = result;
+		complete(&go_cmd.done);
+	}
+	spin_unlock_irqrestore(&go_cmd.lock, flags);
+}
+
+static int hid_go_cmd_finish(long wait_result)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&go_cmd.lock, flags);
+	if (wait_result <= 0) {
+		go_cmd.pending = false;
+		ret = wait_result < 0 ? wait_result : -ETIMEDOUT;
+	} else {
+		ret = go_cmd.result;
+	}
+	spin_unlock_irqrestore(&go_cmd.lock, flags);
+	return ret;
+}
+
+static int hid_go_cmd_cancel(int result)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&go_cmd.lock, flags);
+	go_cmd.pending = false;
+	spin_unlock_irqrestore(&go_cmd.lock, flags);
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
@@ -658,6 +742,8 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (size != GO_PACKET_SIZE)
 		goto passthrough;
+	if (data[0] != GO_INPUT_REPORT_ID)
+		goto passthrough;
 
 	ep = get_endpoint_address(hdev);
 	if (ep != GO_GP_INTF_IN)
@@ -709,7 +795,7 @@ static int hid_go_raw_event(struct hid_device *hdev, struct hid_report *report,
 	dev_dbg(&hdev->dev, "Rx data as raw input report: [%*ph]\n",
 		GO_PACKET_SIZE, data);
 
-	complete(&drvdata.send_cmd_complete);
+	hid_go_cmd_consume(cmd_rep, ret);
 	return ret;
 
 passthrough:
@@ -725,6 +811,7 @@ static int mcu_property_out(struct hid_device *hdev, u8 id, u8 command,
 	u8 header[] = { GO_OUTPUT_REPORT_ID, id, command, index, device };
 	size_t header_size = ARRAY_SIZE(header);
 	int timeout = 50;
+	long wait_result;
 	int ret;
 
 	/* The FPS mode DPI request does not contain a device byte. */
@@ -747,22 +834,19 @@ static int mcu_property_out(struct hid_device *hdev, u8 id, u8 command,
 	dev_dbg(&hdev->dev, "Send data as raw output report: [%*ph]\n",
 		GO_PACKET_SIZE, dmabuf);
 
-	ret = hid_hw_output_report(hdev, dmabuf, GO_PACKET_SIZE);
-	if (ret < 0)
-		return ret;
+	if (id == MCU_CONFIG_DATA &&
+	    ((command == SET_TRIGGER_CFG && index == TRIGGER_CALIBRATE) ||
+	     (command == SET_JOYSTICK_CFG && index == JOYSTICK_CALIBRATE) ||
+	     (command == SET_GYRO_CFG && index == GYRO_CALIBRATE)))
+		return hid_go_send_output_report(hdev, dmabuf);
 
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
-
-	reinit_completion(&drvdata.send_cmd_complete);
-	return 0;
+		return hid_go_cmd_cancel(ret);
+	wait_result = wait_for_completion_interruptible_timeout(&go_cmd.done,
+								msecs_to_jiffies(timeout));
+	return hid_go_cmd_finish(wait_result);
 }
 
 static ssize_t version_show(struct device *dev, struct device_attribute *attr,
@@ -2395,8 +2479,6 @@ static int hid_go_cfg_probe(struct hid_device *hdev,
 
 	drvdata.led_cdev = &go_cdev_rgb.led_cdev;
 
-	init_completion(&drvdata.send_cmd_complete);
-
 	/* Executing calls prior to returning from probe will lock the MCU. Schedule
 	 * initial data call after probe has completed and MCU can accept calls.
 	 */
-- 
2.55.0

