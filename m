Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219A32F5498
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244601; cv=none; b=HRTVJm+5m4E9F6RT/5IqWSFdB7BMFXOxo1+jucHexZ7ozNYcL2HBH3a0Y03FAd1l4odz1OAULSGc57fiY3Qa8baVdjRTpDlnnU7I9AVap/9vCo+AyR2qIwzhCD4tVdnzp+6ihBxKzMuxqymeRbvUvkJlwWYdFq3qv1+PpSCH6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244601; c=relaxed/simple;
	bh=NTyzz1tppaj+6o9zA66wVH4g6nKViE8xv5+rYVtAJLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j33teJBRP89G+4Ed0nla8sXlyfV4a35UqHVzWwYCnHqbQXGdj1dPFJepwYjjpZktqZkPLox9aHY6sUz3IiJibd9o7jyH/Vtk9X71T1hMaVk7WoIrOdm2y0TZWRSelPqk9K/FDaTMvBUCoJ7dilEoUDbkyKM4zWS33YYY24WAgDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQUieViO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQUieViO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so4970784a91.0
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244599; x=1788849399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9koJ5kLU6HxS0Wc8/5ifXaSo5oQLaBgI3WQL+B9qH7Y=;
        b=PQUieViOrfE1FGrtJI+GJRasHnJIrfm01jSoXqz9gOq/7f3haD+cVUltZyLXW0dOrq
         fNtSum22LEfB/YMjdax1cTvaAOGqLaWPwR9sZHAePRfby/RoOjxXDsMNJ8kxrLiR/WZn
         Ig8S7eqxa+ShlQo6HOeKa3iC71RnRo+Cd2sU9VB95u6SWR9fQZyqnAPHB0IIra+16dpV
         /YCz4xrr3nD7t0bIV60YReZCgFoqlHSEnlYYVJOldj9BUJ3bVkECSM8OPGVRGDSZnBsa
         k8i+dApC1weAkXrGiAz1fhU4xOn02KHdrLfAJP2EMBTPZawrDO+gXOgYqAtpZzPU7teu
         5tsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244599; x=1788849399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9koJ5kLU6HxS0Wc8/5ifXaSo5oQLaBgI3WQL+B9qH7Y=;
        b=rq1v8QPQnm/hS21JrJEsqoR7nGS+vs0CgoHKi9bmlnyDViOQKp38xHGnf086LVTvus
         dnzXq/Q74xbFGbfB30XBpph6QTGVXTBhc9AeQEX1bu2Y9reOD29SC2alPhukZ/B3gJ4K
         0qWgQeo1ud8tI5jqdVIeQ3YYS2A8T1cqm+oeVsJa/hZj1jbI/jJaEg+vhV8kPQZ7mKbg
         PC63Z/u+xfyFJAW7eCVWK7ymIwB6rZxJgTz0rggxdDzzvznTos9dj1GTDf6SFrB8DUAI
         P1aEbaNf5vlGBgnPWBY71N8q6ARmRqYDTAhXcLJTwbRuomtRFhaZRbBgovkC2B3qn9Cl
         T6iA==
X-Gm-Message-State: AFuF++nYwPKTfJMKs0VwuK3mL2fUn4z2wnFFsa0NLAnv2UE8pWuxUC+f
	gSQCtsBPPPr3m7r3e3qx8OyusiwjLbhGI71LAwqqCeID48WEB6ivGks4DbzHCxVy
X-Gm-Gg: AYBFou0QSf6MI5c6T2TfjHBWGH7Up86EE/uVvW0I9kEPtXLrZ39gCTy1z8o7immF443
	z6xLuIbZyVjEt3Hj5iU59ktx7VfaGgZYBRnpQQ7t+p7HHsZTlz/jwOzwUb8/XMhrd86jyeGOd4g
	o+jr0XfcNe7B+4gHAHJ3KC8j8Vzr9tCnR3iLQMPNX7v+LU8eevds7Qh0FQ55+elYCTSHoQivBne
	rMpRxmiRBwixkt5f4iOZc0t+ot53m9viapTYxcQgXUEy9G5mJYEskoRp5fjsgVKhDRVWm97wMLT
	MyXx6/l5qPgkQfWiIsTRX7qqSt27FG2Jog4UMinjJWecN+FGo2pYoEMXwySLnAv8OQs25yZLIDa
	C3thZDsFAXd4BGR3Vvb40o4Teimqsk7/VYNOKQ6p+1inFRImL59zUoeXyza2JcrIWt1PkbQ8cB2
	P7nrvxPUsmGgZno158gwMD1xeYQbeybaVKkKKEQvE0WXxvfpv5PNVtcW6+5fzrPvPVbl1j5bLQJ
	1yAun82KcL/3w==
X-Received: by 2002:a17:90a:d44b:b0:38e:c7b0:84ad with SMTP id 98e67ed59e1d1-399074b6df0mr9147987a91.0.1788244599494;
        Mon, 31 Aug 2026 23:36:39 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:38 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/7] HID: hid-lenovo-go: clear calibration status on start
Date: Tue,  1 Sep 2026 12:06:08 +0530
Message-ID: <7d100dad9edf6fd6b161e361053372a732b32eb4.1788222001.git.mradityadash@gmail.com>
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
 drivers/hid/hid-lenovo-go.c | 38 +++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index a6dec5490d17..749536e19d2d 100644
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
 	u8 val;
 	int ret;
@@ -1422,6 +1428,9 @@ static ssize_t calibrate_config_store(struct device *dev,
 		return -EINVAL;
 
 	val = ret;
+	if (val == CAL_START)
+		*cal_status = CAL_STAT_UNKNOWN;
+
 	ret = mcu_property_out(drvdata.hdev, MCU_CONFIG_DATA, cmd, sub_cmd,
 			       device_type, &val, sizeof(val));
 	if (ret < 0)
@@ -1818,7 +1827,8 @@ static void hid_go_brightness_set(struct led_classdev *led_cdev,
 				     const char *buf, size_t count)           \
 	{                                                                     \
 		return calibrate_config_store(dev, attr, buf, _name.index,    \
-					      _scmd, count, _dtype);          \
+					      _scmd, count, _dtype,           \
+					      _name.status);                   \
 	}                                                                     \
 	static ssize_t _name##_##_rtype##_show(                               \
 		struct device *dev, struct device_attribute *attr, char *buf) \
@@ -1978,17 +1988,23 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "rumble_notification",
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
@@ -2085,17 +2101,23 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_right, "rumble_notification",
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

