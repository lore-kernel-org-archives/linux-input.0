Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DE47DFA9
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791044132; cv=none; b=muj6cKB8icNv2lk0HS1Y5fhcoPamxf+IzQN0ZSrOh2wid50DNg81Ihsf7+KERrZ/qV9aIkStKbJkzJIPe67JbevSPWje+/1NML0n3p9wewoK8mYD4YXdZnuT93lgwZqFsZkvyYuXN0DBfqDz0urS+UqwMXWTMIpcPg3jdHlYaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791044132; c=relaxed/simple;
	bh=bxisQsgFDxVcPmRAf2hDN2l4UAGPTaJHRCBSnoTYF8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SdBXChLqem/mSRwaT1OGmi0q8VjNZs8o0RkdQIOYEo3Wt4+sOfVMy2JeWeJS44cb/4A8YCKiNkTg6ZITAnzkFvQ6P/mcnP2j4Y+eRy9zR+vejUfHJXxdWyDAxqWEdG9Xg2UBysJiIF3rVHSVCqD8eGyng1vQ+dAY9TGV+Q+RKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRGb9ZGx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRGb9ZGx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso207092a91.1
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791044128; x=1791648928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4MTgteFvYBViboMc4I1zLfVHFmkPVniNSEl6gM5tLg=;
        b=ZRGb9ZGxEIjiLbvPT0Y9KtSw79gTMBDgwwxLUNXSKAS/UOnmLimfP6Zzzu1vdgee1d
         6U4fFSsBVsBFzqg7rc15Y9+zJEuUD/dwHJFAFjxk+pAZeLWVOj2ak7Hv2RpuhI0LSZZo
         AVQFe84QYmWy32jcM3s5g6Ucsu35AuhHiGO3NW3P3K5jeJyfCbGweI+beyDteJdSex7m
         AqQ0GBYaKYZc6UhbeqBy52VEw41mnWNmG2M/T1dgTkuH5DJarZ5/iNAvZm4KEqp0IJGz
         +lilYT5qgUterLGOZxNkZAxDAQHtxSUnuNbdYTjf0vSrOKSXDtpovJpy9t+nE7ebJIx1
         IJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791044128; x=1791648928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4MTgteFvYBViboMc4I1zLfVHFmkPVniNSEl6gM5tLg=;
        b=S6K/tvQkF7nDAjqCK6N95pz0NnM2zyvpJMGJsietbeIP0zP44Gz7wndDvdweoc+0KZ
         zzrSE/QVDpW4r1p+ItLgRkRTg4AeI0mnl7afUzVX3V5iyYRKudSUZszmS/NFR2r3tElW
         gt+WYHDJWZn83NjRvIaNQRb+1+8gfjuXEshFO+3LTkJef0pATw0ov8RPpHCsldwWPXsy
         daOFjxR2maoVFHmc0/eoh9U3MhGukriAMsPvM+v+JXUOnUka8nC5j2OrQ7nJIh9VEdYt
         YgQBCcTzaaUHjmgAyYE7W1Zn0sAZ5JuGVL0D8GeIxrqOLTNXAIAt9hjgquA+tTUqk//Z
         zRyg==
X-Gm-Message-State: AFq9FYJDKrBzaiTF0T0LGLs6lJvYEtfLpH8sQUoPujeLtXEZ6hZV/QWD
	vK3mWICBbmtjwzjzF2gsjXQY3T12E+N6XjZnJkNXIlmKGbzMQVT+c/QfNqO7wvPr
X-Gm-Gg: AYBFou1PppJx0ITRU9XgY7Zcl09rDHeObxDUQOlYYk0QJN0LNFDNnMELl6ISzm2FLmz
	HgVV9KjgnbybkMdDaLItfncj2ZxflloczDsf2f3I8pk+Yz2TS3DceNntEeV7vKo+uBZtjzqV+I2
	NhEIDulxDcyLwaGJLx3RcXKHNOO3poTQ8vX5rl+AlWaWbxRyZU9aabo0L36P3EshMjOEytMMW2X
	DMJsR3/XcXvB3hPWAFziiyAdIh3SLvV04hle14sRnR9jxF5sShRgdN7nL2wU3NcYYThaebrf3yQ
	Vg9QXXbYlI9sM0Plo2xP4uU5nov7kxPbmE3KIT4uzm2WkcmmykXlwwOpOHCUxiXTExPmEvOHS/L
	+0eqxJGw3nf1YYJjbpPFldQvnHf38JghDF4WjDHM4MF6PAZn5bxNigkXaZSXOqxgpUETj4NWi7G
	mk287SgUNapNlFcgHTNRFkxYeiFjlOBkbSD/IiQIwQo6KGEcYjpT4eB6fKkh7n1LBDOSdRrG5b4
	g==
X-Received: by 2002:a17:90b:1d43:b0:39d:fcbe:fe04 with SMTP id 98e67ed59e1d1-3a78675860emr1921461a91.2.1791044128127;
        Sat, 03 Oct 2026 09:15:28 -0700 (PDT)
Received: from DPBox ([82.152.91.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4262f0sm3778648a91.4.2026.10.03.09.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 09:15:27 -0700 (PDT)
From: DemonPlayer <a18165943161@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	DemonPlayer <a18165943161@gmail.com>
Subject: [PATCH] HID: apple: Add GANSS GS3104T PRO to the non-Apple keyboard list
Date: Sun,  4 Oct 2026 00:15:08 +0800
Message-ID: <20261003161508.22671-1-a18165943161@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GANSS GS3104T PRO is a tri-mode mechanical keyboard that reports
Apple's vendor and product IDs (05ac:024f) over USB, over its 2.4 GHz
receiver and over Bluetooth, so that macOS recognises it without a
vendor driver.  hid->name is built from the product string only and it
differs per connection mode:

  USB:        "HFD GS3104T PRO"   (iManufacturer is "HFD")
  2.4 GHz:    "GS3104T-PRO 2.4G"  (no iManufacturer)
  Bluetooth:  "GS3104T PRO"

All three descriptors carry the Apple Fn key usage (Usage Page 0xFF00,
Usage 0x03), so hid-apple claims the device in every mode and applies
the Apple function key layout: with the default fnmode=3,
hidinput_apple_event() resolves real_fnmode to 1 (fkeyslast), so the
F-row sends the media keys and Fn has to be held down to get F1-F12.
That is not the behaviour the keyboard has on other operating systems.

hid-apple already keeps a list of such keyboards and switches them to
the fnmode=2 (fkeysfirst) behaviour, but the match is a case-sensitive
strncmp() prefix test against hid->name and none of the three names
matches an existing entry: the "GANSS" one misses because the brand does
not appear in any of the descriptors, and "hfd.cn" does not match
either.  The non-Apple handling is thus never enabled and users have to
pass hid_apple.fnmode=2 on the kernel command line to get the expected
default.

Add all three names to non_apple_keyboards[].

Signed-off-by: DemonPlayer <a18165943161@gmail.com>
---
 drivers/hid/hid-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index f6134c5..75092ee 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -373,6 +373,9 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
 	{ "Thock TKL Wireless" },	/* ENDORFY THOCK TKL BT mode */
 	{ "USB Dongle" },		/* ENDORFY THOCK TKL dongle */
+	{ "HFD GS3104T PRO" },		/* GANSS GS3104T PRO USB mode */
+	{ "GS3104T-PRO 2.4G" },		/* GANSS GS3104T PRO 2.4G dongle */
+	{ "GS3104T PRO" },		/* GANSS GS3104T PRO Bluetooth */
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.56.0

