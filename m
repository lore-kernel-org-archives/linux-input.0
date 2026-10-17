Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A783845A7
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201217; cv=none; b=P6IqZr0auBCccVGE2wecWKlNbDy31N9IDGeeE0xpxvHPUzRdwUZO9b/Ezl9VgfO7PPCRiyZa8DPEQvnLc9hZ06ul8dwf8X1twLgeVEUMoKDeOEB2f5JGWZcfLpgu1GhzYPBJ0loBc41ntn6HyuoAWeDuMQhx1+spK7oZnVQMIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201217; c=relaxed/simple;
	bh=1qfCQn/3nkq5j5ecKm8Uade0gaSbZq+iByMXXB5yfm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXTUfuDi8mOV4GdmK5zxti1tggDi+yU6aSOunjZzEyJ0MpZOL15agSIx4sKd2Ry709+0/iVIeJoz1VqL6IrgRDG3EoNB01WMo8D+IfFBZjg9fkL3FhU+sdRIhcUmqQRdTmJ3QpOqnJY3DoSTAmTpvq0Ggkt5hoe1r8X/QVR2tFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLWS0Uwh; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLWS0Uwh"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15dd124bbe7so825164c88.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201214; x=1792806014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NwVXszoQYkhN5ZhSszG9Fvql8BXH+9r0vfKBVLu7pO0=;
        b=VLWS0Uwh1MoGky+MKOAZw99b+h3o2cht5BAtjXp9x8BF0xzAO6WQq5Ld+w86zxpgWj
         sYIf3davJtgivbulsDzqQTR/9LSO4odByRXN4VAUECgPhlCqSFbbik5PBMtEJyG6byxF
         O7Y6421lUnIz1Bum8cW8MW1pNt+6E3LzXVhZ6pQ8lWzOHGk9obhzNWC844HsHcJZfhAx
         5zR7em5qwx57sL8M/w8SYwGnu69GnkTVf0yT+ZaeYeN4lTC+eK+RpB1Pg0ZYSf5siljZ
         a3klhEErar2RHtCsU+iqw30GW2DuiyEuKeUvMZYx1QBBN/BQQF4133jUd4XXTgyoT/o7
         BfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201214; x=1792806014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwVXszoQYkhN5ZhSszG9Fvql8BXH+9r0vfKBVLu7pO0=;
        b=EBtkF22rk6YtmpN4GX4RWDR3zqJ9Mdg1TVOwLuM0qlt4/Iguo487b6ufz8jMJ68ICR
         JOy4091D1IHH8AX7f+II+Ou4ElVrQhdhs+A6CPMOHQ6effVGK2LjyJxGWxR5DYZYkBIT
         +uffoieS7vIkMpRq7zvB0+YdY7kuIopHHA8H156nO6Fk0PLJ4ZaHwftwH0y8ecycHBiC
         GKE+4n0Uh/EDOdAXAg6dljuDsWGNZx+gmPwYxrlvURXLanw4EKH2vejzprBld4/u6lmS
         w75t4DIIDADhzysGjI3JC2aOh0D3U4SrxLTiMJkUdCuowooQa1b9z4T81rQZt0fDq7sv
         CPPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8J0GiJHeGs4AkcW7+olxbc1al/L9yiVa8ojEQt6NaeQojFG49sF0y6mv1Q/mHnqCltZ92CPWx90+Gug==@vger.kernel.org
X-Gm-Message-State: AFq9FYIU3FQCviYbaes6gZl/lHSyRafLifnJrL7B/VAuZnxoDd2OM7Av
	NxOqKNuvKGaAl3JwoTVx/R5G0j/yPrpFYls7TK9u9wZqvkirk+rBR/dAP8GNDQ==
X-Gm-Gg: AYBFou37SGXe08+fQ6WsNrnODYTilUQ3fyDfQPqv+VwCCq7VTkY5IyiR3c4uJldyf46
	BgrkFNaFSwMK+5M9RrfLSO5FsZEsyuEGK+/biJZa8oDsp3jlYwv7q48P4bYpeavvuGxeMwo+K9Z
	3sKXMg1MGeEyfK2sfpA/9V6g1js1sbITOtpSCdWhBI/0/Iqgw3PyaICnkCdYgQZU7rppO/rXpdb
	+/gQbX0AppXwReKpWTFwfxeP8O6MYw74ZUw/WF7XIPE1argK8XAuYwEqzp4zctUCTBrvKdxuRgZ
	Mvk21cUbA3WqYJUP1vUPKUoXTsJ2UBG9DAsCcU2uk3CM12/QhkjM92/i08vuvpfD7cu4+lmYzFT
	9VHY0oCuQb2e3fvEfeAJMAkAb74oAiqw3MRUPurbVKfEtM+NG10hvpB8gmrWE1LmXWqxmjf58I0
	DhXIFnfnBDwDZp2mPC6Ybx88ajTK+ZLXCwKFbr2VA9I0iG5Yu6e9QD+Lr344rfBXu9jnR9N2klM
	SeA4+NeSbog62g1qEJSGl397bGpqGtXlxxtznNv0B30a/NzNPAI2p/8aoRwo7kIXRd1mmUMRYs=
X-Received: by 2002:a05:701b:2086:10b0:17d:7b45:f927 with SMTP id a92af1059eb24-185139aef7dmr2079779c88.33.1792201214184;
        Fri, 16 Oct 2026 18:40:14 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:13 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 08/11] HID: hid-lenovo-go-s: Reorganize and rename hid_gos_cfg
Date: Fri, 16 Oct 2026 18:39:53 -0700
Message-ID: <20261017013956.2440130-9-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
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
index cefb243800b6..136372eb6e6b 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -32,37 +32,42 @@
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
 	int setup_attempts;
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

