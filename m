Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D201F3B85
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 17:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785086139; cv=none; b=Lm9AXCylrZO0ISyYf1XCHBjd/oR+yj/8KcZAeNaah1PJ3eMOPw5QepunVj//ldR//VvO7yGzwa+Fo+QU9V5bD7gYuf/3q8D8mgswdCPymSt6A8ROQhPnjHyEs/lMp0ZinDcDFyiD+D5f+mESjujiUUJDaWmA3qUCWCWVmpcFOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785086139; c=relaxed/simple;
	bh=cjgn1478+T5P73xJlLEUZoOVKQ6XxJ+/qcnEwhZc6d8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dvgMWHtbNrTMqGSNED7bO5DyjhExPXgtk9rZwigNBqLl21ZEIem6rhNsEePP93BQIy9h+f2fb6gxN97GulzA+ECpO07kpNKwMGznlQ09ObgBfirb5wakEQXTjjns+R1w57pHmevzTmN27A2nQ+ZGIT6qSERYqVj1k+NnpIfzZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bpn24yX3; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bpn24yX3"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceae1ed204so19879215ad.0
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785086138; x=1785690938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sDPJ1LpP0ldJdO4mN8ph5m8Vr7Q5Nimh+jZcu3n1H8Y=;
        b=Bpn24yX3ZjdAjDVZPo1GvRkLpMX/M4AyqxbOAmjB9DuGCPy2jLlsaFzLsUIMZUmGDg
         tRA9h2n+DD0fJEPq8f/ZyrF0pKJP1mGOA5wavaJ8iJOfu+WiQimeDWPAxTzJW7BdXBT8
         Bus+rO4+dCz4UyeE7ow6P8y57XrWiKgpTLI9NjwmlVAm4kaLC5LCFWsff0AAtZ7tq5gj
         DZbUwqK0bf4lACTskmt5vowOLZU4uZim7BthBAX5F8OvOmjf9fNC8iKMYkgGp5X13pyC
         nCiz5of0myS84QDCyIl6OSJn3XW6gYcyAqpFT4HFt90vZOXuUnmMamhFuo26VtBv20ah
         iPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785086138; x=1785690938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sDPJ1LpP0ldJdO4mN8ph5m8Vr7Q5Nimh+jZcu3n1H8Y=;
        b=kdGXKK5WCXAy5R+ntz4G4wNR/QLhN3SIXoPgTLvKlttResSPMpb3F5RveXJaO/gmUG
         xhVWRrwgyMbvJWGODY/BH4BabxbbrnL6XniJ9aaajtIuWbtSql00NFDpViP+wf0WXcRW
         PgY62mtb9J8uGxz5mKTLqCOFyQ1qIAkY8brrgxcGUIkvqJj7dttcQnHSbG/YeHoP1MIx
         fkubBwcst5y1Y+aH2RGicktTCLK5CRFbqzDXRiaoPjQw2Zi59EnqpnaPHRY0mRH5QCOe
         FQ3jcvhpLrnGkTp68cI4VIM9zpQSSutsUfjUzFqGbb3zaDqo0NysWg4xNctBpNM+wqN4
         lOxA==
X-Gm-Message-State: AOJu0YwLSVREj1M0zzI4k2sIV7OJWmyhZ1Kjesj/ilzjXihrjancOqr+
	GV1fiLmF9eNz67a4DDzbvODNj38I0JWTWfrCl+01DYJbwaH4NZqzjInFojTNikQHOQU=
X-Gm-Gg: AR+sD112NXzeWTXKdmbTGeEcprEhAlFdagmDw+I0OYewdWueTKNtbvoGnsDb6Bt0BrM
	nLJUJ+YBp0ODyAP5gVHPRiKNl03v/ce/l/Ly+obOuqitMoDW2dsYWuz3oQUeDWvWA3qsCOMRzIg
	OZDNTA3HXhAM7tdTSkcUayoDRF850YGxh3G6QBhIvv/BGDLezKyWmwQeZc7GE28M+lvjDR11AZ3
	OT2LqhPfqX6LcWNI5nK4FhFmyeYWiFkknIinwLuhbpGfwem8RJxbZHh+QT0aeKTD/i1ugtOiOjk
	XUQ4U0agjklmIKdiEKlO/OUDAodxgkVTJh6wveLm7is5wULc1vLwYYXeKg/8p9ySun/LthbxlA8
	s25rJvq7dHR+ox4HejRvMGw3dwE8aqvtn4h0zFZZLfNh1HwG/NTU9IBHhiNaU2hmoZOg8GcqTT2
	B7n+sNkBJ+acEZqQ==
X-Received: by 2002:a05:6a20:b7a7:b0:3c6:61b9:917d with SMTP id adf61e73a8af0-3c67df11232mr5186803637.49.1785086137675;
        Sun, 26 Jul 2026 10:15:37 -0700 (PDT)
Received: from Linux.bbrouter ([115.96.218.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc57ae17sm19890333eec.22.2026.07.26.10.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 10:15:36 -0700 (PDT)
From: Ishaan Dandekar <ishaan.dandekar@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	gregkh@linuxfoundation.org,
	Ishaan Dandekar <ishaan.dandekar@gmail.com>
Subject: [PATCH v2] Input: xpad - add support for generic clone X-Input gamepads
Date: Sun, 26 Jul 2026 22:45:26 +0530
Message-Id: <20260726171526.43071-1-ishaan.dandekar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This device exposes a vendor-specific Xbox 360 interface (0283:0001)
but was previously ignored by the driver, causing it to fall back to
a generic hid interface. Adding its ID to xpad_device and xpad_table
allows it to initialize correctly as an X-Input gamepad.

Signed-off-by: Ishaan Dandekar <ishaan.dandekar@gmail.com>
---
Note to maintainers:
This device exposes a vendor-specific Xbox 360 interface (0283:0001). 
Adding its ID to xpad_device and xpad_table allows it to initialize 
correctly as an X-Input gamepad with full rumble support.

Context: This patch is a companion to a 2-patch series submitted to 
the linux-usb subsystem (v2: "Fix initialization for Generic Clone 
X-Input Gamepads"). The USB patches apply a 255-byte config request 
quirk to prevent this device's firmware from crashing. Once stabilized 
by the USB core, this xpad patch is required to actually route it 
properly. Both can be merged independently.

Changes in v2:
- Wrapped commit message at 72 columns.
- Separated from the USB series to target the input subsystem directly.

 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..c0a15db03 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -99,6 +99,7 @@ static const struct xpad_device {
 } xpad_device[] = {
 	/* Please keep this list sorted by vendor and product ID. */
 	{ 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
+	{ 0x0283, 0x0001, "Generic X-Input Gamepad", 0, XTYPE_XBOX360 },
 	{ 0x0351, 0x1000, "CRKD LP Blueberry Burst Pro Edition (Xbox)", 0, XTYPE_XBOX360 },
 	{ 0x0351, 0x2000, "CRKD LP Black Tribal Edition (Xbox) ", 0, XTYPE_XBOX360 },
 	{ 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
@@ -496,6 +497,7 @@ static const struct usb_device_id xpad_table[] = {
 	 */
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* Xbox USB-IF not-approved class */
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 controller */
+	{ USB_DEVICE(0x0283, 0x0001) }, /* Generic X-Input Gamepad */
 	XPAD_XBOX360_VENDOR(0x0351),		/* CRKD Controllers */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x03f0),		/* HP HyperX Xbox 360 controllers */
-- 
2.34.1

