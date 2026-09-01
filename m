Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820834DB72
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 06:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244583; cv=none; b=O9FKf9UlOHLgvsVXo475W8gF6ZhzG+CNwKpBehf0c/QV5I6Rc6AxPEHeePp+bj6tYZCYrOdF/nAYKm56UOULu93YK3olrpQmsWSvJkkGFNrbY+zpyeS2qqUhKq+wIkYuZ7fZWmBAXxZfIvVn8fLyZ7YrK+U0VsViEYU9J3eYqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244583; c=relaxed/simple;
	bh=aEjxZJwZLa+q7K9xSjUy2o9VFRy7tyW3hxCACheKEzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMPIU6Pl54d/RIb7njfygZ89P9mqknfTEQxWu9MoOmMv4gu2SX0RPIHE6R1yn7qm2mclyEuw0QsYIxOLGng8BP52oP/PCMTiPXCRfATPCz4i5jc2cHZgW4bxTJs10ctUiktCIIZhfLQL6eDnDDHGJux+it8hbO4qfo8UxzbL0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LW0/eV0G; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LW0/eV0G"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf433a99so722762a12.2
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 23:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788244582; x=1788849382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xWOAHh0q81CutOvcz4kXnkwApjt4e2WZQIvquKf0gdA=;
        b=LW0/eV0GCjU5Q7Eegs7cRAqdww3dwYBE4QHdHXYHGB/jHl46hpsLwRe24TXaikARaK
         7CokcoxkzO0uFk1arXsaLSiIK9wrWANM7+gNNkGjNihkUG0ORthzofRyGnLLiZm4k7eT
         Opj4ooTqYc6h0mNR0rrKLmA0EqsdgJC/Lv7tz8iR4tD3LJx1YxYhjSMKg0WE6NmRrD5T
         ify/7M91krvUx/TAGIAw47SnAeWQ5YmGv6805gsYxFbuWGDr5Dro4GGuKwCO0TmCAXeK
         2PauxsYQMIQVOv02/6Yym03Qid8gLhYFWTFZ3BYWwfAkDqUAvfxTBmKIyQXvDL//H2ud
         FD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788244582; x=1788849382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWOAHh0q81CutOvcz4kXnkwApjt4e2WZQIvquKf0gdA=;
        b=JxMtjNQixON+ZB19evKutuyJbqRBfCogkZZCbXC2yNNDTwRkhQzTXJzbVgmonI6bcx
         8aZAXebVoIoSwGdD+whebNe/BbXO2YMdTALnT/vRoi0RNHdWadNT7zAP4zclq8qEj79l
         j4eCbszIh9Z7nVQbtka61De6ucjfEi6tzDScbXY8Jn7ULrd+if18Ig8ITpfMP0JsA8QF
         VUXyVzHpBit/VFIfcW0jkoR9W8wd3hf/vxNi7J8V85PDZQY2BriVtpMXS6MV2OhNCxFB
         acdo5GXmoSLyrkzUYLKtl4y9+6RUgBJg9fDiHw7ZQ3c0tx8UsV/BvOLIaJDxaD3CzHKu
         ktAA==
X-Gm-Message-State: AFuF++kXHr7goTkRGoPyGy8g8+YYjYDSZ/w3mPwG5lKctYH9bKrdNMK2
	ss9oFwIYrwifm82a+rOMHKY1FMzkvB5uJgEwecJOpM2D+rk4/xuxVkd/
X-Gm-Gg: AYBFou3ZhiTGy4UmrLdXspTmoR/tEZbLylEBc6GBOwCtmwnXyT1nmN+JWUSVtIRxw3C
	6J6t/OHpy+Jskv3/8vfRFkquGorW4CM61zmFEwKFTH2eDQ/LvGIjftXAM3irR+Bw4RUuQitTL3X
	f+QpnI8UfIrN5z3srB26iZnRK0sJu4HFeG6l7Wbf3hHr/BJKsWapU0+3sGzQZ1/d2zrjhpZofFx
	ZX9Ccp+w1DDuFCxZNGnq6bwGswNlLVTmCMGZj5wytVqOl7NIuE71cKMjma54KCBdfVkWvD8gDo7
	TbuaXWuQWBUNR4oGmallg97k/O12ugXOd0RHEqKSw+oA7H437fgwhp0dqvAiuZKgpIq3XeyOgE3
	7aZWj2zGu16pruLA8h0EWFcA8JmF4QjDYtw1a7QeyxkfYe7ft+WKRl0OcaeAzC82vcH09twOhGy
	MoR9xtEzQusJ3E/r6lFMKX9jZhxtuzZXDY+bktwEVqAw5+XCivEDjhTJdShUm30JVC+RKXsJHjv
	WhQFOgtaqhV6bZ8NKn1l5gh
X-Received: by 2002:a17:90b:164b:b0:38e:4f41:83df with SMTP id 98e67ed59e1d1-396d1007e54mr46589908a91.15.1788244581535;
        Mon, 31 Aug 2026 23:36:21 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.192])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0dc854dsm32694425c88.10.2026.08.31.23.36.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 31 Aug 2026 23:36:20 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/7] HID: hid-lenovo-go: use the right controller selectors
Date: Tue,  1 Sep 2026 12:06:03 +0530
Message-ID: <ec070d00bfb9c9a83b2883ccee62cba7da62028b.1788222001.git.mradityadash@gmail.com>
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

The right imu_enabled attribute selects FEATURE_IMU_BYPASS, and the right
reset attribute targets the left controller.

Select FEATURE_IMU_ENABLE for the right imu_enabled attribute. Target the
right controller for a right reset.

Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Aditya Dash <mradityadash@gmail.com>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index b8248bf8965c..b937d11dd6f6 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -1999,13 +1999,13 @@ LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass_enabled", RIGHT_CONTROLLER,
 		    index, feature_status);
 static DEVICE_ATTR_RO_NAMED(imu_bypass_right_index, "imu_bypass_enabled_index");
 
-static struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_BYPASS };
+static struct go_cfg_attr imu_enabled_right = { FEATURE_IMU_ENABLE };
 LEGO_DEVICE_ATTR_RW(imu_enabled_right, "imu_enabled", RIGHT_CONTROLLER, index,
 		    feature_status);
 static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index");
 
 static struct go_cfg_attr reset_right = { FEATURE_RESET_GAMEPAD };
-LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_status);
+LEGO_DEVICE_ATTR_WO(reset_right, "reset", RIGHT_CONTROLLER, feature_status);
 
 static struct go_cfg_attr rumble_mode_right = { RUMBLE_MODE };
 LEGO_DEVICE_ATTR_RW(rumble_mode_right, "rumble_mode", RIGHT_CONTROLLER, index,
-- 
2.55.0

