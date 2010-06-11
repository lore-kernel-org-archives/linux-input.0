From: =?utf-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
Subject: [PATCH 2/2] HID: blacklist ET&T TC4UH touchscreen controller
Date: Fri, 11 Jun 2010 09:40:54 +0200
Message-ID: <1276242054-11127-2-git-send-email-ynezz@true.cz>
References: <20100603075720.GQ26052@ibawizard.net>
 <1276242054-11127-1-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:53038 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab0FKHtL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 03:49:11 -0400
In-Reply-To: <1276242054-11127-1-git-send-email-ynezz@true.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@novell.com>, ynezz@true.cz

Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-ids.h  |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index aa0f7dc..a35f8be 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1568,6 +1568,7 @@ static const struct hid_device_id hid_ignore_list=
[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20=
) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSEN=
TIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0001) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0002) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_GENERAL_TOUCH, 0x0003) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6af77ed..fad4cb0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -197,6 +197,7 @@
=20
 #define USB_VENDOR_ID_ETT		0x0664
 #define USB_DEVICE_ID_TC5UH		0x0309
+#define USB_DEVICE_ID_TC4UM		0x0306
=20
 #define USB_VENDOR_ID_EZKEY 		0x0518
 #define USB_DEVICE_ID_BTC_8193		0x0002
--=20
1.5.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
