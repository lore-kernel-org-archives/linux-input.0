From: "Xing Wei" <weixing@hanwang.com.cn>
Subject: [PATCH trivial] drivers/hid: the support for Hanwang tablet
Date: Wed, 11 Aug 2010 11:48:20 +0800
Message-ID: <201008111148203123394@hanwang.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hanwang.com.cn ([221.122.51.51]:56288 "EHLO mail.hanwang.com.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab0HKDzU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Aug 2010 23:55:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

From: Xing Wei  <weixing@hanwang.com.cn>

This patch is the support for tablet of BeiJing HanwangTechnology Co, Ltd.
The main purpose is to make the device taken over by our driver.
The driver code will be submitted later.

Signed-off-by: Xing Wei <weixing@hanwang.com.cn>

---
This is our first time to submit the patch for linux.We'll really appreciate the comment and advice.

diff -uprN -X linux-2.6.35-vanilla/Documentation/dontdiff linux-2.6.35-vanilla/drivers/hid/hid-core.c devel/linux-2.6.35/drivers/hid/hid-core.c
--- linux-2.6.35-vanilla/drivers/hid/hid-core.c	2010-08-02 06:11:14.000000000 +0800
+++ devel/linux-2.6.35/drivers/hid/hid-core.c	2010-08-11 18:20:13.832088816 +0800
@@ -1759,6 +1759,11 @@ static bool hid_ignore(struct hid_device
 		    hdev->product <= USB_DEVICE_ID_SOUNDGRAPH_IMON_LAST)
 			return true;
 		break;
+	case USB_VENDOR_ID_HANWANG:
+		if (hdev->product >= USB_DEVICE_ID_HANWANG_TABLET_FIRST &&
+		    hdev->product <= USB_DEVICE_ID_HANWANG_TABLET_LAST)
+			return true;
+		break;
 	}
 
 	if (hdev->type == HID_TYPE_USBMOUSE &&
diff -uprN -X linux-2.6.35-vanilla/Documentation/dontdiff linux-2.6.35-vanilla/drivers/hid/hid-ids.h devel/linux-2.6.35/drivers/hid/hid-ids.h
--- linux-2.6.35-vanilla/drivers/hid/hid-ids.h	2010-08-02 06:11:14.000000000 +0800
+++ devel/linux-2.6.35/drivers/hid/hid-ids.h	2010-08-11 18:17:32.967089161 +0800
@@ -526,5 +526,8 @@
 #define USB_DEVICE_ID_KYE_ERGO_525V	0x0087
 #define USB_DEVICE_ID_KYE_GPEN_560	0x5003
 
+#define USB_VENDOR_ID_HANWANG		0x0b57
+#define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
+#define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 
 #endif

