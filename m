From: Yann Cantin <yann.cantin@laposte.net>
Subject: [RFC ebeam PATCH 1/3] hid: hid-ids.h: Add vendor and device ID for eBeam classic device.
Date: Sat, 28 Jul 2012 02:02:32 +0200
Message-ID: <1343433754-3887-2-git-send-email-yann.cantin@laposte.net>
References: <1343433754-3887-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1343433754-3887-1-git-send-email-yann.cantin@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, Yann Cantin <yann.cantin@laposte.net>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
---
 drivers/hid/hid-ids.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 41c34f2..8cd4b8e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -271,6 +271,9 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7349	0x7349
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
 
+#define USB_VENDOR_ID_EFI		0x2650
+#define USB_DEVICE_ID_EFI_CLASSIC	0x1311
+
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 
-- 
1.7.10
