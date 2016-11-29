From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 12/13] HID: rmi: Handle all Synaptics touchpads using hid-rmi
Date: Tue, 29 Nov 2016 11:08:23 +0100
Message-ID: <1480414104-8524-13-git-send-email-benjamin.tissoires@redhat.com>
References: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933431AbcK2KIy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 05:08:54 -0500
In-Reply-To: <1480414104-8524-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, Nick Dyer <nick@shmanahar.org>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

With the addition of HID and F12 support in the synaptics-rmi4 driver
touchpads which had been using the hid-multitouch driver can now
be support by the synaptics-rmi4 via hid-rmi. The advantage is that
additional data can be reported from the RMI registers which is not
available in the Microsoft Precision Touchpad collection.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b43df2d..2da75d4 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -826,7 +826,8 @@ static int hid_scan_report(struct hid_device *hid)
 		hid->group = HID_GROUP_WACOM;
 		break;
 	case USB_VENDOR_ID_SYNAPTICS:
-		if (hid->group == HID_GROUP_GENERIC)
+		if (hid->group == HID_GROUP_GENERIC ||
+		    hid->group == HID_GROUP_MULTITOUCH_WIN_8)
 			if ((parser->scan_flags & HID_SCAN_FLAG_VENDOR_SPECIFIC)
 			    && (parser->scan_flags & HID_SCAN_FLAG_GD_POINTER))
 				/*
-- 
2.7.4

