Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EEB361DCB
	for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 13:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875716; cv=none; b=IXHNP/xAiPbQVAgajlMamW+NcJnRCAJQPuANOWsqqRNNaTnf4ss4M4iOitQMcVZ3ArWO9vBo7J2M/cD51aZE/KQyuB5BnZGwVHA56vP1G2RACqSaXrwDAmW4Ze2GgM26AAMIUr63iyJMFWr/8zfdD5yUm8j2F7J2JgCJ6Gb2EgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875716; c=relaxed/simple;
	bh=ICoHLniz47xqLQBBSsrvFpW3W48fPCKba7LrD7SZLgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SO/cdUPLmrWeB684OzDjkIfDDrRTeCQvswVSjKz3hWD4ypbQvyzLTuTUCGFumjsyf0Bibyapv6KkBS1dj/sefMZnt1IrHJuow3K0SVb10pMH5RnthwbQhSem1UAeYjI4GIJytlGRjVuLg9yX2VpfgOaQvnh5bMiKzGSIaWufvD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu; spf=pass smtp.mailfrom=azeron.eu; dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b=QnIYXxaY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azeron.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b="QnIYXxaY"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3965bc493caso17264741fa.2
        for <linux-input@vger.kernel.org>; Fri, 19 Jun 2026 06:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=azeron.eu; s=google; t=1781875712; x=1782480512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FY8goGtm0mmVCxzWcUnYtp+ahKGQrhMieAD3suxven8=;
        b=QnIYXxaY1wOZ1ppfaEahW2dxUfLEOb8ocXvBw7ZtgxJPE9rgpGoz61PTholjDtqpTT
         Rz3F5WRYV2RRPCQ7aZ8Mk2J5mU93RiSefHXyWWXeeaA/eO13l2nOUVUqktv0mrL+BTIH
         2CHOFVjL91WlQ+Xd7vNe6Q3Pn4foLg12/TLw5EP6Wcs5ac8BYdgZYShh7sXgSwKQi7xI
         3JQ/aVu7WL4iKQlaB0sHSj9drpXppnBgLpGu4ohfgbw4PW8awLGr77jJEgoSZTyKGcP6
         O/YPM1fpipsntjQdlgADnP9HdezUe4dYJOmszW46P4LUWE2UsCy7CGbtcCmiR276VMt+
         n86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781875712; x=1782480512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FY8goGtm0mmVCxzWcUnYtp+ahKGQrhMieAD3suxven8=;
        b=p3eb6OlTDIY4P/fdA33d87+LIAcxaF7Ed8I2U3+oEFKPhgobKyDxBEQ56II+A3nUx3
         PKp5tVCPo9orkQRMQlbpELsO3ijGApgJD8mne8UwpO1FUKCC6Pkg6OHUL4vZTRJgsUPX
         LKMVXeuL8hHkTIz5DBiy2Uax4+Zj4f1lywGmm1vwEeJ+StRVfDo/iynVMHIBVWAEpSNv
         o+vpTQm4wj7SETEa2C+/3gNfFjmWYuWB2wXq/Lvd8AQCmS6bad4DsC8E5yrgPepDYACC
         2xX+2YWWFFoYwJY7j7PuLeL++4yi7duLRGCPqw/yFLUjM7MLmBzQsC5eB9l/aWoNLTtX
         WDEg==
X-Gm-Message-State: AOJu0YxJeqic6lUOmKS22lq6TPbd0BpizdASiIpCINov06Q7t6tv2ZoF
	+XgknDEnSJCkv2y38XfK4TTolbA6KsqNOoqFxuFfeonw6zS+UJikQ8AGQ0Gdlc0FmmNqw8wwJlw
	uyO5GRnU=
X-Gm-Gg: AfdE7ckkRO3eROdPytoyMJMEkfcM5iVXBhIFSwH7pSBa0pqfeGtlUbjFswpXqHKXqPm
	B84GpTWbK83REicE+fn4R4rBVHIqE72lo+kGn5XfhjZ9KAMSsBJYVQYQVhasBqy1r7OrfwWJg46
	73D7nVtSBbKNh3sxTkpSm7D9pDXpe7Lz9TE3I+OxQngVF9OgON7LCTfJOli1vOb6+7GRMF7KeBc
	mzPs2Z3F7ipZaSfk0xBriMMLhGPRL2Qjjv9fzmDUwV/P0vl+wLod/jJCtB0YD0iUi6gI+9ExA7S
	q/e2MmfkBd7YhYKJr26lmfwbUWqtqFEP2bjNnr+PK2WTIypLz+F3hkAzDM/H3Exu5Q79VDEakcP
	PEwVHAd/4vUY+thMXPdQapN+eAaZe2KocPQZiQemeQYa8WBB2qO/Q+tqdQWyS87ZDZtimg7QDUG
	N9ABiSITOTSbRqFXFbpFCc3lhpy3oApw==
X-Received: by 2002:a05:651c:2108:b0:394:3e27:53d4 with SMTP id 38308e7fff4ca-3998bc21c3emr9689921fa.7.1781875712023;
        Fri, 19 Jun 2026 06:28:32 -0700 (PDT)
Received: from PC-077.localdomain ([94.140.104.242])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3998bfeb7e8sm5231111fa.23.2026.06.19.06.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 06:28:30 -0700 (PDT)
From: Roberts Kursitis <roberts.kursitis@azeron.eu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberts Kursitis <roberts.kursitis@azeron.eu>
Subject: [PATCH v2 1/1] Input: xpad - add support for Azeron devices
Date: Fri, 19 Jun 2026 16:28:21 +0300
Message-ID: <20260619132821.18764-1-roberts.kursitis@azeron.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619121901.17926-1-roberts.kursitis@azeron.eu>
References: <20260619121901.17926-1-roberts.kursitis@azeron.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB Vendor and Product IDs for the Azeron devices (Cyro,
Cyborg, Classic/Compact, Cyro Lefty, Cyborg II and Keyzen).

These devices share a firmware XInput implementation and
expose the standard xbox 360 interface signature. Note that
0x16d0 is a shared vendor block (MCS Electronics / pid.codes
allocations), but is bound here as the XPAD_XBOX360_VENDOR
macro only binds interfaces presenting the strict xbox 360
signature.

Note: Devices may reject the LED magic-packet with -EPIPE.
These devices reject the Xbox 360 LED magic packet with a stall
(-EPIPE). Add a QUIRK_NO_LED flag, set on all Azeron entries, so
xpad_led_probe() skips LED initialization for them.

Signed-off-by: Roberts Kursitis <roberts.kursitis@azeron.eu>
---
 drivers/input/joystick/xpad.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..4efcd16c3 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -50,6 +50,7 @@
 #define MAP_PADDLES			BIT(4)
 #define MAP_PROFILE_BUTTON		BIT(5)
 #define MAP_SHARE_OFFSET		BIT(6)
+#define QUIRK_NO_LED			BIT(7)
 
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
@@ -289,6 +290,12 @@ static const struct xpad_device {
 	{ 0x15e4, 0x3f0a, "Xbox Airflo wired controller", 0, XTYPE_XBOX360 },
 	{ 0x15e4, 0x3f10, "Batarang Xbox 360 controller", 0, XTYPE_XBOX360 },
 	{ 0x162e, 0xbeef, "Joytech Neo-Se Take2", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1103, "Azeron Cyro", QUIRK_NO_LED, XTYPE_XBOX360 },
+	{ 0x16d0, 0x113c, "Azeron Cyborg", QUIRK_NO_LED, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1192, "Azeron Classic/Compact", QUIRK_NO_LED, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1212, "Azeron Cyro Lefty", QUIRK_NO_LED, XTYPE_XBOX360 },
+	{ 0x16d0, 0x12f7, "Azeron Cyborg II", QUIRK_NO_LED, XTYPE_XBOX360 },
+	{ 0x16d0, 0x13ea, "Azeron Keyzen", QUIRK_NO_LED, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
@@ -532,6 +539,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOXONE_VENDOR(0x1532),		/* Razer Wildcat */
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
+	XPAD_XBOX360_VENDOR(0x16d0),		/* Azeron controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
 	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
@@ -1719,6 +1727,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	struct led_classdev *led_cdev;
 	int error;
 
+	if (xpad->mapping & QUIRK_NO_LED)
+		return 0;
+
 	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
-- 
2.43.0

