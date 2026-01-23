Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCB6320393
	for <linux-input@vger.kernel.org>; Fri, 23 Jan 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158646; cv=none; b=ENBuEMwnuXNpFM/3Fong0cLidTd7lC4uRHsLKSL7CYoQgq9Uyez7OeV8Mdh5thlcPifcWeH4/ONccbqDTBg56QjrWZHDBWlWYoXtvkPNg18kZgS7QnElOCD2u8P26CEOiXOUETaV4gkByprBu2ZafhLv3H7JtRey8LGj4Vs18+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158646; c=relaxed/simple;
	bh=5ej8XA7goCxkIQtBmxih/taufMH0curkX1X167AbFJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ToIqHpNC1VAQzymUQ3O+4R+l1wWyv9IY0GQdxS0uSdMqBCq9xuXNGOfw7Wdg0ugfW7C8QKds8lUEI9aI1fj9cLnSS0ZYQwxoY+LykYepCFgiyIEv6JbdmvRME+WNa5UV7srlEJ6Hl150ni0OCqb8+XXB/6nygzPkYPwTF1Jof9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.tretter@pengutronix.de>)
	id 1vjCyn-0008Ap-KS; Fri, 23 Jan 2026 09:57:21 +0100
From: Michael Tretter <m.tretter@pengutronix.de>
Date: Fri, 23 Jan 2026 09:57:05 +0100
Subject: [PATCH] HID: multitouch: add eGalaxTouch EXC3188 support
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-egalax-exc3188-v1-1-3f62d06d554d@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAOA3c2kC/x3MTQqAIBBA4avIrBP8CZOuEi3ERhsIC4UQxLsnL
 b/Few0KZsICK2uQ8aVCdxqQEwN/uhSR0zEMSigjpNIco7tc5Vi9ltZyoZ3QuBgbZgUjejIGqv9
 w23v/AGoFF+BgAAAA
X-Change-ID: 20260123-egalax-exc3188-03a03e768f42
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, 
 Thorsten Schmelzer <tschmelzer@topcon.com>, 
 Michael Tretter <m.tretter@pengutronix.de>
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: m.tretter@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org

From: Thorsten Schmelzer <tschmelzer@topcon.com>

Add support for the for the EXC3188 touchscreen from eGalaxy.

Signed-off-by: Thorsten Schmelzer <tschmelzer@topcon.com>
Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/hid/hid-ids.h        | 1 +
 drivers/hid/hid-multitouch.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 9c2bf584d9f6..7dc3fe079491 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -437,6 +437,7 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7349	0x7349
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_73F7	0x73f7
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
+#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000	0xc000
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002	0xc002
 
 #define USB_VENDOR_ID_EDIFIER		0x2d99
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b1c3ef129058..ea2a41d706de 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2146,6 +2146,9 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) },
+	{ .driver_data = MT_CLS_EGALAX_SERIAL,
+		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
+			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C000) },
 	{ .driver_data = MT_CLS_EGALAX,
 		MT_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_C002) },

---
base-commit: c072629f05d7bca1148ab17690d7922a31423984
change-id: 20260123-egalax-exc3188-03a03e768f42

Best regards,
-- 
Michael Tretter <m.tretter@pengutronix.de>

