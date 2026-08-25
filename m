Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE7A48A2BE
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680507; cv=none; b=tg7LJTaLJueEr6OO43HUl8abU1qGjluXg4GoG956L28HyqHACXyZEY6T3/X8b/jiqUD3fUKh+gQ/Aa4KavKyyKWmDZRCTk+7yMykit8+1hnDW704Huuvx9ewlOk82JdpvXsuIXI2PjqQqiGiShF/PDn52eIX34v8nEbON26KjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680507; c=relaxed/simple;
	bh=eM70yci7T0XXrbCyPf44QOYIULvwrzpMlDydY+jjt48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWTEP8Ssgu5M6ag/qcpHCpIvQ8GJcHTjASzm1msVitcSBWOjKKdXlH3+GWs7aqNsvWaWvynJk6Q3gCbrhc1tLHb+CVJJynY57IypKrJB9wSoYKtnyNCT9HtgA0lfm+kjtBBo/0aEsbW6WkpJS+noyDKkQ0m2PulGOb0nsW5YcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu; spf=pass smtp.mailfrom=azeron.eu; dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b=sEz9p/OK; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azeron.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b="sEz9p/OK"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b45f1cd80eso23661e87.2
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=azeron.eu; s=google; t=1787680503; x=1788285303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=soMEoVv6tn12vff+rAWgJ/AfY6AmARUfXxN5G2m2LGs=;
        b=sEz9p/OKafVLE5rKxDSNQuE8tqIgRoxQoO4sU/YJlOtZ4eJmK6odiIT4YBhMkp0EWd
         W0h/2yXafTB7dVZnKXRO7fl3x68VmQLDmQs5S9IECVsvGAlsxsyabfDtWwUknWsZpxTq
         NQ7UT2x5rBS/XPPlNKD6QmLX4UC3fs6KI2LmASAMhlv2xK+eKg/K4LqTWzGBpbc0Ubkn
         C0LxKu0Up2osjZ79G/VZAIzgXg88e1M9u4iZzo4/jJKxDZSubJ8dnbo9N/4rw49wC3nz
         N628ROXWWxdyCMWO9ItN8AxvChYh8h+PT4H4W4Upo/ElNkUW7eN5Efj7KMcrhalhmlos
         HO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680503; x=1788285303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=soMEoVv6tn12vff+rAWgJ/AfY6AmARUfXxN5G2m2LGs=;
        b=EHYXjz4hMU+dOHEVQkJU0Qo7eZs108lXu0rkeetH5AKvxYcqUNtgHSQ5KpBRqChvYK
         cH8SBWl2Wnrk0k50cLwA6D5+Phw6Y3FJ3XFkGrQJ5OL+BsBDNWXnCQAdakaUC7fe/Gl5
         zrt4KEsoVQf7Rvha3Q4GPqmcrxjUXGqKVKqyanU4/Y4Ks4FoFWV96QVWJRjXclGsCCa6
         YLWLB8Qt/NDng47QGA1nEF26/9SPGpY6J7SYkur0uFX6OsHV7DiKEaId7ZaHAyT9/pFF
         5e/wxs3ksWFlc+nvW4syuSoYBeaJflfdmG/5p7qawd2AGFWqIAyIUx+9pnw3pI0XqVSZ
         P4zQ==
X-Gm-Message-State: AFuF++kZWY1psUUuVfgSyOLlQ4oyalgs2IyfskDvQ+0aPNv6sJqQQnsE
	3nEYAyKbo0OXm7SKpw73NopQPgPNKwJy8DShYghkkjVcwG0ogT+cBHoSrHAENBYXTwNKTl1NfY2
	q49upsXw=
X-Gm-Gg: AR+sD10ZHyLGPIJLJo72GNLEtFAqS6RSm6FOd50DkS1d9FQdz6p4VueUxFCcBS8+u/7
	mUGl1XIwwfdRVzaOH4CSfsYY+geOGv3/wBUK99TGAtGCaBpZpSVOn2KKtMjuMCu/ExcfwmqtD5l
	QZCxLuTfmavumfSW/ei5RbVyN/dtnUKUX3WQzqImBHNNArtbuVPbkeeIThw5MV6O9/wkN/GmAwX
	5LaIrS6NgP4jlFo9etbNDPYOLNChSTwh+D92IW8S4Z3XX+ZZVPmq72wQeRSw+S+tjBXjRM6uWfv
	FrJZpZFKrT5Opiz6AJZ0ihn0GPugFbTeGowwKXcf1VVVmu8g0ox5/pm6LEDtrjZYowN54Z1gdYC
	CA/URXSGkg/11c2gqWuvqa7SGCqWvwQWMaNzye0XTw7spJ4UJUIjn2skaBeYY+ndObP2UaWvTlA
	sUfJRVGvpfu34A3GuPGvmfJW6AqX8vnFDeNPIMNBGZuQPa6z9QRG+1KdJ73+ZVMD6/aMUzSjQKe
	rv97rvlT2pMXw==
X-Received: by 2002:a05:6512:a93:b0:5b0:1760:fabe with SMTP id 2adb3069b0e04-5b48b894c0fmr7679885e87.15.1787680503022;
        Tue, 25 Aug 2026 10:55:03 -0700 (PDT)
Received: from nixos.apollo.lv ([91.105.104.113])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4a41b7390sm82711e87.69.2026.08.25.10.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 10:55:02 -0700 (PDT)
From: Roberts Kursitis <roberts.kursitis@azeron.eu>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberts Kursitis <roberts.kursitis@azeron.eu>
Subject: [PATCH v4] Input: xpad - add support for Azeron devices
Date: Tue, 25 Aug 2026 20:54:41 +0300
Message-ID: <20260825175441.173415-1-roberts.kursitis@azeron.eu>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Azeron controllers (Cyro, Cyborg, Classic/Compact, Cyro Lefty,
Cyborg II and Keyzen) present a standard Xbox 360 controller
interface, so they work with the existing xpad driver once their
USB IDs are added.

The 0x16d0 vendor ID is a shared block, but this is safe because
xpad only binds interfaces that match the Xbox 360 signature.

Tested with an Azeron Keyzen.

Signed-off-by: Roberts Kursitis <roberts.kursitis@azeron.eu>
Cc: stable@vger.kernel.org
---
v3 -> v4:
 - Rebased on current dtor/input next.
 - Dropped the FLAG_NO_LED / FLAG_NO_RUMBLE quirk. Testing an Azeron
   Keyzen showed it accepts the LED and rumble packets without the
   -EPIPE stall assumed in v3, so the quirk is not needed. The patch
   is now just the device-ID additions.

v2 -> v3:
 - Moved the 0x16d0 entries after 0x1689 to keep both tables sorted
   by vendor ID.

 drivers/input/joystick/xpad.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..ed6ae7bf0d3a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -292,6 +292,12 @@ static const struct xpad_device {
 	{ 0x1689, 0xfd00, "Razer Onza Tournament Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfd01, "Razer Onza Classic Edition", 0, XTYPE_XBOX360 },
 	{ 0x1689, 0xfe00, "Razer Sabertooth", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1103, "Azeron Cyro", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x113c, "Azeron Cyborg", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1192, "Azeron Classic/Compact", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x1212, "Azeron Cyro Lefty", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x12f7, "Azeron Cyborg II", 0, XTYPE_XBOX360 },
+	{ 0x16d0, 0x13ea, "Azeron Keyzen", 0, XTYPE_XBOX360 },
 	{ 0x17ef, 0x6182, "Lenovo Legion Controller for Windows", 0, XTYPE_XBOX360 },
 	{ 0x1949, 0x041a, "Amazon Game Controller", 0, XTYPE_XBOX360 },
 	{ 0x1a86, 0xe310, "Legion Go S", 0, XTYPE_XBOX360 },
@@ -533,6 +539,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x15e4),		/* Numark Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x162e),		/* Joytech Xbox 360 controllers */
 	XPAD_XBOX360_VENDOR(0x1689),		/* Razer Onza */
+	XPAD_XBOX360_VENDOR(0x16d0),		/* Azeron controllers */
 	XPAD_XBOX360_VENDOR(0x17ef),		/* Lenovo */
 	XPAD_XBOX360_VENDOR(0x1949),		/* Amazon controllers */
 	XPAD_XBOX360_VENDOR(0x1a86),		/* Nanjing Qinheng Microelectronics (WCH) */
-- 
2.54.0

