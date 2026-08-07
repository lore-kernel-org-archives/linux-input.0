Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10611382F03
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112088; cv=none; b=WZGLui2tqxUHQPHmT14vP/KhaCNIPreziSzuWFyFnQ3TlyBwKxqf3GpiIajNituRmon6Gg3YdhlcbnJrrb6JOE+7+/V0AM/JvWr/zSU5BfiR+UedeamWCz6ciThjIOuaRYUiTi5XB61J75pZ7dlRpMvpqPPzpfxaxhtco8C7QmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112088; c=relaxed/simple;
	bh=Knm8/0lGHsyA0j3ziKYyldxu+k+fKuRAA2B0NxTdea4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MeMD55J5hyKE5GDekz/gKmhXcy0iirHuQ/pDVGp404SfjjgHz+iuBgPeO37VBejH5NAlidIsiAQsjHHoEH/rvCUpnYEcl4FXqLW0ZvfhFfoVp4YPok9acCfRQ3zy9shSxy8Xj/MnM5vyxXY++20stDOGltQFF7DkKJW01+DbGRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vvm0dwwi; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vvm0dwwi"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664e3ed58bcso3215877d50.1
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2026 07:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786112073; x=1786716873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SIQfJy+HLPz7V25SxR2pVr49gT2baFVuKZhhaKE5MM4=;
        b=Vvm0dwwiByE4YmeWQ8QUyyjV5lyLgI3c5OiKq8E1s1RrLNFyDnAA/NnexYPDJ7aQeD
         qeDzY2VjQfbHTJG8j+jN1n38G1IfZTosrjIq4OOrB1roq5EREMXDGRDgmN+P4GqBnsrC
         YOG1ZW4BPjRsO9LYoANGzSaVHPgMeOX30M0XcBACyryfJe0e3bYsRus9Xdg+gP88mQpa
         74C5zTLXu9pq1hUCNQl6iBew4XGW+QbaPATCJxRwxavETt+vq7uNbjgsE3zmUikTMMHI
         86JSQ4EiJfskAUomQKgKuCFVWteEr/9JYXowoNIOZEwi6q+fKUafURBFd11S7MNuREWR
         +kTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786112073; x=1786716873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SIQfJy+HLPz7V25SxR2pVr49gT2baFVuKZhhaKE5MM4=;
        b=bNIIa4rcG9PfDrnClFe8nRckmslTEoS2QHhj7nYo+qUJlERGPqPxw1BEPrQNM9jMLJ
         eYa0n7nUyYu2vTR+0xE94is9gvWYZZaG59C4CS81rv7UlwWp3828XZj6CViG0InWCNo6
         LI6q92lP76zLnAiVTrAZlIa03uJb84ol2EgVtrv1dwYFJKmD/rNAFCAV5sNu4aYMcIa6
         VMctBnRAwS3Q4yKY+h44qUphbWq7lchq90Hy4Mxsj09ml2fz2QJlNgnUED9GbhhxQEVs
         Yicb8Nr7Mm/3RBswRse0Epc7tv/d6ESocrKFT1rpzt8UaeAjZZmS9QCNRzj9Qt/RCtt8
         bybg==
X-Gm-Message-State: AOJu0YwmBQfF/wJnBqqUvcLeDo41u7Ld1G8fL1OTOFlAX2rIalYW4U9L
	qX9WsSGd5KPb8yqGpng02nMJF+dz2gBpUXbGhjdLAuLJT1bJLvM88YbS
X-Gm-Gg: AR+sD13zhXlfadaNkFuoU0KJB2EkbcKNHGBI2bDwGgA/SD4JZzI5GMqow499CxNQuwP
	IgPJB6TmpuTzLzj2GdUDya39wbExesvX2PWt6gNMFPjD+/eX3mokz6BIZsP2c2GZ2J2mzpMVjhi
	sIw15Xu4KNvLkF7Rf3uAV8W+sBZ72Cnts0rrLH2UrILhFwvTDHF+Lc77BA3V8Fei2mb23hugU18
	FiMRW/XtEDWEfBUB4Iu+aSzagtYIuiuJdHSEeNOHVfpudIXGdUOKBT5DvfMsCLi318nV9gjuOWN
	zGY0BRi1f1xfNfMzCAL0X+AeJijWEwfdt3TuwWrvHIlIiGxIOWHB0iXgDfBpy0jD6tsXrlBJkll
	lhIoESbwMUjYyJFvXFT2gN7YjtPKgz0zCtFI4s5+hxQZoqLKh+wpc9hL9otNcG0i8zK++D9FLyi
	VCUlflCbTB4g6wBpV2F/sPufb+8cTr0vUn81ckw/u3A75akrhJUXfWJmuUWdvbZSuYKKFEN6nji
	rjQ0Mdtfqjs2u8vyn4X8ODD
X-Received: by 2002:a05:690e:13ca:b0:66a:d7e5:fcf8 with SMTP id 956f58d0204a3-66ad7e5fd1cmr44586d50.0.1786112072589;
        Fri, 07 Aug 2026 07:14:32 -0700 (PDT)
Received: from bazzite ([2600:1700:6e98:230f:5137:431b:a531:5024])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acad53674sm1274018d50.9.2026.08.07.07.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:14:32 -0700 (PDT)
From: Vernon Di Carlo <vernondicarlo@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vernon Di Carlo <vernondicarlo@gmail.com>
Subject: [PATCH] Input: xpad - fix button mapping on Razer Atrox Xbox One
Date: Fri,  7 Aug 2026 09:14:19 -0500
Message-ID: <20260807141419.7930-1-vernondicarlo@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Razer Atrox Arcade Stick for Xbox One (1532:0a00) does not use
the standard Xbox One input layout for its shoulder and trigger
buttons.

USB captures show that LB and RB are reported in bits 5 and 4 of
byte 5 respectively, opposite to the standard Xbox One mapping.
The digital LT and RT states are reported in bits 7 and 6 of byte
22 instead of the standard analog trigger fields.

As a result, xpad currently reports LB and RB swapped and does not
report LT or RT at all.

Add an Atrox-specific mapping quirk to swap LB/RB and report LT/RT
from their actual locations.

Tested with a Razer Atrox Arcade Stick for Xbox One, USB ID
1532:0a00.

Signed-off-by: Vernon Di Carlo <vernondicarlo@gmail.com>
---
 drivers/input/joystick/xpad.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..b9daa334e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -50,6 +50,7 @@
 #define MAP_PADDLES			BIT(4)
 #define MAP_PROFILE_BUTTON		BIT(5)
 #define MAP_SHARE_OFFSET		BIT(6)
+#define MAP_ATROX			BIT(7)
 
 #define DANCEPAD_MAP_CONFIG	(MAP_DPAD_TO_BUTTONS |			\
 				MAP_TRIGGERS_TO_BUTTONS | MAP_STICKS_TO_NULL)
@@ -280,7 +281,8 @@ static const struct xpad_device {
 	{ 0x1430, 0xf801, "RedOctane Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0601, "BigBen Interactive XBOX 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x146b, 0x0604, "Bigben Interactive DAIJA Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
-	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
+	{ 0x1532, 0x0a00, "Razer Atrox Arcade Stick",
+	  MAP_TRIGGERS_TO_BUTTONS | MAP_ATROX, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a03, "Razer Wildcat", 0, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a29, "Razer Wolverine V2", 0, XTYPE_XBOXONE },
 	{ 0x1532, 0x0a57, "Razer Wolverine V3 Pro (Wired)", 0, XTYPE_XBOX360 },
@@ -1110,8 +1112,13 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		}
 
 		/* TL/TR */
-		input_report_key(dev, BTN_TL,	data[5] & BIT(4));
-		input_report_key(dev, BTN_TR,	data[5] & BIT(5));
+		if (xpad->mapping & MAP_ATROX) {
+			input_report_key(dev, BTN_TL, data[5] & BIT(5));
+			input_report_key(dev, BTN_TR, data[5] & BIT(4));
+		} else {
+			input_report_key(dev, BTN_TL, data[5] & BIT(4));
+			input_report_key(dev, BTN_TR, data[5] & BIT(5));
+		}
 
 		/* stick press left/right */
 		input_report_key(dev, BTN_THUMBL, data[5] & BIT(6));
@@ -1133,10 +1140,15 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 
 		/* triggers left/right */
 		if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
-			input_report_key(dev, BTN_TL2,
-					(__u16) le16_to_cpup((__le16 *)(data + 6)));
-			input_report_key(dev, BTN_TR2,
-					(__u16) le16_to_cpup((__le16 *)(data + 8)));
+			if ((xpad->mapping & MAP_ATROX) && len > 22) {
+				input_report_key(dev, BTN_TL2, data[22] & BIT(7));
+				input_report_key(dev, BTN_TR2, data[22] & BIT(6));
+			} else {
+				input_report_key(dev, BTN_TL2,
+						(__u16) le16_to_cpup((__le16 *)(data + 6)));
+				input_report_key(dev, BTN_TR2,
+						(__u16) le16_to_cpup((__le16 *)(data + 8)));
+			}
 		} else {
 			input_report_abs(dev, ABS_Z,
 					(__u16) le16_to_cpup((__le16 *)(data + 6)));
-- 
2.53.0

