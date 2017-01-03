From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 2/3] HID: rmi: Handle all Synaptics touchpads using hid-rmi
Date: Tue,  3 Jan 2017 16:16:02 +0100
Message-ID: <20170103151603.26844-3-benjamin.tissoires@redhat.com>
References: <20170103151603.26844-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170103151603.26844-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

With the addition of HID and F12 support in the synaptics-rmi4 driver
touchpads which had been using the hid-multitouch driver can now
be support by the synaptics-rmi4 via hid-rmi. The advantage is that
additional data can be reported from the RMI registers which is not
available in the Microsoft Precision Touchpad collection.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

no changes in v2
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index db87d91..7e8b99e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -825,7 +825,8 @@ static int hid_scan_report(struct hid_device *hid)
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
2.9.3
