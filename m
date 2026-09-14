Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC23AE1A9
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426401; cv=none; b=rMMEVJTckNrv7uwpyb3ajFL3P/8YZoKcFLNf00OKyUy6e42tSie/LWxfMMpQyc5CWWWwkoqMU1T8Zhfwp0OWSMYmuGId4Z9B89qQWw8O1g7iuC6/WJQXH4OEiLwIdksl3yJOuyZih9odDxy+2gTpmRkNCZoakOiT79tWAwms6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426401; c=relaxed/simple;
	bh=0jdbcgi1ucObaWyrq260b9mGv8DVXuvEllXpVv7pX28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QkPNXHkOGgZ2IKUR0bjdPIlyEGUwZ8CIgJTUAS5C0exJGnDnWeUb3QB4C2gB8+UIprPkt/S/DvxUDeNZhurZjiA24gbC4mybWHrljl3v1Zus09ZEAGlBO1mtTMRt/2vwfJ2yKZk4JR4kQFQ0epBZFx26epJLbPilCW+Rdh44DH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvOA9TOK; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvOA9TOK"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so1772062a12.2
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 15:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789426396; x=1790031196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nkBmBi2M3bokC0woUyxYsBDQw2qjDISAFTNktCCOhv4=;
        b=mvOA9TOKWN3eiYeqor4FiDATUPvX0/ncCeigFm4H8jYfCAthYQwQ1ZhYK8M/32UlYz
         Xf4TzMmVHt/EEolpPmyN2eVM8dfuvTXkYUb5IL8zFQyF61vN2X559SjcnyW5fymO0tYd
         8o/q+42chTrVI+Rm1t+V3WRXw1hszJlkYozVhP7VO+Cira3GekGWC4mmz/DIly3MkswX
         K41QyMPbM8VVQp0yAeN/fqNGj4Ufljd3wx4t14Y+WSHbeiv+XcAc7gKiU0K10kIrVMvG
         TK4YaoIlhxF9qe9d2ZWwjc0aoOBvcoO8pvoegvHSnQZSZy1//ti607n9T1M2u46DOM2r
         VlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789426396; x=1790031196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nkBmBi2M3bokC0woUyxYsBDQw2qjDISAFTNktCCOhv4=;
        b=xo6tatN5Kgoxd18cqLnDvl0DwGMprVbSa4i54tUz/N7yPvTpevMFAkB9JkdleYJROf
         LCxExlYuAz/mmQf4CxWk1/oGLm0v1XYFAqp6+aosMQcynzDa9u8wlmWAt49NQAyMxS+4
         y8y5hEIo3UbmnKrzHlPLh7CnxRm7d6hQYM06KtGjoRD4HdFDXM6PjMdoXo4eA3WwJsn3
         BTQLDkNcBNxQHW7Dfa84SGbR44B47+L9FhXe5PMjIrUepExtttXL3PZdRDiofLAMg6fg
         l9H0ZrjXUTfO+oyr250F+I6wlTe8Aez1PqiYeLVM5pHMqb4QMa1GCDTE2Fxzn6NPdpi3
         iNqg==
X-Forwarded-Encrypted: i=1; AKwUvBzkLFevs8yT3OaH58zzuxO8NslfXImt3x+jv81LLKF2z61sF3yyOOVr2/762YREUt4IB6gjRD8lDkoK1A==@vger.kernel.org
X-Gm-Message-State: AFuF++lSAmXOo88Dy75xOxSD64FMGcU1ZKDSAvDtHUpG0HAGRGE7NMcy
	KH1laM6jmnYAnCd8O7qREm9uiMcx1Tu29v4Vd57Gok6mWqEVgOqpPYT4
X-Gm-Gg: AYBFou0IwpQUzP4tvIgrxfIbHYRQoiTfgzeRRp8bdfVKPK2acIDJNcT0yGZpIUdBQmL
	haCiWgCfhV1oD3dVr1Rp7R+1DT0quKwUtFkfLX3ANofKQQGoZhmBv2QugGjV6jWi8YmtPfV1tFs
	wbvG2pLlp/bQOsmGqPRFsyR1ji2F8+UkFxyx9jIbcJBSWlRYiysjPEexHl2DohpX03BF661HAt1
	Oizkbmime27yqbcVdLU6HQsj9pbmYyAK5xOTzGSVkLXo+CJEIBR5CiNm0RMKedXuLezPqgDBgir
	dfEib6zlGy+g3j58eXAhu3KucZIZjMjigtYR8SGkA/kr2rQNydeHaAvrPOM3cg0tauyoT+UgKy7
	6JOOJbbbUkdRgz7fPTcdHnJJSEA5Ql8CfDRi/As8N2C52sDP9IV+OZgiu03OTWN0Htr7jTe5eF2
	EBgW5fdJ88isWG7g4kiWi1v2PV3hK0gpHyCbUWLPOXl9Rr1NriHslftoDetdO8ql5SF1W9kuIUu
	1itrWF1EmqxS8jEfrQg3R3p/o1JfC6XTJMQqE+LUdnBGE9u+eK6
X-Received: by 2002:a05:6a20:72a6:b0:3d3:ae40:51e4 with SMTP id adf61e73a8af0-3db405e637fmr8959185637.24.1789426396151;
        Mon, 14 Sep 2026 15:53:16 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bbeb053a5sm14924296eec.27.2026.09.14.15.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 15:53:15 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH 08/10] HID: hid-lenovo-go-s: Reorganize and rename hid_gos_cfg
Date: Mon, 14 Sep 2026 15:53:01 -0700
Message-ID: <20260914225303.868569-9-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914225303.868569-1-derekjohn.clark@gmail.com>
References: <20260914225303.868569-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renames hid_gos_cfg struct to gos_cfg_drvdata in preparation for later
fixes.

This is a prerequisite for later fixes. No functional change intended.

Fixes: a23f3497bf208c59ad ("HID: hid-lenovo-go-s: Add Lenovo Legion Go S Series HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 39 ++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index f1a0bcfcdb71..e5c4104a3adb 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -32,36 +32,41 @@
 #define GO_S_CFG_INTF_IN	0x84
 #define GO_S_PACKET_SIZE	64
 
-static struct hid_gos_cfg {
-	struct delayed_work gos_cfg_setup;
+static struct gos_cfg_drvdata {
+	/* MCU General Variables */
 	struct completion send_cmd_complete;
-	struct led_classdev *led_cdev;
+	struct delayed_work gos_cfg_setup;
 	struct hid_device *hdev;
 	bool orphan_ack_pending;
 	struct mutex cfg_mutex; /*ensure single synchronous output report*/
-	bool gp_registered;
-	bool rgb_registered;
 	int cmd_status;
+
+	/* Gamepad Variables */
 	u8 gp_auto_sleep_time;
-	u8 gp_dpad_mode;
-	u8 gp_mode;
-	u8 gp_poll_rate;
-	u8 imu_bypass_en;
 	u8 imu_manufacturer;
+	bool gp_registered;
+	u8 tp_windows_mode;
+	u8 tp_manufacturer;
+	u8 tp_linux_mode;
+	u8 imu_bypass_en;
 	u8 imu_sensor_en;
+	u8 gp_dpad_mode;
+	u8 gp_poll_rate;
 	u8 mcu_id[12];
 	u8 mouse_step;
+	u8 tp_version;
+	u8 gp_mode;
 	u8 os_mode;
-	u8 rgb_effect;
-	u8 rgb_en;
-	u8 rgb_mode;
+	u8 tp_en;
+
+	/* RGB Variables */
+	struct led_classdev *led_cdev;
+	bool rgb_registered;
 	u8 rgb_profile;
+	u8 rgb_effect;
 	u8 rgb_speed;
-	u8 tp_en;
-	u8 tp_linux_mode;
-	u8 tp_windows_mode;
-	u8 tp_version;
-	u8 tp_manufacturer;
+	u8 rgb_mode;
+	u8 rgb_en;
 } drvdata;
 
 struct gos_cfg_attr {
-- 
2.55.0

