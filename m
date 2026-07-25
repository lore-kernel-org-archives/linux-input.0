Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6702314A8E
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964744; cv=none; b=PG4GG4+cIeD+dmNXmYnC0VS/P83j4FY8No7KEjVMCxtsgx8t39Zkr/4y8+0q8bdsXOlWMAJtdK/oG+lvGk/bp/XgDlyzxa724+9TvwVRyaA6DlZyCJIAOsWiiPJMx0Eg9WDVfMMuyC7DHaOHistl+5Nx66z+0PpxKmjuWAwdNqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964744; c=relaxed/simple;
	bh=VD0xIociW82aBeurLRpBqUbCiPYHYICDGIcMfrmvYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uacOucE+nT1NWkQF1bQJIP72jWrZb1kONa208VWYhoFkY/BwoTGFRK+6+ZpI/VgWfZ/Mx6tk/kroAIzvgRqs9eK7eKXFwZg+ulekya5wsa1u27KqaI9gMbEzQCxBIOf5wJBR8ytvl+Vt6zrKsCOxnInqKWGzylVLqBtxfPfpLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YriIJm7d; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YriIJm7d"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a4c6081f9fso255325b6e.3
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784964741; x=1785569541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V02uRN29uXtZKMu3y18L5jDR+JLnN3WeCEmj8FgdeXY=;
        b=YriIJm7dO3Gbg576JU1IP5aWJ9qAwUi7G7pkDn8xfpXV6yHTzyx0q6Mm9ZlBCZn/Aj
         d5cKzFvjKOVWj/QQ4L1VBqOfC32pyIRfFcffgSwGYCnv1DL7+ZRrGluFmOKiEdslJAgu
         +5EuXuEKcgzp7z8go1DF8uWu7Qmpm/M2fRCbTLrsfC7RO3+L/Mo1e9ljk4PcFMz0jmXu
         b9eR/YDHNZGlWJfBEQSfabnF3foEJYczBihiWNQ6JT/sOu8mSpNTrUh0TRDtDfp/riiU
         knlJVtBfeUq5wgmEUqBIKyg6vDYpM8JKpYYX3Lm9LsF65W6VxglJTfkpewM7XjTTZO+c
         xd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784964741; x=1785569541;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V02uRN29uXtZKMu3y18L5jDR+JLnN3WeCEmj8FgdeXY=;
        b=BjahxgH7QuBR8vaYVdpLaD0i5lUkbJuW6RPYuJKLLRDWxcb+JrnVu/iDnwVIve92Hk
         U+CRNKJ60/Mrhwhxhowx0tUFthAO+Xb2WUCmZ8obduvKqdYp3RWq/o9cxfgM+pNgGuI4
         qyGsxHCf5E+Z87kV/81rWcTDH0V3o5k3TksjYSNfsdzdBZdjiRQWG+jem1Flzh5dQcjC
         GG8vkG1Z/YB4hwwteSZecOxTKIPs69mZuHea/zbtyovo2KiWunQ6h7Hv9fLqgWCZLeJ1
         cK6BNjZVB0Vs5DqOk7x75TjOZUU/bC5n6Pr8vi20U0giGNKpquX3owMWdnvqGD/xsvWf
         o6+w==
X-Forwarded-Encrypted: i=1; AHgh+RoVwz3b3gxk4MNeMfJ6jQgvPZeRY116O5hWn/BPCx2KmAXdbMukkwE3KNhwRZoIDHnJUts17h2qIMhW9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhBMAeab9x/CghM30RM2z40jtXchnrZMZecq7k8ZGuf85x4BU
	4lnWvqn9CdVBM7iJi7dCicx9j0ie5SqDWld36J5wAleHwqpTUplj81ae
X-Gm-Gg: AR+sD10FiFLMcow+l5BTFq3AJ1Zri0VPjh+LEw2LZAVhllv0On8s9J+2WmltXTmTduX
	YC4IEIOEFYmVLbZKe8w44Q07kD7K3eUq9/kIghEZcZTVy6m0ghjI8Y9/A5Ub+AKRyBFSsuvj8Yc
	Iat4+kSAnyGVHJ8DLJDKWgCU4lX7aGx0463/SWMNyZNRDFjrj3H2ExjcmAms3F0z7E95JMqejkc
	GGEStG2rm3ZXxEBumG+22danQbVsE2N3Z/oFBE+ZSbLev5NNEOCwsXngloEEjUkZevQZJdbu3lt
	+X3KYS9gJIdjZCsbdJgsX54CLNXGR8UA8HYeGt3qy+x5xJ5jxo/el2mya9dPaEoVVrVuPtN3I74
	iHYZ86G1YvIDu/U+KIUZCpQ8AuWugxNfvq5TV9ySQGVshbotwQCSEKO2ENDrn0ZUIKKnvaPBh+j
	RU7gO5oCn+V5SX3ZQhwIY=
X-Received: by 2002:a05:6808:30a0:b0:4a4:dfff:2daa with SMTP id 5614622812f47-4ab6a246bfdmr1447852b6e.20.1784964741328;
        Sat, 25 Jul 2026 00:32:21 -0700 (PDT)
Received: from u-ThinkPad-X1-Extreme-Gen-4i ([192.3.12.183])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab3b21331esm4823598b6e.14.2026.07.25.00.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:32:20 -0700 (PDT)
From: Aaron Ma <mapengyu@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	linux-kernel@vger.kernel.org
Cc: Sanjay Govind <sanjay.govind9@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Shengyu Qu <wiagn233@outlook.com>,
	Aaron Ma <mapengyu@gmail.com>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Dmitriy Zharov <contact@zharov.dev>
Subject: [PATCH 1/2] Input: xpad - query MS OS descriptor for BTP-KP20D
Date: Sat, 25 Jul 2026 15:28:12 +0800
Message-ID: <20260725072813.339112-1-mapengyu@gmail.com>
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

