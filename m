From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH] HID: alps: match alps devices in core
Date: Mon, 20 Jun 2016 13:07:05 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606201305380.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59687 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbcFTLH6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 07:07:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

All devices with ALPS_JP VID are handled by hid-alps driver, hence they 
require an entry in hid_have_special_driver[].

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

Queued in hid.git#for-4.8/alps

 drivers/hid/hid-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ea3a26..3cdbc4b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1772,6 +1772,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP, HID_ANY_ID) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD) },
-- 
Jiri Kosina
SUSE Labs

