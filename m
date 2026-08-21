Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D33CFF61
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348902; cv=none; b=BtARAXF5ewt+w2hR4T/41RO1zBePeR8OOn9rF+Ew0GaZv5DmK2oo2Rf23AeW4C852U3Xs6/wF8YqQYtF1/elFcHfwViodEebSn6mwS6MgoNkIBtbfw5VbgdNZSq2Fos4OeXwc9rGjPJVE3uR1UpLUzsMqSnLWFlxDw7cN84hp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348902; c=relaxed/simple;
	bh=UCET5S5NKpQ4SV1oHGApbVNd7sDijesynYSaPBJb9mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/VfB5MIgWtK2HwA1GnEfdP17LyiYmPdZLLGGSXrupRLuv/URJeIenApw/wBj7+hQE7etFN03P5tDZwos1IpdI59xkoC5o5rqk579C1F/amo8Wq5T64VHy4ueT3dpYdPKAdi2JKWfzC1PxiWAmvjwC5fh6NwVXNtnfrDr29ceMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbT/TZAx; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbT/TZAx"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caed617615so16578255ad.3
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 14:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348900; x=1787953700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zx7wjrhyCH8x4R64vWer8c0Rup12kGYxxXYV7VJC0EQ=;
        b=dbT/TZAxVJTsUN4lFriyoKtEeMaqf5cjbqEoc/1DLJNvi8P+LOPLKBTWOHVs7p7saE
         wgGBK0HrpP/mtnySujVOtkdX530ck56ohs6uXP4f1TjM1JATAIendg/coH+t0LydkvNI
         TcFtVQBFJhIMsMBxTIeOONgzQtOORlGwMaRh1Ba62Z1JdP2ZDM9rjxw8aosrApeIvnG0
         y77S5q1bbJsnoYQCPSGA2Ibk8xvXWrZSk2lvYc+697+yXw+jGWzZvp50fbTUyk0OzmrQ
         sO3mRzlocRY47m75uCvjupBAzKWxKkW/lUxmwUj5Zd3lG6xE3MDiCx5fvhE5aSNzIa+B
         RSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348900; x=1787953700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zx7wjrhyCH8x4R64vWer8c0Rup12kGYxxXYV7VJC0EQ=;
        b=PPOWkPFM0RyrrWAhxv1y+3T5xuPlpF2ByzXi/tlGleKRhwiVV3LxdbvU2pUpDcw6NL
         nm2PT4UE/PIbILx8Cf4yumBY42BiQunb2zIfDaV43IYa+rbc7yaSlSMjPYYE08umJzzM
         YgCLYYIIbUu3l6Xd5ohjzpXcKqvUMNM9bJmuEy3+HjqkRvvOORrMZMt+q2JwyK2WSE+q
         XyqwaNOJsD6QFqqh18qfmo8azBNQVVN+panB9cuDq6bQYxdTTS/DWB2i43bqfYeUjCFE
         XcsxVTHLMGIRt4ayEZVFJrT1NaKke57nG0jQGcIBw0bU+iNC2z2z05aFufvd3VBSMUER
         Olow==
X-Gm-Message-State: AFuF++lDlvR+GUPBRVZQmcantV1NkpzbFIApghZqXKrVDyItknN6LFam
	ihoKWDhOpKHJsP4AzC/MSMNyqPFdOWqJ0V1MBbxqxslD9nw2vjpQmHlD
X-Gm-Gg: AR+sD1212qU1w5NuNXQIwruvc4MODZrpTd/6hztVvPZpbfa7VhpvUzEcP+pFn0J0K/E
	0dCSSDZigUAJJdqpF4GFmEFMLB159FBjK14T6ASrzF1LBUCi0r2ynsEO4OnVMVFuRbTxm6UAShs
	ETTCu+Odtn2VuVwg6Ui4TKcFYcoipk+RV/NDYJrmZYiyU8Q/XXBRIwA7hfP/154sP3QEEwxIlzN
	4AT0qv/g7XJwpEs/6SN+RICaux1puxIw26Po6NEiNLDewIL6LgYS1CiDHAYAn+gRy8UiFq5v/Z2
	XVvJNVJMLlD1AZuSIX+2Z+wB1ewoVWDlfyKMlya8ZPXgpQodQAkuVS/GFLFrctyJ930Yhi3nFnk
	vRsCZKA6NooWG4pqWZ1aNXHFlhOKh/QyLuOTDXH0GToP4mbDbkdxnLWhjV1Su4ecX7bBjxPEGUN
	ifwG1uMoH08aagfSAPhjg/b5JltbdpFuP5zRi972bJbpJDxTJ/sSvKj7VpFVaMJqr3eoc6BAqR2
	wjbzd6KfZOCyeg6XTA=
X-Received: by 2002:a17:903:1108:b0:2cf:a108:7605 with SMTP id d9443c01a7336-2d670cc180fmr19489855ad.11.1787348900112;
        Fri, 21 Aug 2026 14:48:20 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm27276942eec.3.2026.08.21.14.48.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:48:19 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] HID: hid-lenovo-go: use the correct calibration commands
Date: Sat, 22 Aug 2026 03:18:06 +0530
Message-ID: <20260821214810.87826-2-mradityadash@gmail.com>
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

The calibration attributes pass the calibration operation as the command
and the configuration command as the sub-command. This sends each request
with the two fields reversed.

Swap the command and sub-command values for all six calibration attributes.
For example, the malformed left joystick Start request is:

  05 00 04 0c 03 01 ...

The corrected request is:

  05 00 0c 04 03 01 ...

The bytes identify the output report, configuration group, command,
sub-command, left controller, and Start action, in that order.

Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 318b1152ff8b..b8248bf8965c 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -1911,18 +1911,18 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "rumble_notification",
 static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
 			    "rumble_notification_index");
 
-static struct go_cfg_attr cal_trigg_left = { TRIGGER_CALIBRATE };
-LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", SET_TRIGGER_CFG,
+static struct go_cfg_attr cal_trigg_left = { SET_TRIGGER_CFG };
+LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", TRIGGER_CALIBRATE,
 		     LEFT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_trigg_left_index, "calibrate_trigger_index");
 
-static struct go_cfg_attr cal_joy_left = { JOYSTICK_CALIBRATE };
-LEGO_CAL_DEVICE_ATTR(cal_joy_left, "calibrate_joystick", SET_JOYSTICK_CFG,
+static struct go_cfg_attr cal_joy_left = { SET_JOYSTICK_CFG };
+LEGO_CAL_DEVICE_ATTR(cal_joy_left, "calibrate_joystick", JOYSTICK_CALIBRATE,
 		     LEFT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_joy_left_index, "calibrate_joystick_index");
 
-static struct go_cfg_attr cal_gyro_left = { GYRO_CALIBRATE };
-LEGO_CAL_DEVICE_ATTR(cal_gyro_left, "calibrate_gyro", SET_GYRO_CFG,
+static struct go_cfg_attr cal_gyro_left = { SET_GYRO_CFG };
+LEGO_CAL_DEVICE_ATTR(cal_gyro_left, "calibrate_gyro", GYRO_CALIBRATE,
 		     LEFT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_gyro_left_index, "calibrate_gyro_index");
 
@@ -2018,18 +2018,18 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_right, "rumble_notification",
 static DEVICE_ATTR_RO_NAMED(rumble_notification_right_index,
 			    "rumble_notification_index");
 
-static struct go_cfg_attr cal_trigg_right = { TRIGGER_CALIBRATE };
-LEGO_CAL_DEVICE_ATTR(cal_trigg_right, "calibrate_trigger", SET_TRIGGER_CFG,
+static struct go_cfg_attr cal_trigg_right = { SET_TRIGGER_CFG };
+LEGO_CAL_DEVICE_ATTR(cal_trigg_right, "calibrate_trigger", TRIGGER_CALIBRATE,
 		     RIGHT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_trigg_right_index, "calibrate_trigger_index");
 
-static struct go_cfg_attr cal_joy_right = { JOYSTICK_CALIBRATE };
-LEGO_CAL_DEVICE_ATTR(cal_joy_right, "calibrate_joystick", SET_JOYSTICK_CFG,
+static struct go_cfg_attr cal_joy_right = { SET_JOYSTICK_CFG };
+LEGO_CAL_DEVICE_ATTR(cal_joy_right, "calibrate_joystick", JOYSTICK_CALIBRATE,
 		     RIGHT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_joy_right_index, "calibrate_joystick_index");
 
-static struct go_cfg_attr cal_gyro_right = { GYRO_CALIBRATE };
-LEGO_CAL_DEVICE_ATTR(cal_gyro_right, "calibrate_gyro", SET_GYRO_CFG,
+static struct go_cfg_attr cal_gyro_right = { SET_GYRO_CFG };
+LEGO_CAL_DEVICE_ATTR(cal_gyro_right, "calibrate_gyro", GYRO_CALIBRATE,
 		     RIGHT_CONTROLLER, index);
 static DEVICE_ATTR_RO_NAMED(cal_gyro_right_index, "calibrate_gyro_index");
 
-- 
2.55.0

