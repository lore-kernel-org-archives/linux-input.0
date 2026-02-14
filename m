Received: from smtp6.goneo.de (smtp6.goneo.de [85.220.129.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D91E1C11;
	Sat, 14 Feb 2026 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.129.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771098221; cv=none; b=S1qkVYIFPRRn3pnxtifbKTvIc79oChWIFYC6sbU2ZE0HFb/V48RjBXuCkO4iZtjggMcdiI2KKZksWJpaMgk7M6tyKB493cL1qCK/Ad6ThRf6+bOObBVSRkVOURd+t0E7z/SZSC2eTVdFIVZFgnWEx2HbZ1PZhxlCAbSnFQEuCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771098221; c=relaxed/simple;
	bh=5XZJJ24TTHJ/yY6GgcWKEyTEg3W943mFaQGxpwK8t+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IwbeupOJwRXGEuoswsdsKnB/O0U4d7Vq0IgjGtxeypJ9zi8rY8VtLmYiv3Acf3dPWNfC3IPypBL0d+2Tt8055GSlr0Qx0lBAF90b1pWgM2PaBmiUUL2WwNCi8uBI6KO9fhaQRqYyIvWzpchfGbyd4DYRyfZJyRIcLdgXGEE4VLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devpi.de; spf=pass smtp.mailfrom=devpi.de; dkim=pass (2048-bit key) header.d=devpi.de header.i=@devpi.de header.b=Nkg9cd+s; arc=none smtp.client-ip=85.220.129.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devpi.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devpi.de header.i=@devpi.de header.b="Nkg9cd+s"
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by smtp6.goneo.de (Postfix) with ESMTPS id B50982406E9;
	Sat, 14 Feb 2026 20:37:25 +0100 (CET)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id 7B5492402A5;
	Sat, 14 Feb 2026 20:37:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
	t=1771097845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oadswahTH2GiLinE612d32ldQGE9gXB2tnBIzr4w2q8=;
	b=Nkg9cd+sU14NH4xaNamV5zXEU2PEuZ/vf9mHcuZHgotnELhiaz1rkoh3MZtGhO7Camlebo
	4bSTCl2+8DRgWVUppNO9zl2NOclomUNsBZ1eDALLrQD1oNu4J77HAkeoIi40i1TyZWFWhj
	nwadR7OjBjtIN3Sj/TtuJq+se+jADxfasO/xXvsBRUOwCHJj/a7swAatFE6L+wQYq4K5eR
	xQ5OKNVSVL3Iqk0Bn6W6zcOTdYFjkChwCO0kvthWGopgmD6NWGXYoqiyHmS8yhackKQxIa
	AUauB+TjXU7AbeIuQJnJX7oXXzE88Jh/dTimEs05yg9knv4dLXUKJi4e8OK+Dw==
Received: from [192.168.1.213] (unknown [IPv6:2001:9e8:7357:6d10:5bd7:eb91:589c:c228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id 45F3524029D;
	Sat, 14 Feb 2026 20:37:25 +0100 (CET)
From: Julius Lehmann <lehmanju@devpi.de>
Date: Sat, 14 Feb 2026 20:34:21 +0100
Subject: [PATCH] HID: magicmouse: fix battery reporting for Apple Magic
 Trackpad 2
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-magic-trackpad-usb-battery-v1-1-353bc63b56c0@devpi.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqDMBAA0KvIrB0wqZXiVcTFJBntUPwwiaUle
 HeDy7d5GSKrcIS+yqD8lSjbWmDqCvyb1plRQjHYxnaNNS0uNIvHpOQ/OwU8okNHKbH+8UkP416
 +s6GdoAS78iS/Ox/G87wAI2iNw2wAAAA=
X-Change-ID: 20260214-magic-trackpad-usb-battery-5a31b8c62d4f
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Julius Lehmann <lehmanju@devpi.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771097845; l=1447;
 i=lehmanju@devpi.de; s=20260214; h=from:subject:message-id;
 bh=5XZJJ24TTHJ/yY6GgcWKEyTEg3W943mFaQGxpwK8t+4=;
 b=p6CMysmfa7+bdJc54d1PBuw0+8BkhrzPKo/9hkSWHJZFLdGztYeP8qvl9mmDU27qO1Z6Sru3r
 0EO4lKfC92fAnQGJ/oK0/y4R+KRU/thJTTd8raB9UH0uo3pGe/Uf8Mg
X-Developer-Key: i=lehmanju@devpi.de; a=ed25519;
 pk=4CVTeomaDx/FDbI6e0vzvDz7AanVrlpEqEXEpDB3cXo=
X-Rspamd-UID: e32603
X-Rspamd-UID: 1e80bb

Battery reporting does not work for the Apple Magic Trackpad 2 if it is
connected via USB. The current hid descriptor fixup code checks for a
hid descriptor length of exactly 83 bytes. If the hid descriptor is
larger, which is the case for newer apple mice, the fixup is not
applied.

This fix checks for hid descriptor sizes greater/equal 83 bytes which
applies the fixup for newer devices as well.

---
Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
---
 drivers/hid/hid-magicmouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 7d4a25c6de0eb7d36ad26a867004d58a1b6eae71..3fe191615a6d39fbe823e9e1a80fc65a7a12b9c4 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -985,7 +985,7 @@ static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	 */
 	if ((is_usb_magicmouse2(hdev->vendor, hdev->product) ||
 	     is_usb_magictrackpad2(hdev->vendor, hdev->product)) &&
-	    *rsize == 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
+	    *rsize >= 83 && rdesc[46] == 0x84 && rdesc[58] == 0x85) {
 		hid_info(hdev,
 			 "fixing up magicmouse battery report descriptor\n");
 		*rsize = *rsize - 1;

---
base-commit: d3eeb99bbc99cc5eb94a4a75ed4415a0272254ef
change-id: 20260214-magic-trackpad-usb-battery-5a31b8c62d4f

Best regards,
-- 
Julius Lehmann <lehmanju@devpi.de>

