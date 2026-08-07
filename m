Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D393306B3D
	for <linux-input@vger.kernel.org>; Fri,  7 Aug 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113749; cv=none; b=HJCU4nrJcXOzgqb3KIskZEGf3N56g5Mc0t8zDzT7sFalQKEuFB7FrBWp2wjLjCLvbrfxwLScLgZkyMdPqi6CxXRYCYzlpTXhfSlwM+pfDFKzhR7lnQuy/mu2HP2a1IDJnNsAwr1liq0sObQfv6lXxvLhEURcScz4Mfjxx+I30Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113749; c=relaxed/simple;
	bh=sB1wIil8ji8uuAzgG2pgxytjcyOrHowd0QZCiec5oqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xp5BI3ruaGAuP1Fd/T4vo1LetbRiG5hVL9KWx8Na2/a1/DjK1vgdwmckwIZdwke2IltzLBjeFQqqIE5mQjLJLHwM5n6xB2rVhGtPHCTlQhZRvnZTxC1S/5K/BAIQ+J4DUayhqhLs4ZIdAibiM1MoKBBsdplKKgbHthuHrXLjwws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpgDf/r6; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpgDf/r6"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6681e7911b0so5183771d50.0
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2026 07:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786113728; x=1786718528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v+am0fj0IzuuWcSqG87ej4as16IpYc3kisNAaAedKEI=;
        b=PpgDf/r6oTNi5HRhUfw0FRmdDGMZ84cLeGdIcfjDpUcQ6qP8HDDdUoItb6a6zd+YO7
         Q6iHOgpyg3+T6E9O7vajDGMFzA45pjYhjb+C9ISJtPFMD6TwsmGm4NhT2G+mbgDaoPpF
         QvHizM16bqsSFq+i3P6k/oLCiRBE+95uEeh5BfR/2nZx8XgNEHcg1Z4iKViYCZwivGxi
         Aggb4ugnPE97siepgml7w4lqWMa5Tq+cwm5WXNAxl4vkPw5hMrUks2s6Le0mJtAZHceO
         YZcKWUaSaNAvhF9rkVIwz2G1MqMYyd/EVAPP2M3JawMxIkqd8qqFUzEHZlvwjbXAf6oB
         7y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786113728; x=1786718528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v+am0fj0IzuuWcSqG87ej4as16IpYc3kisNAaAedKEI=;
        b=MtPaXunDLdekoLZWaG7f36g6ObmeVCrq5X235QQXg9XVHhldDoMRO3YpNR+GFjftzJ
         wiB3W7xuFvjUxa7o5/KzAtA2IHF44o/ZLYc5gLrdQqXz7cncMZF8WNhvrggc0EwIFEvD
         N0px4QCJsyIdPAZnIeRJ82WvR/3R3WBEskmE9J1X/MqNKlf19SZZM8dSuqdueMVq3c3K
         AgYld/yW0ksWAxWv3eCNapp5kEj1LwMr1i143vxZHvrN38ZDSH+2fUpVnbRMYs9x42Rr
         F7v5r6PxYLGOr3CjBm0+SZr6XjSOfdEtW59ouXhrZyI3p3hfR6iIcY6+bkD+5zLjkfeo
         3hzA==
X-Gm-Message-State: AOJu0YztVYIxkHRhzzlwhpHCRWy/Jw3Ohi0jnmhc37gHjDE98SI5kBBz
	Fk+KdScE1dBbDSuY5ZHa1PAsWTxVBn2EWnyAAbi/AoeT87MJgOdqZ6so
X-Gm-Gg: AR+sD11Kon8reux8KdbMd3/gAp0RFfthZVGFJIOH0mK9b37weHA4CRM9mZBpzVXlBs2
	MAGW7RLCfA2W6rryXSXZJa/XLcuH9vwFdGAVWnh34oWPLhEOAj4xvT0zIARrKsb0tviruVLOvRF
	w/oHSNkFPW9fii3B5fIKLdrIwFk1d5JDsWfI7nid1c9Xo/YmjnKsp2a2b0B4uUp27FxlJT9sUjZ
	1p+yUYwL1jSIbAjyng8rpxEr9ioJ21/N6X0ocSN60AFonUA2xwQ3KRX9gvfLa2YwcI8hdYVrGhQ
	nXZKSlERR4G9u0yY45sysstV2qgwBMuVMd9WSIs31U3YxOuBqxffJKOTxr9uw3h1waE6hVmVhs6
	aTi9io84YyyyLYC+r5xbZ1DCXLJhG/JxqbX5Vo1CFT8/f1emjeFe6XRiXZ/3N1BjpuiOulfYAl1
	b8waP1L2OK7QYzHcG5HAA5PYEz0jwtp5yXUcDGYR6MeCh7b/tY7MAzy1K8UOpoGTMc1B7wGTnBf
	FPZjorcH2vJ7lc/00W9i2McR3n/JqALyxY=
X-Received: by 2002:a05:690e:450b:20b0:668:53e7:5569 with SMTP id 956f58d0204a3-6699ab890f6mr10773341d50.32.1786113728471;
        Fri, 07 Aug 2026 07:42:08 -0700 (PDT)
Received: from bazzite ([2600:1700:6e98:230f:53ee:1d24:42c0:2bc1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66acae8584bsm1377840d50.10.2026.08.07.07.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:42:08 -0700 (PDT)
From: Vernon Di Carlo <vernondicarlo@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vernon Di Carlo <vernondicarlo@gmail.com>
Subject: [PATCH v2] Input: xpad - fix button mapping on Razer Atrox Xbox One
Date: Fri,  7 Aug 2026 09:41:53 -0500
Message-ID: <20260807144153.8430-1-vernondicarlo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807141419.7930-1-vernondicarlo@gmail.com>
References: <20260807141419.7930-1-vernondicarlo@gmail.com>
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

Notes:
    Changes in v2:
    - Reject short Atrox input packets instead of falling back to the
      standard Xbox One trigger layout.

 drivers/input/joystick/xpad.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f..00de9145e 100644
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
@@ -1079,6 +1081,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					 error);
 		}
 	} else if (data[0] == GIP_CMD_INPUT) { /* The main valid packet type for inputs */
+		if ((xpad->mapping & MAP_ATROX) && len <= 22)
+			return;
+
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
@@ -1110,8 +1115,13 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
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
@@ -1133,10 +1143,15 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 
 		/* triggers left/right */
 		if (xpad->mapping & MAP_TRIGGERS_TO_BUTTONS) {
-			input_report_key(dev, BTN_TL2,
-					(__u16) le16_to_cpup((__le16 *)(data + 6)));
-			input_report_key(dev, BTN_TR2,
-					(__u16) le16_to_cpup((__le16 *)(data + 8)));
+			if (xpad->mapping & MAP_ATROX) {
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

