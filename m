Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47B846A
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785571006; cv=none; b=Z8IVmq3o1v2R96QiW4dIRmXeyHBGFv9RONGQy1D08TTcfs4+rQPut1iNU3Bb4XRgTAUGsxiwWFyFMhHsjYkncpZRyV2hTbzj1p+hl59Z9G8Ia73M9I+8F11/JNLCC1JXGdgU42GOIUxZKmbf2YN9Mv08anLDZmKgbsqhVKGA10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785571006; c=relaxed/simple;
	bh=VD0xIociW82aBeurLRpBqUbCiPYHYICDGIcMfrmvYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LCNUQ56qkRXFq8CfNBAxcok1qkPJv+yqv2/sCtka/fFSf3YH84XnQdih/3fI4AiTg5nLioUSdJuq17VVyNKKcYkcRyEUIwJ+/NrqatoPHYiihObuh2vqcxvqpJSUzAfaYxzE+OJLlMVLssJMr4N/DvwmB/Zojf1VLS01waKKuk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUvRsH+C; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUvRsH+C"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4a496b6cc3dso708408b6e.0
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 00:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785571004; x=1786175804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V02uRN29uXtZKMu3y18L5jDR+JLnN3WeCEmj8FgdeXY=;
        b=lUvRsH+CeA57l9J1EmAUtkHMiN6PVKcXTW8Rtws/bbO17avS4v75AW8OmXhQdnLwLQ
         2lObfM0n7xSjJZSewMGwXe6jqE+yB6cRXWslH3tTYkXcPPqnRU9PkU9ERevY3hUKSVXz
         Y5lb49MDHOkeKED0abb2tlkFKSeD3LKRC4V3MDSplg/5D804X0sRAwTMnKWcB8cPjycL
         OYjm6UPF8uCb/4I+xqFM/hp9FkAq2tqCurOQx0zdE1JUj+96ExT6QsOIAjOX1hqMBVjM
         0/chMARAgl5IRcuftedmwtUeUsX7wNk7+MO7xhpU0JLXB0z018QmvpVh9RIZkfgko8pq
         MIbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785571004; x=1786175804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V02uRN29uXtZKMu3y18L5jDR+JLnN3WeCEmj8FgdeXY=;
        b=PMCuaoYWZNGaf60y/6cOqDgdzD+nTu8AjqRZe8/+WhOLAfqTJaCYvkJKFEFahPMCtD
         KwBqWoooOhzLCZX0LxjEZSMxwOwhDhI6Lmr8zstYFAzFgzxz0YYpR5KPgloaoOqCdspl
         By/l4uo+wSNzUyCjGrjfY7XCIhcNGcUL7VucbmPVE1wDpD9tcuQOykf+BdU6pxG5Ss55
         DTcYTnztsUuek7tty/ccpbBT4TVKvHy6R6iYQd45yjGhDHk0RmXOgRHUpYh0YEpLSC1C
         CHDvpDaS4mrZpPVolqAoZG19RbtZSWgtbPigCljNVKO0HRMmOGlUbXqSbokLcR9PaQNX
         uZ4Q==
X-Forwarded-Encrypted: i=1; AHgh+RpUc2n5/HWVsCSIur/jXm2FJneqzL44LRyfke+BYN5OVg73WkpwmqccIPbBdUySD07hAkDWSAK+WmZY0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdB/rGik85QFFufcNOMOEUBnaUR0yFLm39kxWE0NQr5WiNSfe
	aSDA/GwFv2LWqbPqYlcNU1hnLOgiopZ7nXj2ID0a1jnmZPkTpeHm2zUT
X-Gm-Gg: AR+sD12fJTFd+k3LJK5YneaaOJwXlPWMKxGQ23GUHPKIC1poJXQk1F5Ge4Auoa87jX1
	6MF1Pf70Qe0rvxcHHXPvQJcpZj6ltzsXyo2lEBKo4vtHmpzm7KcnJNLoI8rn07s/x+pKYQW2dac
	C47lD2Bx4lRCVuT9F+zmvyDbX/W/M5L+J5A9nTV+uwG+cH14zNsBB7+qJK0OlCkKnGz2CXS8Saj
	tYXNKbHO10mEQmU505kDFKwxIEGLgIsRMJJQcpcPHgY0dJDiPbF8P3QTlgGRUqd8LnQKnd9rBX4
	6mmys3mj8wIYQ9wu2d/fSKOe+nasgwsr9D0Yg5/kAkxQ8fulsNKN8AAOJ5REYx6HJHmMYo6tdQw
	YnKLJTggitFmToiuvnKAoxLiiekgidhariQCo7T6wFau0Kyug19Apjp7NKedXMXcZrd/I+Mq2QS
	vuR6wwpeHqL9Ot+5kWOAJ5nLBWBZHa4I9rrg7e+6m1CqruvjZ/1rvh0VnNyOzZEoUjL55yVaCKZ
	aKXmw==
X-Received: by 2002:a05:6808:c191:b0:495:e92e:d797 with SMTP id 5614622812f47-4af5e1d395fmr5346690b6e.11.1785571003921;
        Sat, 01 Aug 2026 00:56:43 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4af58ce3e8esm2466717b6e.3.2026.08.01.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:56:42 -0700 (PDT)
From: Aaron Ma <mapengyu@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	linux-kernel@vger.kernel.org
Cc: Sanjay Govind <sanjay.govind9@gmail.com>,
	Aaron Ma <mapengyu@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Zoltan Illes <zoliviragh@gmail.com>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Dmitriy Zharov <contact@zharov.dev>
Subject: [PATCH v2 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
Date: Sat,  1 Aug 2026 15:56:22 +0800
Message-ID: <20260801075623.2769601-1-mapengyu@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Beitong BTP-KP20D dongle cycles through its operating modes and
never becomes usable unless the host requests the Microsoft OS string
descriptor at index 0xee. Windows makes this request while discovering
the XUSB10 compatible ID, but Linux USB core does not query Microsoft
OS descriptors.

Add a device-specific quirk that performs the request during probe,
allowing the dongle to remain in Xbox 360 mode.

Signed-off-by: Aaron Ma <mapengyu@gmail.com>
---
 drivers/input/joystick/xpad.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834e..1616047e65f5e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -72,6 +72,7 @@
 #define PKT_XBE2_FW_5_11    4
 
 #define FLAG_DELAY_INIT BIT(0)
+#define FLAG_MS_OS_DESC BIT(1)
 
 static bool dpad_to_buttons;
 module_param(dpad_to_buttons, bool, S_IRUGO);
@@ -334,6 +335,7 @@ static const struct xpad_device {
 	{ 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
 	{ 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX360 },
 	{ 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX360 },
+	{ 0x20bc, 0x5159, "Beitong BTP-KP20D Controller", 0, XTYPE_XBOX360, FLAG_MS_OS_DESC },
 	{ 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Series X|S", 0, XTYPE_XBOXONE },
 	{ 0x20d6, 0x2064, "PowerA Wired Controller for Xbox", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
@@ -786,6 +788,24 @@ static int xpad_start_input(struct usb_xpad *xpad);
 static void xpadone_ack_mode_report(struct usb_xpad *xpad, u8 seq_num);
 static void xpad360w_poweroff_controller(struct usb_xpad *xpad);
 
+static void xpad_query_ms_os_descriptor(struct usb_device *udev)
+{
+	u8 *descriptor;
+	int error;
+
+	descriptor = kmalloc(18, GFP_KERNEL);
+	if (!descriptor)
+		return;
+
+	error = usb_get_descriptor(udev, USB_DT_STRING, 0xee,
+				   descriptor, 18);
+	if (error != 18)
+		dev_warn(&udev->dev,
+			 "unable to query MS OS descriptor: %d\n", error);
+
+	kfree(descriptor);
+}
+
 /*
  *	xpad_process_packet
  *
@@ -2055,6 +2075,9 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			break;
 	}
 
+	if (xpad_device[i].flags & FLAG_MS_OS_DESC)
+		xpad_query_ms_os_descriptor(udev);
+
 	xpad = kzalloc_obj(*xpad);
 	if (!xpad)
 		return -ENOMEM;
-- 
2.53.0

