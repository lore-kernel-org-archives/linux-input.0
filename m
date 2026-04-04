Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1B223E342
	for <linux-input@vger.kernel.org>; Sat,  4 Apr 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775323608; cv=none; b=TBqkbYTA7Z8s1y2nouj3hSRPo94ILzyL+sB7X2Ctzrqz+qwATFAmEjR/oVu5FEoXA8Zl/qhLWLBUoMo9ue1weftg5y/QhrW1ghNB6HTGS5SjfUWuwe8xgOrenHt4mEAuqsmAZuz1ruS0btN+nn61sTlrloSL/j58LL+K2o4Owvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775323608; c=relaxed/simple;
	bh=5xWiTNjyo+mJpXOnxU5E1y5jFzOUe+EWifQKww8ov2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eE4TFBCWyBgsr3Yw+nC83y3v3UiIYWiPYCUSy+wa1mTfYrVRKg0ylp9hoFIgI8h6P5bjbDByBGIUyQerDspBGLTLPG7G9XxGnQfVAzu4BoQPa1roYcsK0osBWgR81Et1IAb0r8TNjn6YAKztzN0qAPl5m4JnzE/tY7ML+dG9ybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kw5U18qf; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw5U18qf"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso1071685e9.0
        for <linux-input@vger.kernel.org>; Sat, 04 Apr 2026 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775323605; x=1775928405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=skOdTK737dpzrXQ1+uHv3U+YwbV8W1PI/Nyjku/wDtY=;
        b=kw5U18qfSFF0Dd6qZviBgMokvgWur2c++CjRIDlIr3zMaNRgn8d732ge2oNHcZv+DR
         v23Fyy50xbw4reNvXd1kfcXX0IdVE0subIfYnaTQpMTV2CHWKLg+BjPiegpE0eyxAWlk
         NnqXqq4V3g7+rxfI83zXUUGxVk7uJ+97DieYFJ96gK+NXy/PjHlGg2ahP1nmCKZkVvk1
         0YDnJwaaU/edcgSQzVcIVlT1hhYk3KdrCLqxPRbm4kyYbuIV54XukwO89xwrW7srbFew
         goh/j93HFR6qVanciMG4mJ6zsLecTPSvxvPIhkx/o2m17oQAq44yb54b5DbX9YUbwZW0
         78OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775323605; x=1775928405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skOdTK737dpzrXQ1+uHv3U+YwbV8W1PI/Nyjku/wDtY=;
        b=GOOUSFyA5EMCMwkvVv6U6GWMxTyzBOGSfMSzbUQ+AYcVwGLqWPiv0n9AgF0+ij30wH
         jMQXoj0s1llUYlaj0VmDRusHdqLAmkXdgXiYiJ0RMLOV/BZ2BBGQ0KKIEelnJqd66tG1
         6uqXzZ1c0atqaeGaTgf+nGSiDIk7K7Y8TrY7dINxFKKZdo8NRiPpoidkvPYruyS/ZaJH
         EJnostcAvZ6QttIAidd/ORNlVJ1+f0gdjp8aEv8dBEdCqVEMacyG4qaeYYXIC+kKH2AW
         +zd5qqHo8QXeLw0xy7LcHienmNBx17sBKMnj42FizunJWGfY7DI/x04QLeMGb6FD0e+v
         3PbA==
X-Gm-Message-State: AOJu0Yxs7zaeC7i099dBORRtVWZY8S6VGWLhOGlIh0rUfGnfGVaj5Mrx
	QkJr2bBWCGRRII1qcGvpoG6naEBDNuok5c+DiNNhcUstZukm+8MCJKArh63P8Pq8vbA=
X-Gm-Gg: AeBDieut/RXQrAbsWpgMSVtziv4L44ih01ULQEOur1vZ4FMiYmjt7VoXOC5i3Ligj6b
	AxyQYOiYW/agK63UPUIGc0CFaIqCzhZDpbS3zCWvTWTg0lJf4x7DvioGs8zl2FGPXbLmPI2k0fG
	TxlsqDCCq+enuvVBQvDR1Ee+/JX3LXBe3u5B4Nw99kwG47aPCXGkW8SEHdfzdA9g0jdCTdhn571
	/mAD8f3zVNFv9C3EQbTwO9DC3sQ2a0afiGTXLaPO/DNMHJBu6qoN//nJezQQiLP0WKQHZrrab2i
	acmxsJ+2B/RttUfTFT87/M5GYWOyNdqfjy9Ph8E6EpyaSRa13BfNUIAd+dXPgFjW9yi6d1fRuz0
	Fvy8/ui0G4NCMnXTQ8QM3nCJ8SBg3GoVyiX1eKNzhY/+A7qhYCF+808i5rQbFu5EMUiNY3d0UKv
	FjfetCN5s4vdJgpbQbcg6Ia7hBp1gA4KecqA==
X-Received: by 2002:a05:600c:4ec7:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488997ee016mr96731115e9.23.1775323604897;
        Sat, 04 Apr 2026 10:26:44 -0700 (PDT)
Received: from fedora.altanet.ts ([2a01:cb20:42:1e00:c6c6:27d3:a694:541f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a706062sm252337515e9.9.2026.04.04.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 10:26:44 -0700 (PDT)
From: =?UTF-8?q?Ren=C3=A9=20Onier?= <rene.onier@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	ivan.gorinov@gmail.com,
	rene.onier@gmail.com
Subject: [PATCH] HID: winwing: add support for URSA MINOR combat joysticks
Date: Sat,  4 Apr 2026 13:26:40 -0400
Message-ID: <20260404172641.195619-1-rene.onier@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add device IDs for the Winwing URSA MINOR Combat Joystick L (0xbc29)
and R (0xbc2a). These joysticks declare 128 buttons in their HID
report descriptor, causing the generic HID driver to reject buttons
above KEY_MAX (767) with "Invalid code" errors.

The URSA MINOR joysticks use buttons in the 33-64 range for grip
controls including the index trigger, so map_more_buttons is set
to 1 to enable the extended KEY_MACRO mapping.

Tested with both left and right URSA MINOR joysticks on kernel 6.19.

Signed-off-by: René Onier <rene.onier@gmail.com>
---
 hid-winwing.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hid-winwing.c b/hid-winwing.c
index ab65dc1..f3e6ea0 100644
--- a/hid-winwing.c
+++ b/hid-winwing.c
@@ -250,6 +250,8 @@ static const struct hid_device_id winwing_devices[] = {
 	{ HID_USB_DEVICE(0x4098, 0xbd64), .driver_data = 1 },  /* TGRIP-15EX */
 	{ HID_USB_DEVICE(0x4098, 0xbe68), .driver_data = 0 },  /* TGRIP-16EX */
 	{ HID_USB_DEVICE(0x4098, 0xbe62), .driver_data = 0 },  /* TGRIP-18   */
+	{ HID_USB_DEVICE(0x4098, 0xbc29), .driver_data = 1 },  /* URSA MINOR L */
+	{ HID_USB_DEVICE(0x4098, 0xbc2a), .driver_data = 1 },  /* URSA MINOR R */
 	{}
 };
 
-- 
2.43.0

