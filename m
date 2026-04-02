Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9A28643C;
	Thu,  2 Apr 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145680; cv=none; b=uUq61/A/5AF9YEY85Fmv0cXidCkzskjuG9GESL0k63CJVBcPUBMsftaU674WPFXopjDQaX7Fh9BqPE1xdQbiXElnoO6rT57fDVJkqHEeMAH5nqG77Wff6/XMGkrQXqxJIF78XOZR9JpJIUlh6DxFw79+lU9x62gg5kzSUXLxCEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145680; c=relaxed/simple;
	bh=KHRihAGGsHauZBPjlRB3rhuKAhewWChjxrG5vcIgGJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUU/66TJgqp4cu27PxJpLrHvqrxQiVVA93hO9F804WFhYHmAkeTStCZU0BI/CFDnNU+PGdFNeyK7mHNjucAjx4yz67YPTCufZezDreUVhFrAlOSt3JPcHjqGUSGC357cT3PeW44BsT3ZJ+6swU8v5HxrNyvMmfn7VcLwHtxdE6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=El9wDeMb; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=mvY3Mz9C; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="El9wDeMb";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mvY3Mz9C"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fmmmr2Nxcz9vPP;
	Thu,  2 Apr 2026 18:01:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775145676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YQcYj4F5FPtBaPpjP0DI7ebJORyqPZ/maPs2DBC/QE4=;
	b=El9wDeMbRU4m0C3cwlJLDY527j/iZ/0xOIwHQBx1+KkV+JFn6tNhL+ZxKbWAy9Nc30lujT
	rhJiHVM9XEtVWezgOFDIvHoOLg6PoThNfkp0weP9PzYY4W6jjMPmnj6QPcvQ+C7xgKBwX8
	pzuh0YtaDAZnMM+SU5jb2yHkWyIeLrUAu7hJZpoR4Bju4uaCL2c0K3rPnFUUWeAZdJBTtD
	gFHmchG4GOzTQxys00ENyJCxZLp+574JAkLta6B6kR/Bn4+cvD2aTxuCXMBiVuRf5+cOUQ
	YK7lXzG+DWORBAcC8nYnSGjRTu2ABcbEIi6lSM5HnO/dFtL+OYdSPu6BRXb8xA==
From: Rosalie Wanders <rosalie@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775145673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YQcYj4F5FPtBaPpjP0DI7ebJORyqPZ/maPs2DBC/QE4=;
	b=mvY3Mz9CPTcjBIJVWb5AVM37xU6JrRCJU9/sWYJOYmLlV2qVulZ84mYFhGAQuwjstgFh8h
	l3jmnKJfgZiVJnnfdgkaEdpzJGjZAQUyjwTvY4A4a+c9SJRV62WhUouEKzVAliTismytkq
	LGar2jyihACBkzR2sn+aCgAaZxNMHKFk/nQprcsRNvconx9PiBZWB/pSpzPT3xgJwMTng9
	AL1i4XvyMhqkh14ce5FncgxnG6nhK3EoIPkgEdeIdsK4kOsqxyAuDoLT3gHpeFKjoTKxKB
	F222VflZ7L7trhqVVXw+Co822G79EA7A/eoW3dq5e79NW7jm8tKQu4tdVl2gEA==
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Rosalie Wanders <rosalie@mailbox.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: sony: update module description
Date: Thu,  2 Apr 2026 17:59:15 +0200
Message-ID: <20260402155915.17745-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 894a8fca85fc3277746
X-MBO-RS-META: fe5rifjejx8ifnny5orchwkxi3n9m9pa

This commit updates the hid-sony module description to make it correct
with the recent hid-sony changes alongside making it more consistent.

Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
---
 drivers/hid/Kconfig    | 12 +++++++-----
 drivers/hid/hid-sony.c |  6 +++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c1d9f7c6a5f2..b287023437ca 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1100,13 +1100,15 @@ config HID_SONY
 	help
 	Support for
 
-	  * Sony PS3 6-axis controllers
+	  * Sixaxis controllers for PS3
 	  * Buzz controllers
-	  * Sony PS3 Blue-ray Disk Remote Control (Bluetooth)
-	  * Logitech Harmony adapter for Sony Playstation 3 (Bluetooth)
-	  * Guitar Hero Live PS3, Wii U and PS4 guitar dongles
-	  * Guitar Hero PS3 and PC guitar dongles
+	  * Blu-ray Disc Remote Control for PS3
+	  * Logitech Harmony adapter for PS3
+	  * Guitar Hero Live PS3, Wii U and PS4 guitars
+	  * Guitar Hero PS3 and PC guitars
+	  * Rock Band 1, 2 and 3 PS3 and Wii instruments
 	  * Rock Band 4 PS4 and PS5 guitars
+	  * DJ Hero Turntable for PS3
 
 config SONY_FF
 	bool "Sony PS2/3/4 accessories force feedback support"
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4b0992cfc8a7..bd4b4a470869 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  HID driver for Sony / PS2 / PS3 / PS4 / PS5 BD devices.
+ *  HID driver for Sony / PS2 / PS3 BD / PS4 / PS5 devices.
  *
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
@@ -68,7 +68,7 @@
 #define RB4_GUITAR_PS4_BT         BIT(19)
 #define RB4_GUITAR_PS5            BIT(20)
 #define RB3_PS3_PRO_INSTRUMENT    BIT(21)
-#define PS3_DJH_TURNTABLE		  BIT(22)
+#define PS3_DJH_TURNTABLE         BIT(22)
 
 #define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define MOTION_CONTROLLER (MOTION_CONTROLLER_USB | MOTION_CONTROLLER_BT)
@@ -2616,5 +2616,5 @@ static void __exit sony_exit(void)
 module_init(sony_init);
 module_exit(sony_exit);
 
-MODULE_DESCRIPTION("HID driver for Sony / PS2 / PS3 / PS4 / PS5 BD devices");
+MODULE_DESCRIPTION("HID driver for Sony / PS2 / PS3 BD / PS4 / PS5 devices");
 MODULE_LICENSE("GPL");
-- 
2.53.0

