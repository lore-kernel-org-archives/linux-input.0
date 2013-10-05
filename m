From: Dinesh Ram <dinesh.ram@cern.ch>
Subject: [Review PATCH 5/7] si4713 : HID blacklist Si4713 USB development board
Date: Sat, 5 Oct 2013 22:58:20 +0200
Message-ID: <0d3a992b1b8f3bc49da5696ab6f92266c2f5b86b.1381006700.git.dinesh.ram@cern.ch>
References: <89ec888fdb63c693bd8cea96ae5ad008391e866b.1381006700.git.dinesh.ram@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cernmx30.cern.ch ([137.138.144.177]:32957 "EHLO
	CERNMX30.cern.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab3JEVEE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Oct 2013 17:04:04 -0400
In-Reply-To: <89ec888fdb63c693bd8cea96ae5ad008391e866b.1381006700.git.dinesh.ram@cern.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dinesh.superman2006@gmail.com
Cc: Dinesh Ram <dinram@cisco.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

From: Dinesh Ram <dinram@cisco.com>

The Si4713 development board contains a Si4713 FM transmitter chip
and is handled by the radio-usb-si4713 driver.
The board reports itself as (10c4:8244) Cygnal Integrated Products, Inc.
and misidentifies itself as a HID device in its USB interface descriptor.
This patch ignores this device as an HID device and hence loads the custom driver.

Signed-off-by: Dinesh Ram <dinram@cisco.com>

Cc: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-ids.h  |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b8470b1..81b9b44 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2106,6 +2106,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CIDC, 0x0103) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI470X) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_RADIO_SI4713) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_ULTRAMOUSE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e60e8d5..1cdd34a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -241,6 +241,8 @@
 #define USB_VENDOR_ID_CYGNAL		0x10c4
 #define USB_DEVICE_ID_CYGNAL_RADIO_SI470X	0x818a
 
+#define USB_DEVICE_ID_CYGNAL_RADIO_SI4713       0x8244
+
 #define USB_VENDOR_ID_CYPRESS		0x04b4
 #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
 #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
-- 
1.7.9.5

