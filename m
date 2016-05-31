From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: multitouch: Add MT_QUIRK_NOT_SEEN_MEANS_UP to Surface Pro 3
Date: Tue, 31 May 2016 17:31:15 +0200
Message-ID: <1464708675-25273-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbcEaPbU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 11:31:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Daniel Martin <consume.noise@gmail.com>, Romain Sahut <romain.sahut@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The firmware found in the touch screen of an SP3 is buggy and may miss
to send lift off reports for contacts. Try to work around that issue by
using MT_QUIRK_NOT_SEEN_MEANS_UP.

based on a patch from: Daniel Martin <consume.noise@gmail.com>

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c741f5e..95b7d61 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1401,6 +1401,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_NOVATEK,
 			USB_DEVICE_ID_NOVATEK_PCT) },
 
+	/* Ntrig Panel */
+	{ .driver_data = MT_CLS_NSMU,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_NTRIG, 0x1b05) },
+
 	/* PixArt optical touch screen */
 	{ .driver_data = MT_CLS_INRANGE_CONTACTNUMBER,
 		MT_USB_DEVICE(USB_VENDOR_ID_PIXART,
-- 
2.5.0

