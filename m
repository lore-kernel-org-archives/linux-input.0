Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129F43784E
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 14:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519340; cv=none; b=lsYJokZlUvcW+zgNUfW68MZlY4oPm0LR1Cf3U69CUWBSmgS0MA0NpseUdj2Uvjucs8fqhIQBy74Zaz6TKvKvDt7O8FhegFjais0ucEY0zM1G2UqfhDXvLYA6BpnLtQuvLfwu+cZRu2g0iZrh9RkJ3OAcNDTGpLexN0sYci861v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519340; c=relaxed/simple;
	bh=STDg1waBrRNohiPSaYb2XBL0YWCJIexmKIYndXyNwNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P/nLZEntvHVQsdpXKE3TEeyf/fkGjsXQZm0H2nphuZwexWLnahcfqT6pooy9S4ImDDJ1HeZWh3xsGaXvL8idiCe/qnxoZ+LoBqFqHX7GQmzdTtZgg58OeH4kvez3mC6OPvwwijWVwzmCGsKrnM0n/9W37i8HbdZAjqbEd7oi/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZUK6fpL; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZUK6fpL"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8484f229529so240748b3a.2
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783519338; x=1784124138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2J4SN38smOsOUKFi4i/1T1z+ctF4ovRd3NG/i8t9lk4=;
        b=ZZUK6fpLzE4O9aerBn92kJZUdd4tq4b4Gm3qg3fp3MgcgQvzgjjQyAKzMf0lhR4oDJ
         n52V3FPXdJKHoN/usuwY+9gcGicc7gB4YojXouT/jSkvBfv+DCovpvGCD5qcrg1ZJXlj
         V3szpG5/eOml5iVe7FyNbTsSorTi66ESrXBSXL28ZxyLbpB4INb3chTieXXLqltpfTE6
         Ko0l3zkY4vl4J17k4bZItjJcNr2oeH8rsX0gxsvShODbWArRZ4tyR7nr5IGGTbr3kqHf
         jxoF1oF/8u32mbxikaIHo/jfvvE5hFTbqv51BNunxg3JUBIeHbXgMy/rsjv+yKbd6PNp
         RX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783519338; x=1784124138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2J4SN38smOsOUKFi4i/1T1z+ctF4ovRd3NG/i8t9lk4=;
        b=kXKauusu0V6eKyPzNuol+XxWJeu0A6Gq1JlCKNDWtATmnMBnYjQWjM3wH0DHGeXfXa
         q5W6G14dm9bRqx0nGK8KmYUdtdO9BqQfj/gVEHzEXQ6Z8sV8WFKbdGsg20rXCnSQ+kl1
         1AfFodY1cVXHcNiUit54kZ/AYS+qhwAd2p7GM08Ex7BGWmoKGv0b85bbXsg0SnI2y+XX
         nMQNKmgC8E3HHZ4q56JzUJqkdsPYQJmEKAdg0uvfrbZXlMiwvUob2khdWhp4fUH1wuZT
         AT1xWdbGSUDOL7pQTBDWnGRp75GBLHDAUbTxb14+6gwRQp/1+DLpliES6KMYt4cafdKP
         +tdw==
X-Forwarded-Encrypted: i=1; AHgh+Rofcivuc11mbjQLNUkqA/dxSlD5VnPcvqMzBOfEAOQUPICtwmyqMqQPKJK72ulHDuVfEhhUcDPCzoNHKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7cUXHvZDsEIAvB7jCPQIIBMqoh03hnb7GlKdBws9jfqv7YIBU
	LoYPfbUTNhi50H+sqJEeezczVokjRPl+YcOUSTz1KRYQHxCkPkq16j/8
X-Gm-Gg: AfdE7ckv1BJrQeV1BYou3W9sjNfKQYdKNRTKxQz8snzsifPIjgnLg5tngwIK4yN3Ssc
	2Wb8ErC98AHRabFNIdCEv0OafFq8tdnAq12kgHfa80xvgeaqAoH0ZBgUVtWeqX7CTC1MxmqYpA8
	Q/VbYejM/v9YIXXUmQtGfujFcufygAXZmB4BgOxvefcee84b6ewwYcjv5Pgy1KAnRMQKNGNl/9B
	P/DoP3RG4VVvU/UX2/IRo5LmLrB5MzfoG/T3f1AgK1pJdbejDKd4XWPGAnxhXWkiDKtMuboVKWD
	e6f9mer7D4AuUO75KPl9ZQFhhxNS2cmKSEeW2vAL54pfaMQ2oFgmSvNe0yiBd+snOLMOTDncYhx
	lHmSD+9GP3uhJ2jDoaFJTaQhFE1dJ
X-Received: by 2002:a05:6a00:2ea4:b0:847:9188:e497 with SMTP id d2e1a72fcca58-84842eb4227mr2843829b3a.13.1783519337529;
        Wed, 08 Jul 2026 07:02:17 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3162d3csm2430424a12.18.2026.07.08.07.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:02:14 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sanjay Govind <sanjay.govind9@gmail.com>,
	Vicki Pfau <vi@endrift.com>,
	Kees Cook <kees@kernel.org>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Dmitriy Zharov <contact@zharov.dev>,
	Qbeliw Tanaka <q.tanaka@gmx.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Ted Mielczarek <ted@mielczarek.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: xpad - ignore short Xbox One packets
Date: Wed,  8 Jul 2026 21:59:39 +0800
Message-ID: <20260708135939.774433-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xpadone_process_packet() parses Xbox One reports from fixed offsets in
the interrupt transfer buffer.

A malformed device can complete an interrupt transfer with a short
actual_length. The transfer buffer is reused across URBs, so bytes beyond
actual_length can still contain data left by a previous, longer transfer.
Without checking the received length, the parser can report stale button,
axis or paddle state as if it belonged to the new packet.

A previous fix added bounds checking for the len-relative Share button
access. Add length checks for the fixed-offset Xbox One packet fields as
well, and skip optional extended fields when the corresponding bytes are
not present.

Fixes: 1a48ff81b391 ("Input: xpad - add support for Xbox One controllers")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/input/joystick/xpad.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index feb8f368f834..649f59b3a162 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1035,8 +1035,14 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	struct input_dev *dev = xpad->dev;
 	bool do_sync = false;
 
+	if (!len)
+		return;
+
 	/* the xbox button has its own special report */
 	if (data[0] == GIP_CMD_VIRTUAL_KEY) {
+		if (len < 3)
+			return;
+
 		/*
 		 * The Xbox One S controller requires these reports to be
 		 * acked otherwise it continues sending them forever and
@@ -1044,6 +1050,8 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		 */
 		if (data[1] == (GIP_OPT_ACK | GIP_OPT_INTERNAL))
 			xpadone_ack_mode_report(xpad, data[2]);
+		if (len < 5)
+			return;
 
 		input_report_key(dev, BTN_MODE, data[4] & GENMASK(1, 0));
 		input_sync(dev);
@@ -1052,6 +1060,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 	} else if (data[0] == GIP_CMD_FIRMWARE) {
 		/* Some packet formats force us to use this separate to poll paddle inputs */
 		if (xpad->packet_type == PKT_XBE2_FW_5_11) {
+			if (len < 20)
+				return;
+
 			/* Mute paddles if controller is in a custom profile slot
 			 * Checked by looking at the active profile slot to
 			 * verify it's the default slot
@@ -1079,6 +1090,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 					 error);
 		}
 	} else if (data[0] == GIP_CMD_INPUT) { /* The main valid packet type for inputs */
+		if (len < 18)
+			return;
+
 		/* menu/view buttons */
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
@@ -1145,13 +1159,16 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		}
 
 		/* Profile button has a value of 0-3, so it is reported as an axis */
-		if (xpad->mapping & MAP_PROFILE_BUTTON)
+		if ((xpad->mapping & MAP_PROFILE_BUTTON) && len > 34)
 			input_report_abs(dev, ABS_PROFILE, data[34]);
 
 		/* paddle handling */
 		/* based on SDL's SDL_hidapi_xboxone.c */
 		if (xpad->mapping & MAP_PADDLES) {
 			if (xpad->packet_type == PKT_XBE1) {
+				if (len < 33)
+					goto no_paddles;
+
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1165,6 +1182,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[32] & BIT(0));
 				input_report_key(dev, BTN_GRIPL2, data[32] & BIT(2));
 			} else if (xpad->packet_type == PKT_XBE2_FW_OLD) {
+				if (len < 20)
+					goto no_paddles;
+
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1178,6 +1198,9 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL, data[18] & BIT(2));
 				input_report_key(dev, BTN_GRIPL2, data[18] & BIT(3));
 			} else if (xpad->packet_type == PKT_XBE2_FW_5_EARLY) {
+				if (len < 24)
+					goto no_paddles;
+
 				/* Mute paddles if controller has a custom mapping applied.
 				 * Checked by comparing the current mapping
 				 * config against the factory mapping config
@@ -1194,7 +1217,7 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 				input_report_key(dev, BTN_GRIPL2, data[22] & BIT(3));
 			}
 		}
-
+no_paddles:
 		do_sync = true;
 	}
 
-- 
2.43.0

