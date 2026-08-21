Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA28419FB2
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352641; cv=none; b=ad2J0j+nGxJfYRGCrivhEOPUjiPrWcP3p+it7uzeHdORa2JMCyA6WlwDi2zuwCGVe5vZVK6afpBVjK8F/NHMCAn8WCY9IVby5jDZnXG5O6gHrY1J19QnPF+Lks7xyEtEhFsDYuPeO5FQxWSUuk9xpB0e/+HgFuTZ53U/WL87Voc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352641; c=relaxed/simple;
	bh=EchhJ9Ley1YrtfV2ODWwu3vA0XKjggGQ/xBVd0ehuQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LyY7IbXc+DMWFqMXi67EuWSNhIZr/Wj5ZgWA1dakK4Kppvb64cCRpS2jr3TUUJ80krEcuvTWPHZ2EyRoOQVl9hbuUDmNzQf5mrCFp79O0QFH+XXCcAO5/Kn1FL7ce+dNICIVmGFHE18Y3yJsiHmT+VLcEME3pCdSvFzDemHaBD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kx6/lTKN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx6/lTKN"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9cf07d2df6so1002399a12.2
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787352637; x=1787957437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNVVYBK1Ktv9SrkeN9TaUZn0Fv2YlfnV/Q6jiZQXw9Y=;
        b=Kx6/lTKNbLV+R6yxKicpFo7LQRMYz8+swu3Zo0sF+pVPi+G7eJLY30YeHgJIsb2wXQ
         VQnYQMrjHbMA/6OJoqWv9Tx6Xe4XsQxI5A8eV4NIcOJngSywkyQPoz0QtMBmBKeuqls1
         IvQAIYj6ZU01n8n65GkNHlFiKu0D68v+XIWuuoIMji5uETOA03K8qL5spab6Vw0eQ+nX
         fo0ate1WhnDNL16yDjeasxsImmELiXU2XdP0faLfi1zdxQKjwJDzwyVr0Aj0WTvmOGAu
         4SlJeZbf9hzjaJ3eE+H/9qPYzRJZjajAE9xkhLphOdLiT14b4MQj5RAkt08nenxFEDl5
         iJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787352637; x=1787957437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNVVYBK1Ktv9SrkeN9TaUZn0Fv2YlfnV/Q6jiZQXw9Y=;
        b=b69t1Bg0wZx1WwSsapyeoFb/dXNYnesqh06Lkubiegc/U72yTZCojjjbQqrIwwVB2K
         qGKUcEAr32aNY8Iub2ICzARMt5ahkwaCftXwHc7S6MmJzl3R3lj5wZ6dlA3U6roIX0Sa
         oULnIoE3aUScorXwJ4mI47F3haS301uR32GIzUgnWZzIHRjA9yWOCHJWQhVTWDnlo6YA
         pj1/52Pk4mVdF25bz91j8xKrNayf51mjXs0zZagwUQdqV/M/1feB6irxHvWI6FLN3L74
         s2s2ZV0Lk51lNHa8n+ycYaDTkEGuIWyX3NBZobnY4qw5PdaCQRTkUmukQx2gCEoZTlrz
         vjhw==
X-Gm-Message-State: AFuF++mkfW9xHNw5jVopaALQr7QOTEMIUpngrMCiF46UQqQ8zeN8StW9
	gN/yzjDH7oAy0cmC02X32FRMW/sKtsAju3qJ5r+4YsL+FYEtVOals6tz
X-Gm-Gg: AR+sD11u3f+I3obGi3XJPaAnUNRzzH1zeQ5hKpcGCQpSrM2uSKwpEUTpA2njPYS8t5n
	3Ua/kt7hxOj1AeXtWEaaF1HCSb6TdYFPNFsbepjkZ5pImu0ZsxGSjxSu7ks9VJplbZrqLddIXbP
	sgV9/Z2nfoJ/yfRmaEHsb4w/zG0wRnd7c9C/p+s6pyn+y5VkuuAZy+kdeT9IXYwB4Oi0zLdjknL
	9mkyKow9NvdA2crC1BqqWHBw5C+CGuWzSUbmjFlrvnHi4uSNhb8nAKbRjzTyA9fizwB7oWJpoF6
	j5RbLXhbIN8izxZdsJet9hBijGkC7SyAxQX/uVQD7Jrt4XZzWExbwuYSnY5T0+e/Xy4/KeiP13l
	3UY8u7E7PFrWTz2lR2omlMn60FubNiNXGVRlE+B/GINneC1TwKWut39Toi2MfvbsPZWR/RkHbFz
	M/MWDqSdgObcx5szVI0BueXWWG3SlVbp0L3Hwqkj5GOS5fB53pBNGgtTnt+oLUnnW0TNw/HBzWL
	7pcBN1iLIEYKQ==
X-Received: by 2002:a17:90a:e7c5:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-395c34f47cbmr16203823a91.8.1787352636625;
        Fri, 21 Aug 2026 15:50:36 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1418600535csm1395779c88.0.2026.08.21.15.50.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 15:50:36 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] HID: hid-lenovo-go: expose calibration error codes
Date: Sat, 22 Aug 2026 04:20:30 +0530
Message-ID: <20260821225030.96803-1-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A calibration completion report contains a result and a little-endian
16-bit firmware error. The driver records the result but discards the
error, so a user can detect failure but cannot read the reported reason.

Store the result and error as one calibration state. Protect each update
and read with a spinlock. Add a read-only error attribute next to the
existing Left and Right gyro, joystick, and trigger status attributes.
Status and error are separate reads and do not provide one atomic
snapshot.

This RFC applies on top of the controller configuration fixes:
https://lore.kernel.org/all/20260821214810.87826-1-mradityadash@gmail.com/

Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
A successful completion with error 0x0000 was tested on hardware. No final
failure completion was captured.

 .../ABI/testing/sysfs-driver-hid-lenovo-go    |  21 ++
 drivers/hid/hid-lenovo-go.c                   | 179 +++++++++++-------
 2 files changed, 128 insertions(+), 72 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
index c8221373ef76..d0270ea6de67 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -722,3 +722,24 @@ Description:	This displays the protocol version of the internal wireless transmi
 
 		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
 
+What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/{left_handle,right_handle}/calibrate_{gyro,joystick,trigger}_error
+Date:		August 2026
+Contact:	linux-input@vger.kernel.org
+Description:	This read-only attribute displays the 16-bit firmware error from the
+		most recently received calibration completion. The value is
+		hexadecimal from 0x0000 through 0xffff. It is 0x0000 before the
+		first completion. Starting calibration does not clear the last
+		completion. Read the matching calibrate_*_status attribute to
+		determine whether calibration succeeded or failed. Separate status
+		and error reads do not form an atomic snapshot.
+
+		Lenovo controller software identifies gyro errors 0x0001 as not
+		stationary or timeout and 0x0002 as a connection change. Joystick
+		errors are 0x0100 for incomplete range, 0x0200 for not centered,
+		0x0400 for incomplete rotations, and 0x0800 for a connection change.
+		Trigger errors are 0x0001 for incomplete press, 0x0002 for incomplete
+		release, 0x0004 for incomplete repetitions, and 0x0008 for a
+		connection change. Error 0xffff is a calibration exception. Other
+		values are returned without translation.
+
+		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index a1a255c28e2d..7289100deb53 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -54,18 +54,24 @@ static struct hid_go_cmd go_cmd = {
 	.lock = __SPIN_LOCK_UNLOCKED(go_cmd.lock),
 };
 
+struct hid_go_calibration_state {
+	u16 error;
+	u8 status;
+};
+
 static struct hid_go_cfg {
 	struct delayed_work go_cfg_setup;
 	struct led_classdev *led_cdev;
 	struct hid_device *hdev;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
+	spinlock_t cal_lock; /* protects calibration state */
 	u8 fps_mode;
 	u8 gp_left_auto_sleep_time;
-	u8 gp_left_gyro_cal_status;
-	u8 gp_left_joy_cal_status;
+	struct hid_go_calibration_state gp_left_gyro_cal;
+	struct hid_go_calibration_state gp_left_joy_cal;
 	u8 gp_left_notify_en;
 	u8 gp_left_rumble_mode;
-	u8 gp_left_trigg_cal_status;
+	struct hid_go_calibration_state gp_left_trigg_cal;
 	u32 gp_left_version_firmware;
 	u8 gp_left_version_gen;
 	u32 gp_left_version_hardware;
@@ -73,11 +79,11 @@ static struct hid_go_cfg {
 	u32 gp_left_version_protocol;
 	u8 gp_mode;
 	u8 gp_right_auto_sleep_time;
-	u8 gp_right_gyro_cal_status;
-	u8 gp_right_joy_cal_status;
+	struct hid_go_calibration_state gp_right_gyro_cal;
+	struct hid_go_calibration_state gp_right_joy_cal;
 	u8 gp_right_notify_en;
 	u8 gp_right_rumble_mode;
-	u8 gp_right_trigg_cal_status;
+	struct hid_go_calibration_state gp_right_trigg_cal;
 	u32 gp_right_version_firmware;
 	u8 gp_right_version_gen;
 	u32 gp_right_version_hardware;
@@ -108,7 +114,9 @@ static struct hid_go_cfg {
 	u32 tx_dongle_version_hardware;
 	u32 tx_dongle_version_product;
 	u32 tx_dongle_version_protocol;
-} drvdata;
+} drvdata = {
+	.cal_lock = __SPIN_LOCK_UNLOCKED(drvdata.cal_lock),
+};
 
 struct go_cfg_attr {
 	u8 index;
@@ -659,46 +667,53 @@ static int hid_go_light_event(struct command_report *cmd_rep)
 	}
 }
 
-static int hid_go_device_status_event(struct command_report *cmd_rep)
+static struct hid_go_calibration_state *
+hid_go_calibration_state(u8 device, u8 module)
 {
-	u8 status = cmd_rep->data[1] ? CAL_STAT_SUCCESS : CAL_STAT_FAILURE;
-
-	switch (cmd_rep->device_type) {
+	switch (device) {
 	case LEFT_CONTROLLER:
-		switch (cmd_rep->data[0]) {
+		switch (module) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_left_gyro_cal_status = status;
-			return 0;
+			return &drvdata.gp_left_gyro_cal;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_left_joy_cal_status = status;
-			return 0;
+			return &drvdata.gp_left_joy_cal;
 		case CALDEV_TRIGGER:
-			drvdata.gp_left_trigg_cal_status = status;
-			return 0;
+			return &drvdata.gp_left_trigg_cal;
 		default:
-			return -EINVAL;
+			return NULL;
 		}
-		break;
 	case RIGHT_CONTROLLER:
-		switch (cmd_rep->data[0]) {
+		switch (module) {
 		case CALDEV_GYROSCOPE:
-			drvdata.gp_right_gyro_cal_status = status;
-			return 0;
+			return &drvdata.gp_right_gyro_cal;
 		case CALDEV_JOYSTICK:
-			drvdata.gp_right_joy_cal_status = status;
-			return 0;
+			return &drvdata.gp_right_joy_cal;
 		case CALDEV_TRIGGER:
-			drvdata.gp_right_trigg_cal_status = status;
-			return 0;
+			return &drvdata.gp_right_trigg_cal;
 		default:
-			return -EINVAL;
+			return NULL;
 		}
-		break;
 	default:
-		return -EINVAL;
+		return NULL;
 	}
 }
 
+static int hid_go_device_status_event(struct command_report *cmd_rep)
+{
+	struct hid_go_calibration_state *state;
+	unsigned long flags;
+
+	state = hid_go_calibration_state(cmd_rep->device_type, cmd_rep->data[0]);
+	if (!state)
+		return -EINVAL;
+
+	spin_lock_irqsave(&drvdata.cal_lock, flags);
+	state->error = get_unaligned_le16(cmd_rep->data + 2);
+	state->status = cmd_rep->data[1] ? CAL_STAT_SUCCESS : CAL_STAT_FAILURE;
+	spin_unlock_irqrestore(&drvdata.cal_lock, flags);
+	return 0;
+}
+
 static int hid_go_os_mode_cfg_event(struct command_report *cmd_rep)
 {
 	switch (cmd_rep->sub_cmd) {
@@ -1380,53 +1395,45 @@ static ssize_t device_status_show(struct device *dev,
 				  enum dev_type device_type,
 				  enum cal_device_type cal_type)
 {
-	u8 i;
+	struct hid_go_calibration_state *state;
+	unsigned long flags;
+	u8 status;
 
-	switch (index) {
-	case GET_CAL_STATUS:
-		switch (device_type) {
-		case LEFT_CONTROLLER:
-			switch (cal_type) {
-			case CALDEV_GYROSCOPE:
-				i = drvdata.gp_left_gyro_cal_status;
-				break;
-			case CALDEV_JOYSTICK:
-				i = drvdata.gp_left_joy_cal_status;
-				break;
-			case CALDEV_TRIGGER:
-				i = drvdata.gp_left_trigg_cal_status;
-				break;
-			default:
-				return -EINVAL;
-			}
-			break;
-		case RIGHT_CONTROLLER:
-			switch (cal_type) {
-			case CALDEV_GYROSCOPE:
-				i = drvdata.gp_right_gyro_cal_status;
-				break;
-			case CALDEV_JOYSTICK:
-				i = drvdata.gp_right_joy_cal_status;
-				break;
-			case CALDEV_TRIGGER:
-				i = drvdata.gp_right_trigg_cal_status;
-				break;
-			default:
-				return -EINVAL;
-			}
-			break;
-		default:
-			return -EINVAL;
-		}
-		break;
-	default:
+	if (index != GET_CAL_STATUS)
 		return -EINVAL;
-	}
 
-	if (i >= ARRAY_SIZE(cal_status_text))
+	state = hid_go_calibration_state(device_type, cal_type);
+	if (!state)
+		return -EINVAL;
+
+	spin_lock_irqsave(&drvdata.cal_lock, flags);
+	status = state->status;
+	spin_unlock_irqrestore(&drvdata.cal_lock, flags);
+
+	if (status >= ARRAY_SIZE(cal_status_text))
 		return -EINVAL;
 
-	return sysfs_emit(buf, "%s\n", cal_status_text[i]);
+	return sysfs_emit(buf, "%s\n", cal_status_text[status]);
+}
+
+static ssize_t calibration_error_show(struct device *dev,
+				      struct device_attribute *attr, char *buf,
+				      enum dev_type device_type,
+				      enum cal_device_type cal_type)
+{
+	struct hid_go_calibration_state *state;
+	unsigned long flags;
+	u16 error;
+
+	state = hid_go_calibration_state(device_type, cal_type);
+	if (!state)
+		return -EINVAL;
+
+	spin_lock_irqsave(&drvdata.cal_lock, flags);
+	error = state->error;
+	spin_unlock_irqrestore(&drvdata.cal_lock, flags);
+
+	return sysfs_emit(buf, "0x%04x\n", error);
 }
 
 static ssize_t calibrate_config_store(struct device *dev,
@@ -1860,6 +1867,14 @@ static void hid_go_brightness_set(struct led_classdev *led_cdev,
 	}                                                                     \
 	static DEVICE_ATTR_RO_NAMED(_name, _attrname)
 
+#define LEGO_CAL_ERROR_ATTR(_name, _attrname, _dtype, _ctype)                 \
+	static ssize_t _name##_show(struct device *dev,                       \
+				    struct device_attribute *attr, char *buf) \
+	{                                                                     \
+		return calibration_error_show(dev, attr, buf, _dtype, _ctype); \
+	}                                                                     \
+	static DEVICE_ATTR_RO_NAMED(_name, _attrname)
+
 /* Gamepad - MCU */
 static struct go_cfg_attr version_product_mcu = { PRODUCT_VERSION };
 LEGO_DEVICE_ATTR_RO(version_product_mcu, "product_version", USB_MCU, version);
@@ -2029,16 +2044,26 @@ static struct go_cfg_attr cal_gyro_left_status = { GET_CAL_STATUS };
 LEGO_DEVICE_STATUS_ATTR(cal_gyro_left_status, "calibrate_gyro_status",
 			LEFT_CONTROLLER, CALDEV_GYROSCOPE);
 
+LEGO_CAL_ERROR_ATTR(cal_trigg_left_error, "calibrate_trigger_error",
+		    LEFT_CONTROLLER, CALDEV_TRIGGER);
+LEGO_CAL_ERROR_ATTR(cal_joy_left_error, "calibrate_joystick_error",
+		    LEFT_CONTROLLER, CALDEV_JOYSTICK);
+LEGO_CAL_ERROR_ATTR(cal_gyro_left_error, "calibrate_gyro_error",
+		    LEFT_CONTROLLER, CALDEV_GYROSCOPE);
+
 static struct attribute *left_gamepad_attrs[] = {
 	&dev_attr_auto_sleep_time_left.attr,
 	&dev_attr_auto_sleep_time_left_range.attr,
 	&dev_attr_cal_gyro_left.attr,
+	&dev_attr_cal_gyro_left_error.attr,
 	&dev_attr_cal_gyro_left_index.attr,
 	&dev_attr_cal_gyro_left_status.attr,
 	&dev_attr_cal_joy_left.attr,
+	&dev_attr_cal_joy_left_error.attr,
 	&dev_attr_cal_joy_left_index.attr,
 	&dev_attr_cal_joy_left_status.attr,
 	&dev_attr_cal_trigg_left.attr,
+	&dev_attr_cal_trigg_left_error.attr,
 	&dev_attr_cal_trigg_left_index.attr,
 	&dev_attr_cal_trigg_left_status.attr,
 	&dev_attr_imu_bypass_left.attr,
@@ -2136,16 +2161,26 @@ static struct go_cfg_attr cal_gyro_right_status = { GET_CAL_STATUS };
 LEGO_DEVICE_STATUS_ATTR(cal_gyro_right_status, "calibrate_gyro_status",
 			RIGHT_CONTROLLER, CALDEV_GYROSCOPE);
 
+LEGO_CAL_ERROR_ATTR(cal_trigg_right_error, "calibrate_trigger_error",
+		    RIGHT_CONTROLLER, CALDEV_TRIGGER);
+LEGO_CAL_ERROR_ATTR(cal_joy_right_error, "calibrate_joystick_error",
+		    RIGHT_CONTROLLER, CALDEV_JOYSTICK);
+LEGO_CAL_ERROR_ATTR(cal_gyro_right_error, "calibrate_gyro_error",
+		    RIGHT_CONTROLLER, CALDEV_GYROSCOPE);
+
 static struct attribute *right_gamepad_attrs[] = {
 	&dev_attr_auto_sleep_time_right.attr,
 	&dev_attr_auto_sleep_time_right_range.attr,
 	&dev_attr_cal_gyro_right.attr,
+	&dev_attr_cal_gyro_right_error.attr,
 	&dev_attr_cal_gyro_right_index.attr,
 	&dev_attr_cal_gyro_right_status.attr,
 	&dev_attr_cal_joy_right.attr,
+	&dev_attr_cal_joy_right_error.attr,
 	&dev_attr_cal_joy_right_index.attr,
 	&dev_attr_cal_joy_right_status.attr,
 	&dev_attr_cal_trigg_right.attr,
+	&dev_attr_cal_trigg_right_error.attr,
 	&dev_attr_cal_trigg_right_index.attr,
 	&dev_attr_cal_trigg_right_status.attr,
 	&dev_attr_imu_bypass_right.attr,
-- 
2.55.0

