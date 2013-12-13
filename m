From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: remove SIS entries from hid_have_special_driver[]
Date: Fri, 13 Dec 2013 15:45:24 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1312131458070.12702@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41545 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155Ab3LMOp3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Dec 2013 09:45:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Emanuel Krenz <emanuelkrenz@web.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>, AceLan Kao <acelan.kao@canonical.com>, Forest Bond <forest.bond@rapidrollout.com>
Cc: linux-input@vger.kernel.org

The entries are not needed, as hid-multitouch gets bound correctly 
automatically by contact ID.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

I will be queuing for 3.14 if noone objects.

 drivers/hid/hid-core.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 48296c0..b0de258 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1822,9 +1822,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_PS1000) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_IR_REMOTE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAMSUNG, USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS9200_TOUCH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_BUZZ_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_WIRELESS_BUZZ_CONTROLLER) },
-- 
Jiri Kosina
SUSE Labs
