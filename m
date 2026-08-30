Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD635C180
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788101850; cv=none; b=chRPHaxJZ6zGgj4fLsIWoJ7ThzMCJfEoaau+N/nNWvWq3yGHPEKP9rHRgA7XCIAmaJuE8Oe8nL3qAFDJXbbak533TXSAgJvKNja8sVFUOQMjKn9Hk5Tj3uqZEaSDl3vH26T0/Ejcjh89w+nZhS/JTSGlnTh1fNbvkbVzl/VFpuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788101850; c=relaxed/simple;
	bh=kyvKj4aiWZsKk79+pNQWhtdDGQxbcy8DpffoE6tdXoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2U4Zs6T6bFxK2ykhqvdi7J9MqPvEwCgbBv6JtkCrPDlX/hjjRTP5QMdfZ7NUm3oAtYkIGVu18jvPEzNdkF7a0r2ZNHGsO15GfdoEvqhIlyw7hHllppSQtIfNlOwKnAnthYg1DRRx0zmra+SGiGiV1gza07vGSfg5ox+hASXGm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtJchbg4; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtJchbg4"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so2345106a12.3
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788101848; x=1788706648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oJZEG3Xp29mb0hdnLyMA9g/sKI7+pcsw2OATsKuZZuU=;
        b=WtJchbg4LUckSdKeFZTWm3PvYIabhUE5bPOz/fuHIM6PdM69b+YUooxwOMwaWrxDDF
         rQkiGcrH6xYEnBPZXY6k58oKdyLWwcB9JhbLDCLQ4hMf9KvilE1XO4huzArhgDQa/Nun
         xOzG8p/KCm03U/EZrDgIQBGxja6r/ubpytbSJTBhZqPPpQne9Zh3UxsQfZ6QI3Ifdb02
         PFXrMtxW/BXd/xILLQnGlAi4j1dE/7fJjMfLM/oewLVJTReTjx7KGJaL5zTxcIGls8bH
         31U6g8GQQBTKQPyExWdnlW9HID3KALC51joREh9qgVHDcMFAMWl+jezCbD07IpzScvWC
         4nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788101848; x=1788706648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oJZEG3Xp29mb0hdnLyMA9g/sKI7+pcsw2OATsKuZZuU=;
        b=Gn9qS7WLj3DkcD8hyHXyF8Ja6x037otIAgDRPGig5xySBgv9NrASh+ZcL66POd5m5I
         /4W7jbvcdee3t3TY2qclpV5LQ/JDw8gXeb2X4auJ9kwAua2Oc9rNwIPp12yDc1RjR6zF
         FUAn2GaDr3m8JFwehMtMr0/sruIWrmvoDMVn2khtou0cGuh0kN3ahemjODmROcSXrdLK
         VJ7nzKNhHe8qUoz6eIPA7atBZkvtpahE+FloFlNaeAah2++D0EF0PHHAdrfiNPIoURUt
         zEqnequz5dSxIrdzb+rhw557G/Vr0hOzzdCZEwVLkqk4x4KcZAO1/RjeoLSjvNioc4Cd
         ipZQ==
X-Gm-Message-State: AFuF++kwqk7NvSR3To7LYHVkQxHoho3uVrxHCFFwfeYUwdZcWSSP52ca
	rWAuS4nKe8BfEbjts1DL7CHrbtekpfsJQw+/7dyiYu2SGI0wy3ZDsxuz
X-Gm-Gg: AYBFou3lrWxPc4aTog8xI3Q1csnIC/f/+MxFh9nrZreLJWACPU9uTWkrvTiVXmqF+Wv
	hLPsISBHoJTHFLnkITk/X20IyJHzpgAXLpwohLlqEsdHfmXxS4Fb2DPbsWh5NXA9HxujgxGMYcZ
	v/OUei1EEv/q5T4Uj4oCZdfjYAQ08HKSfVz5k/YX/hQKrolNnTZWM0mG57QjKsbAG47xgy1VE0d
	BhqPDUJyclGKlYUKI7fR+Fmlk7O6OHKQb0jmzNVVDqApf6VYAw8cPSWqfIhPQ2JoZo6Ew5LIDeT
	h76BnqR/4w9FZjh+NBN/vji9J8vFZTvAEl6J7k/PS9AJDEivuQGCdDqpbM8EIeFZQUnKRC+Rxby
	BGyDw6lQQodHsV6HmSxB/P2kNCX/KcrjE4rDkbbJIe4EExPxvohiD/MF4GMOYJ06hLvsUvGILrj
	PHzPXW5NE4iZxBmdB4Wc1G9f9xZNdjy/fb4zG+nErG9nWA7dM7ZmXxgx9iFkcSWoYlWC2XiaVPs
	9ERm7qI+2mYUiqcb1k=
X-Received: by 2002:a17:90b:3c83:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-3989bd54c84mr18297077a91.18.1788101847980;
        Sun, 30 Aug 2026 07:57:27 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f959575sm23198024eec.15.2026.08.30.07.57.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 07:57:27 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] HID: hid-lenovo-go: clear calibration status on start
Date: Sun, 30 Aug 2026 20:26:58 +0530
Message-ID: <931a17ea1ce972af018252681a253a21465ad494.1788096668.git.mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788096666.git.mradityadash@gmail.com>
References: <cover.1788096666.git.mradityadash@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A completed calibration leaves success or failure in its status file. If
the next calibration has the same result, userspace sees no change and
cannot tell when the new attempt starts or finishes.

Link each calibration action attribute to its status field. Set only that
field to unknown before submitting Start. Stop leaves the status unchanged,
and the next firmware result replaces unknown with success or failure.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index a4231d188b7a..2ed367abd4cc 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -111,6 +111,11 @@ struct go_cfg_attr {
 	u8 index;
 };
 
+struct go_cal_cfg_attr {
+	u8 index;
+	u8 *status;
+};
+
 struct command_report {
 	u8 report_id;
 	u8 id;
@@ -1410,7 +1415,8 @@ static ssize_t device_status_show(struct device *dev,
 static ssize_t calibrate_config_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, u8 cmd, u8 sub_cmd,
-				      size_t count, enum dev_type device_type)
+				      size_t count, enum dev_type device_type,
+				      u8 *cal_status)
 {
 	size_t size = 1;
 	u8 val = 0;
@@ -1425,6 +1431,8 @@ static ssize_t calibrate_config_store(struct device *dev,
 	val = ret;
 	if (!val)
 		size = 0;
+	if (val == CAL_START)
+		*cal_status = CAL_STAT_UNKNOWN;
 
 	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, cmd, sub_cmd,
 			       device_type, &val, size);
@@ -1822,7 +1830,8 @@ static void hid_go_brightness_set(struct led_classdev *led_cdev,
 				     const char *buf, size_t count)           \
 	{                                                                     \
 		return calibrate_config_store(dev, attr, buf, _name.index,    \
-					      _scmd, count, _dtype);          \
+					      _scmd, count, _dtype,           \
+					      _name.status);                   \
 	}                                                                     \
 	static ssize_t _name##_##_rtype##_show(                               \
 		struct device *dev, struct device_attribute *attr, char *buf) \
@@ -1982,17 +1991,23 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "rumble_notification",
 static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
 			    "rumble_notification_index");
 
-static struct go_cfg_attr cal_trigg_left = { SET_TRIGGER_CFG };
+static struct go_cal_cfg_attr cal_trigg_left = {
+	SET_TRIGGER_CFG, &drvdata.gp_left_trigg_cal_status
+};
 LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", TRIGGER_CALIBRATE,
 		     LEFT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_trigg_left_index, "calibrate_trigger_index");
 
-static struct go_cfg_attr cal_joy_left = { SET_JOYSTICK_CFG };
+static struct go_cal_cfg_attr cal_joy_left = {
+	SET_JOYSTICK_CFG, &drvdata.gp_left_joy_cal_status
+};
 LEGO_CAL_DEVICE_ATTR(cal_joy_left, "calibrate_joystick", JOYSTICK_CALIBRATE,
 		     LEFT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_joy_left_index, "calibrate_joystick_index");
 
-static struct go_cfg_attr cal_gyro_left = { SET_GYRO_CFG };
+static struct go_cal_cfg_attr cal_gyro_left = {
+	SET_GYRO_CFG, &drvdata.gp_left_gyro_cal_status
+};
 LEGO_CAL_DEVICE_ATTR(cal_gyro_left, "calibrate_gyro", GYRO_CALIBRATE,
 		     LEFT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_gyro_left_index, "calibrate_gyro_index");
@@ -2089,17 +2104,23 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_right, "rumble_notification",
 static DEVICE_ATTR_RO_NAMED(rumble_notification_right_index,
 			    "rumble_notification_index");
 
-static struct go_cfg_attr cal_trigg_right = { SET_TRIGGER_CFG };
+static struct go_cal_cfg_attr cal_trigg_right = {
+	SET_TRIGGER_CFG, &drvdata.gp_right_trigg_cal_status
+};
 LEGO_CAL_DEVICE_ATTR(cal_trigg_right, "calibrate_trigger", TRIGGER_CALIBRATE,
 		     RIGHT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_trigg_right_index, "calibrate_trigger_index");
 
-static struct go_cfg_attr cal_joy_right = { SET_JOYSTICK_CFG };
+static struct go_cal_cfg_attr cal_joy_right = {
+	SET_JOYSTICK_CFG, &drvdata.gp_right_joy_cal_status
+};
 LEGO_CAL_DEVICE_ATTR(cal_joy_right, "calibrate_joystick", JOYSTICK_CALIBRATE,
 		     RIGHT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_joy_right_index, "calibrate_joystick_index");
 
-static struct go_cfg_attr cal_gyro_right = { SET_GYRO_CFG };
+static struct go_cal_cfg_attr cal_gyro_right = {
+	SET_GYRO_CFG, &drvdata.gp_right_gyro_cal_status
+};
 LEGO_CAL_DEVICE_ATTR(cal_gyro_right, "calibrate_gyro", GYRO_CALIBRATE,
 		     RIGHT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_gyro_right_index, "calibrate_gyro_index");
-- 
2.55.0

