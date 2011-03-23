From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH] HID: roccat: Add support for wireless variant of Pyra
Date: Wed, 23 Mar 2011 18:11:36 +0100
Message-ID: <1300900296.2328.7.camel@neuromancer>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:33349 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281Ab1CWRLl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2011 13:11:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Wireless variant of Roccat Pyra finally has been tested with
existing driver.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-core.c        |    1 +
 drivers/hid/hid-roccat-pyra.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c3d6626..84a0ca2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1446,6 +1446,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KONEPLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_KOVAPLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_PYRA_WIRED) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT, USB_DEVICE_ID_ROCCAT_PYRA_WIRELESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
diff --git a/drivers/hid/hid-roccat-pyra.c b/drivers/hid/hid-roccat-pyra.c
index 160f481..38280c0 100644
--- a/drivers/hid/hid-roccat-pyra.c
+++ b/drivers/hid/hid-roccat-pyra.c
@@ -652,7 +652,8 @@ static int pyra_raw_event(struct hid_device *hdev, struct hid_report *report,
 static const struct hid_device_id pyra_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT,
 			USB_DEVICE_ID_ROCCAT_PYRA_WIRED) },
-	/* TODO add USB_DEVICE_ID_ROCCAT_PYRA_WIRELESS after testing */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ROCCAT,
+			USB_DEVICE_ID_ROCCAT_PYRA_WIRELESS) },
 	{ }
 };
 
-- 
1.7.3.4



