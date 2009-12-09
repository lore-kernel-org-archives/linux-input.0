From: =?utf-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH] HID: blacklist ET&T TC5UH touchscreen controller
Date: Wed,  9 Dec 2009 22:09:53 +0100
Message-ID: <1260392993-8619-1-git-send-email-ynezz@true.cz>
References: <20091130081011.GB10295@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:60475 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZLIVJt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Dec 2009 16:09:49 -0500
In-Reply-To: <20091130081011.GB10295@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@novell.com>, =?utf-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>

This patch adds ET&T TC5UH touchscreen controller to HID blacklist,
because this device is handled by input/usbtouchscreen driver.

Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-ids.h  |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7d05c4b..a000bb7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1296,6 +1296,7 @@ static const struct hid_device_id hid_blacklist[]=
 =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE=
_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) =
},
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_EZKEY, USB_DEVICE_ID_BTC_8193) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PS=
X_ADAPTOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GAMERON, USB_DEVICE_ID_GAMERON_DUAL_PC=
S_ADAPTOR) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index adbef5d..3e76bd9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -164,6 +164,9 @@
 #define USB_VENDOR_ID_ESSENTIAL_REALITY	0x0d7f
 #define USB_DEVICE_ID_ESSENTIAL_REALITY_P5 0x0100
=20
+#define USB_VENDOR_ID_ETT		0x0664
+#define USB_DEVICE_ID_TC5UH		0x0309
+
 #define USB_VENDOR_ID_EZKEY 		0x0518
 #define USB_DEVICE_ID_BTC_8193		0x0002
=20
--=20
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
