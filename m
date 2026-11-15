Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794751124;
	b=Jnf4+TNehpU0NWsRtLwOb8v6u8SC/nZv2OsdNYde+jkjfj5V18ktqhiK/suoavu5GMoQ
	 qfl/3frwqkgHahZP31qXxvmoitsJcQpfAJDRBoe5V8Oq07MIz/YLmljz3RF9rBOigmhsW
	 7IJ//is13L4HfoGp1m41s93KMzWAU8B/EuX7AR6TVROujqo2Evx0mH5TJYAymeUL1NQbd
	 2LmZc0oyKbeEKlIWpXkWCp65+V7w6GOXH9CtK5cwBJwZKOWpd43bdltZkofa+rGgIWUTl
	 pBKuqAl+U0FP8xmDsqHnVDy0A6ZCE9NdTGB/INGL0zqh9kC3XcWlNIp3KVT7X1HN3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794751124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=puoRQt9p4YyKE9/BzbAjjcae9LvbnX6JUATeqPyecX8=;
	b=d9S3byz5ocwO/jxZDhUcc9tfjOupznpoHlul7zL9NiqJQrUypMyrecoouXMvdhetQydb
	 t21diiq7gon8p1m8iEtejf2Ie9mqoC/g6Qu8CntzrlHVZFD2r2BP5VBNS02J0DYAhhiHV
	 kGmG4ewG6kw0LpVY1HoeBFDSREFDsEArrWu8NBS6q22t4z4es6XhxVGk84M8fH5GYvBpE
	 BB+PwB3FczAz8wa53HAE3tzUaDnMNzjpJoXy2l00BmAosbfAVDUHkEQROnVkJakBYh5Oq
	 kwkcv+YyfJgjVWXJeMHPbVOaxcxdPqPuk9NPlAyUtl67Pqk2YRP+6NGs/bXHO3MUbWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCRILPvU;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F7B606A31E
	for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 13:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64F7B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCRILPvU
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so27180075e9.3
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 05:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794751123; x=1795355923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=puoRQt9p4YyKE9/BzbAjjcae9LvbnX6JUATeqPyecX8=;
        b=WCRILPvU9gf8POX8ju7SYoZRlvFrh6tXp8SMZSIh0+ZErkv4BcD6Cgs+3Y4V5qwc4Q
         GM+LafhNK214T8sY11Ke5OX/GbYaSC3oYZUvhS+pcZd2Ok7iJuHBFC7LSjrqiFrwBUQw
         fmHVQGJ8Hy+lELUubFMpaxZR8yd8WW0eRnBPXMiPTtI5pUCV3ZRZIyllPbrZIqZEbO3K
         d3FyKq4GMtbcY8LtCzJ/btRT/C6C9cKMLaJueoB6WHFFS2ja75t3LO1aWTIa/hgZoQZp
         UN4VKY4LTWgBBdTBNPnuN69RhzYyt3uglN7SXtohKKfq1PhCDjxIDarnOdGUpiH1bHRs
         REig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794751123; x=1795355923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puoRQt9p4YyKE9/BzbAjjcae9LvbnX6JUATeqPyecX8=;
        b=vNyIYkgy1O0uWAgZFkovEnTSL966fAgh1rsGT6Wg28MQSOXPzV/cE1o0Mzf7YgiQsX
         3zlzwaSItxI1IyV367U+/fh9fp2DrjNFI1ejB2FraXZUim1rfBnnxGCjpSt6GALys26U
         Y0kRwv4I/NX2OuONO8mahyAZ8xT890bOOk7fuP80Vkke77jfUJY0QlcndyV4apMHQFFV
         FAfifCy7Cc2YkowePgMeJA3xYzMnfop8mAg6jjlLhSISnfB0njiRx8uKRKRhfZLIPgKC
         QB3oDV7D19H9+8CWC4/SRqgmW7WYH+HgeH44Smjm56SkEVCyfIkl8OUlO4D7cQcGI34o
         Haow==
X-Gm-Message-State: APuU4Z8vVRLDyLWWXgVj1sE96RzRsWNoNjI95nXJG+egqx+wGl6I0Fw3
	7Kp3EvJGd3RSDAOTkXHXwYK/MGaCOEXEe56sNFMmhaqvMY2sdIoIUnKo+hi4PYvCZhY=
X-Gm-Gg: AYBFou2crf85hICEfRwpV/aAvOl82zF2laHEFD/YtFdw1LbjXcoKWGYJhpycmq5JmC4
	sR33PO1b8ZW1I30ssORlA4HQhlUTKPEeFE/D+VtY2az9WymrKEXmqiR524ls7Pqq4eBCfAk2Mbp
	EYIkR0Xd5xwZRDt4rdwqA92EV8bR0o98GEZCfvZvH3jR1W3KcXIinqYcE3DTRDk5mdlx10dmrat
	Tjuk0viirGOJQwCrxH7VvNZ8uF9XukvgMM7N3xJWzPAGxZdLjqUmz1tFLKS6K3Ip+5jnrsy2SwQ
	w+qQrnQAgnmQKUQO5Egcg4rb2nNTZ3CpniilqYEYxLvOylY3V2S5RIFXwf7EET6lCxJLPyCY6m/
	pMGG0POOKOyqCdcZXXxqFuDskXVmFjLuN/m+eneQpdvWZ1wqmldh8URYu3o254mSH1cMP1tceG3
	ikheukfbfTDaTm8RHoBwkaLpx+hsyX44C9iD+hbPNcL3+tbsZ2oHnnXdeTGwoH7dEMEW5zpeYd6
	a+YX8ZsbV2pgqPqb4eqtgijRSwskI1WNG/vCZMvQKW3WBvIs6JWVMklMWv45pHiPC2g1gCYBVi+
	mpJ/rSo3lV4wtRbIz+AUeFCrxLTtJ9dPergf3chK
X-Received: by 2002:a05:600c:81c9:b0:4a1:83f0:7c91 with SMTP id 5b1f17b1804b1-4bb55a65b31mr157701365e9.18.1794751122786;
        Sun, 15 Nov 2026 05:58:42 -0800 (PST)
Received: from alnutz.home ([2a01:e0a:dfb:f440:f7a6:ce5b:75bc:76a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5d223b21sm18445396f8f.2.2026.11.15.05.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 05:58:42 -0800 (PST)
From: Alexander Gollings <levirootsmanuva2@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Gollings <levirootsmanuva2@gmail.com>
Subject: [PATCH] Input: xpad - add support for GameSir G7 Pro dongle in Xbox mode
Date: Sun, 15 Nov 2026 14:58:14 +0100
Message-ID: <20261115135814.34031-1-levirootsmanuva2@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GameSir G7 Pro 2.4GHz dongle enumerates as 3537:1004 in its Xbox
mode, the same VID/PID as the GameSir T4 Kaleid, which was added as an
Xbox 360 controller in commit 854d2233de0a ("Input: xpad - add GameSir
T4 Kaleid Controller support"). Unlike the T4 Kaleid, the dongle exposes
GIP interfaces (class 0xff, subclass 0x47, protocol 0xd0) and speaks the
Xbox One protocol.

xpad binds to the dongle through the vendor-wide GIP match, but the
device table lookup then forces XTYPE_XBOX360. The GIP power-on packet
is never sent, so the dongle reports no input at all and rumble requests
are ignored.

Make the device table lookup skip XTYPE_XBOX360 entries for interfaces
using the GIP protocol, and add an Xbox One entry for the G7 Pro. Its
36-byte input report carries the Share button in the same place as the
Xbox Series controllers, so enable MAP_SHARE_BUTTON. The T4 Kaleid uses
the Xbox 360 interface protocol and still matches its existing entry.

Tested with two G7 Pro controllers, each paired to its own dongle
(firmware 1.55): sticks, triggers, D-pad, all face, shoulder and stick
buttons, View, Menu, Guide and Share register, and both rumble motors
work, including through Steam Input. The back buttons send nothing in
this mode unless they are remapped on the controller.

This patch was developed with an AI coding assistant (Claude Code,
Claude Opus 5.5). It found the cause from the USB descriptors and the
xpad source, wrote the patch and this changelog, and helped capture raw
GIP reports to locate the Share button. I reviewed the change and tested
it on the hardware described above.

Signed-off-by: Alexander Gollings <levirootsmanuva2@gmail.com>
---
 drivers/input/joystick/xpad.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d2eb48d..f0ceb78 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -406,6 +406,7 @@ static const struct xpad_device {
 	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
 	{ 0x3507, 0x000b, "ZENAIM LEVERLESS", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x1004, "GameSir G7 Pro", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
 	{ 0x3537, 0x1040, "GameSir Nova Lite", 0, XTYPE_XBOX360 },
@@ -2054,6 +2055,30 @@ err_free_input:
 	return error;
 }
 
+/*
+ * Some vendors reuse the VID/PID of an Xbox 360 protocol controller for a
+ * device speaking GIP: GameSir 3537:1004 is the T4 Kaleid, but also the
+ * G7 Pro 2.4GHz dongle in Xbox mode. Never apply an Xbox 360 entry to a GIP
+ * interface.
+ */
+static bool xpad_device_match(const struct xpad_device *xdev,
+			      struct usb_device *udev,
+			      struct usb_interface *intf)
+{
+	const struct usb_interface_descriptor *desc = &intf->cur_altsetting->desc;
+
+	if (le16_to_cpu(udev->descriptor.idVendor) != xdev->idVendor ||
+	    le16_to_cpu(udev->descriptor.idProduct) != xdev->idProduct)
+		return false;
+
+	if (xdev->xtype == XTYPE_XBOX360 &&
+	    desc->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
+	    desc->bInterfaceProtocol == 208)
+		return false;
+
+	return true;
+}
+
 static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
@@ -2065,8 +2090,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		return -ENODEV;
 
 	for (i = 0; xpad_device[i].idVendor; i++) {
-		if ((le16_to_cpu(udev->descriptor.idVendor) == xpad_device[i].idVendor) &&
-		    (le16_to_cpu(udev->descriptor.idProduct) == xpad_device[i].idProduct))
+		if (xpad_device_match(&xpad_device[i], udev, intf))
 			break;
 	}
 
-- 
2.56.1

