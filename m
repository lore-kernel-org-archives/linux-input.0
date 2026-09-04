Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB744AB81
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520762; cv=none; b=sMyqCxkMY3LIJrSH5FREcsebIHD23zgiipcL/xr05LbUxnN5HX1d/Xidxp/dA5MUnr88itoX08XlTLj//RvK5l/rPn5RhjeBKWsxMnn7PxlvnnsKbr+yypN3H7rghIqAAuV21D5slpGsZZgGdRmBrIXGYIMWmASmX4BtZi8yers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520762; c=relaxed/simple;
	bh=4FbJsU1y3bxVZb6uLxAYt9aA6kLq4fX8b3TGqqY0Ujs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIkWhreSzVqYmV0ZXkpZT19a8j8ksGW01b7Kro0PlevkXvcrGDPuhKRcfI1z0/6G6PsMnYUA438R4v+r0b00j/xMpdkVVaBcUkW1IUKkDcJlylz/eagUYCh4Mr/puUxzZDq01qXkOn0FHuQNi7trEJ1J0FYVgTVPkXjpRiH8n8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvEp6orl; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvEp6orl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d91ff7d9acso7845895ad.3
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 04:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520760; x=1789125560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bRH9NLWj3veDgRtEBUkvu/4GOMF1+Ix0zuaRZ5NgKNI=;
        b=fvEp6orlikW1WCggwTRT8UiTk7rXDKtPkjmwmxtG/Z284ihvb9QcIyPgoLGkyU35J3
         vTfj+38aJ41rGRJRUAunnh5Dcom4JJ71cpan+roUaYqpIBitAxE7bEVn/uhO6coGxQne
         W9V+DbW6XhclqumwGwz7VcaWt/iZZVxRgvxROTol/bxm9pWTPE0b9+aORVHROhgwrjV3
         Fd73WG1x/JcEtTpWCYnubSHwETZ3vCNsCXGju6W6PMwWc73V2QeJxeng9MYaFv+5IhpU
         +6reb6FBLGidLBoHTtdi4KDqyDKNoqcKCxG+VpIx5GpYhzxnOMMzgX5bhoDf4tjRjYXX
         fx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520760; x=1789125560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bRH9NLWj3veDgRtEBUkvu/4GOMF1+Ix0zuaRZ5NgKNI=;
        b=X2g6H8DFklGXQMRThHYOGMLzjUMCkgv71Kf+TnumGDM+S+CruzmVsOClPchDjE1V4s
         O6sx7IYrnvlEUcBHBInfuw+VSlO8ihdFQhQqyCwvrWT1jteDZlpjaFo6cMI0/HUDvTOk
         HTDqZ0id/cKfR/JSqHiUcha+2HBUAWqs6S5cJSAMw+YWNM1bEOOgShNIlKKHeLLNiEk0
         /PGSV5Yvwx39SEq6/iWVv0bm1WupBt8b1rBxQs9TVTsdFyurBjg/9EfXz/fZVRLlHe+c
         VjeDeRQii1r3Ihn7Jj70fKzvaFMvngwBYrBZOcoSqMas8xIFoa3ncOUY20Ju48p0DeeS
         iagg==
X-Forwarded-Encrypted: i=1; AKwUvBxQnY5VeIpMMkX6GRFKMFLo4Sf6Yog9U1/De6ZsTr7HXzfM120v4UyJskNT8+0Zv/2+K+RPlJ+5G1OQ8g==@vger.kernel.org
X-Gm-Message-State: AFuF++llgT5mBrpm6iz/McApQ1nwGTLxc4/5yd4SvdwEJKbrCX1QSkW8
	QYwFhXdlSbmEtmH3RcNyvkMRJzcT+MDTsb+BL0EEn9uLsc521BsyCO9P
X-Gm-Gg: AYBFou3G9xpjZz9xaagzlEYI83+2DfUKi98rAv7MezdskR4Dg5u1bhdL7Rl1SogEUc/
	jz4EG8/2Jyrci4dImv3eSiCYhOsHROq2bSUMqfZnrCFR245onYgchyYDTVemNxxs58+YTCHju76
	1Utk9YfVlJ9oUfNeh50k2BxMNiBAkV3DT2RXpGmfd8+uEvNXR/10OcWYMQc13wHZvgybBy5MY5j
	agHwjyl/YLBz7tkrlJA4vECU/SO4QJG8BhrEbI/pD+m+r7V/U8AhJsFOhMCwh4no9SB5iIuL+lE
	OFkDAGA++RE+XkdtJnPV6g3W5qg3gjpzVqGTa9R1YGNa+ECHp2KjWKCWLNLfUCb3BY5Yx3gR+ES
	Rg/vZnN7gZPMCqXtHGS94kKxkdHeIdlvr0SxvHYkSCPVfSzVgyM36n749PKic46m+Fvg0dIh7CK
	UrX8Sn9vMZJU7qMcP1a5mvPCSMW/FWA9ePu2H6jqAfKzgbBdZWHtRQtnrFZhu4At5SY5JqJuG44
	/AG57f2NodqQ9sVMrE7FRhqVr4tr6I3rhNH8g==
X-Received: by 2002:a17:90b:39a7:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-39b26125efemr7563823a91.10.1788520759802;
        Fri, 04 Sep 2026 04:19:19 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339befdefcsm5190103eec.29.2026.09.04.04.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:19:19 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] input: fix typos in comments
Date: Fri,  4 Sep 2026 16:49:07 +0530
Message-ID: <20260904111911.32224-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904111911.32224-1-hemanth.selam@gmail.com>
References: <20260904111911.32224-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/input/keyboard/imx_keypad.c        | 2 +-
 drivers/input/keyboard/pxa27x_keypad.c     | 2 +-
 drivers/input/mouse/elantech.h             | 2 +-
 drivers/input/rmi4/rmi_f54.c               | 2 +-
 drivers/input/touchscreen/exc3000.c        | 2 +-
 drivers/input/touchscreen/usbtouchscreen.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index ccde60cd6bb3..9e0898588e06 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -396,7 +396,7 @@ static int imx_keypad_open(struct input_dev *dev)
 
 	imx_keypad_config(keypad);
 
-	/* Sanity control, not all the rows must be actived now. */
+	/* Sanity control, not all the rows must be activated now. */
 	if ((readw(keypad->mmio_base + KPDR) & keypad->rows_en_mask) == 0) {
 		dev_err(&dev->dev,
 			"too many keys pressed, control pins initialisation\n");
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 4519eecb317b..320021e9d81b 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -522,7 +522,7 @@ static void pxa27x_keypad_config(struct pxa27x_keypad *keypad)
 		direct_key_num = keypad->direct_key_num;
 
 	/*
-	 * Direct keys usage may not start from KP_DKIN0, check the platfrom
+	 * Direct keys usage may not start from KP_DKIN0, check the platform
 	 * mask data to config the specific.
 	 */
 	if (!keypad->direct_key_mask)
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 571e6ca11d33..a2ab57a11b64 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -57,7 +57,7 @@
 
 /*
  * One hard to find application note states that X axis range is 0 to 576
- * and Y axis range is 0 to 384 for harware version 1.
+ * and Y axis range is 0 to 384 for hardware version 1.
  * Edge fuzz might be necessary because of bezel around the touchpad
  */
 #define ETP_EDGE_FUZZ_V1		32
diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 6c6cdec7da9e..43a4e262cd2b 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -193,7 +193,7 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
 
 	/*
 	 * Small delay after disabling interrupts to avoid race condition
-	 * in firmare. This value is a bit higher than absolutely necessary.
+	 * in firmware. This value is a bit higher than absolutely necessary.
 	 * Should be removed once issue is resolved in firmware.
 	 */
 	usleep_range(2000, 3000);
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
index 037bb35238a3..e18e74781c58 100644
--- a/drivers/input/touchscreen/exc3000.c
+++ b/drivers/input/touchscreen/exc3000.c
@@ -406,7 +406,7 @@ static int exc3000_probe(struct i2c_client *client)
 	 * ensures, that the device probe will not fail for temporary issues
 	 * on the bus.  This is not needed for the sysfs calls (userspace
 	 * will receive the error code and can start another query) and
-	 * cannot be done for touch events (but that only means loosing one
+	 * cannot be done for touch events (but that only means losing one
 	 * or two touch events anyways).
 	 */
 	for (retry = 0; retry < 3; retry++) {
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 0bbacb517c28..81d24f5fbcc4 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -51,7 +51,7 @@ static bool hwcalib_xy;
 module_param(hwcalib_xy, bool, 0644);
 MODULE_PARM_DESC(hwcalib_xy, "If set hw-calibrated X/Y are used if available");
 
-/* device specifc data/functions */
+/* device specific data/functions */
 struct usbtouch_usb;
 struct usbtouch_device_info {
 	int min_xc, max_xc;
-- 
2.48.1

