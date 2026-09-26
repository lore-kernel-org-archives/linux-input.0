Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D55B3803CC
	for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439955; cv=none; b=l/91z2kTzktOpyncsKxCzHykCQ7MQWyRC4tXB3oLQEKB9C6RF1FzxuJIOY7l27h1Mla7g8PLiaB5PERqp1PhNv74X6nHASZESHAUIs810z8SLNMAHKnQ7uTie4R+KS6dyo/e9apRcHeT0PbW5Hqa5/RXCpFj+xBzuUp2B9rEvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439955; c=relaxed/simple;
	bh=hC+N0t/XXQablxn2mLCeSBru4fY1Cub75WKCNTcFHh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZmlXS662PVzu/NKp21YW6pQly2SFdziaXyhqV6CqmFktmgHRSfYmmhXAtOid7vPPJ47f6tIEdXhkKgDjKV9ArnNDH//2euPJeRrnhF2FMDHkLEti/f74LBeVM16Hag/Abks27DDAyfuW9+L5jZEGzaYEG3ntkVY/74RUyt7Ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o7mDHNiT; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7mDHNiT"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9142e0b0668so20901686d6.2
        for <linux-input@vger.kernel.org>; Sat, 26 Sep 2026 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439947; x=1791044747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4rLTBzwJjcIecEwlLTNrxTAIRsESkfK6hjnt+Yx1lKg=;
        b=o7mDHNiT3pKlRq0fPn1Vx0Z8mqqFmdv62myhAdgDywoc5Q+SDwPrpIgbvA+2cnJdSZ
         EADAffpOcbxXggD6P5mJif2ld9tpGDczp6YcHKWPyaJZPaOwbOFAXPFzPvMs6TbTGqND
         g253p4VC7s0wqupomH4r439OW50kxxDB3X4I6pg7G3R2vsVK9omqlOizdA3u7trYozNZ
         ShdHy20eKFpVi88BO8oU8D6l+tO9JrKsDVH9mBjbUzLgDBlT55y3Gvzf+33KAJdZya3G
         7M64MZ1G7vippjnG0s0nIvsZ+nmFZsSMOK/qPhgvxKz80T5Lx7wsVzodAfoHYjukikKj
         Gyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439947; x=1791044747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4rLTBzwJjcIecEwlLTNrxTAIRsESkfK6hjnt+Yx1lKg=;
        b=RWyuaMyYL/ijdUBBWYSTzPCUcF7lHqJVFy46sBPVDfoDGX8C0pERLMsnq6I3UJHfjf
         MnWNfYKsGBrJF2dy7hU4K2Ones6pl4Us4/UusEC0528oexQ6rZif6M35okZJYfqQZXqc
         Np5/RdihWIRYzeQCHaclHfTWTut+kgt79b0J30p0qHNNGYpt9/LjAJULRpbQOhXn8Poi
         yxRaM9mhoizZjnTuTuW4e4On7yAr5X2emIiM1ZNb+CsibADCFSeAugqID0y1waHuj7S2
         ur0xMqUD3M39T8Lu8n/mQJmmTNgMKT3jRKTU1TCGunmR4iQtl0k69avQxU3bLPR6TPAt
         Jizg==
X-Gm-Message-State: AFuF++nP+E4buz4bYSrcWqG/rtcUVvp/pbToaZbyz4M+xxqYUM8tj+c/
	qF5BMaRcHLcGcaZCHyeTkvvJXg/urMBnOr0dSAd0VRtBKf6wItv9CFmU
X-Gm-Gg: AYBFou2YaANfKWpMJLHkuh6mtjtNsD8IUueepB93uCbrAfOX/Mm0BqrOAGrEsL8JhBt
	WIQuxRT2fINVYFyJCLw4r1eq+OxEVqc5Ugtc98H+HvaJ4itE/quQtU9m62NQBoLCjh9MhZs8jB6
	DpUXPvjPbFRiN2Tf8WCl0im2J159MEsFNIsOXB/sDm9Gdy+49mUlWzzNDfc15LNoVKyu3IJ+2AT
	vrDwEmretOk+2AjJt09BBk18LhbOPFLQABRok6YKKvfQ8PqviVKWHiDJ+nw3f9RbaWyQshJmEyT
	sUvQrSMTyl+b2OAD4564bxkMX3SRFyARGEfH81NnHLTI2xsHx8aSjbjP/OBvvNTdgnahqtz7ps1
	CNoEsE+diX3BPBuJpDnRJF1OU6n8fnpnBkRHGRTHc0b/Ncjzxgreryx/S0HcOoO443/fwpwQZWY
	8NIr/aUfxmCUsrIFJ6pA/vwzW0Q7w7igCEYmRq7bCYNmwMAvIcRRAb9F7Y0ACWBxTpMQnsf1i7i
	Y7INqou5ND7EaQenNY/RhGiy3YYPhsSuWgl9XVmspG1k+n/
X-Received: by 2002:a05:622a:15c4:b0:530:178a:9dd8 with SMTP id d75a77b69052e-5330b556ae7mr110702981cf.8.1790439947407;
        Sat, 26 Sep 2026 09:25:47 -0700 (PDT)
Received: from zaina.localdomain ([172.56.198.134])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533222585a1sm20936831cf.11.2026.09.26.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:25:47 -0700 (PDT)
From: Zain Aboobacker <zainaboobacker33@gmail.com>
To: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: fix typos in comments
Date: Sat, 26 Sep 2026 12:25:43 -0400
Message-ID: <20260926162544.25462-1-zainaboobacker33@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various spelling mistakes in comments found by codespell.

Assisted-by: Claude:claude-opus-5-5 codespell
Signed-off-by: Zain Aboobacker <zainaboobacker33@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9646380febac..f4bf4a39fcd9 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -108,9 +108,9 @@ MODULE_PARM_DESC(disable_tap_to_click,
  *
  * Most older devices (including the Unifying usb receiver) use the RAP protocol
  * where as most newer devices use the FAP protocol. Both protocols are
- * compatible with the underlying transport, which could be usb, Unifiying, or
+ * compatible with the underlying transport, which could be usb, Unifying, or
  * bluetooth. The message lengths are defined by the hid vendor specific report
- * descriptor for the HIDPP_SHORT report type (total message lenth 7 bytes) and
+ * descriptor for the HIDPP_SHORT report type (total message length 7 bytes) and
  * the HIDPP_LONG report type (total message length 20 bytes)
  *
  * The RAP protocol uses both report types, whereas the FAP only uses HIDPP_LONG
@@ -120,7 +120,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
  * Unifying device.
  *
  * The paired device can be RAP or FAP, it will receive the message untouched
- * from the Unifiying receiver.
+ * from the Unifying receiver.
  */
 
 struct fap {
@@ -1656,7 +1656,7 @@ static int hidpp20_unifiedbattery_map_status(struct hidpp_device *hidpp,
 static int hidpp20_unifiedbattery_map_level(struct hidpp_device *hidpp,
 					    u8 battery_level)
 {
-	/* cler unsupported level bits */
+	/* clear unsupported level bits */
 	battery_level &= hidpp->battery.supported_levels_1004;
 
 	if (battery_level & FLAG_UNIFIED_BATTERY_LEVEL_FULL)
@@ -3353,7 +3353,7 @@ static int m560_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 /*
  * The Logitech K400 keyboard has an embedded touchpad which is seen
  * as a mouse from the OS point of view. There is a hardware shortcut to disable
- * tap-to-click but the setting is not remembered accross reset, annoying some
+ * tap-to-click but the setting is not remembered across reset, annoying some
  * users.
  *
  * We can toggle this feature from the host by using the feature 0x6010:
-- 
2.53.0

