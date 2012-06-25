From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4] input - wacom: BTN_TOOL_DOUBLETAP is not a valid device_type
Date: Mon, 25 Jun 2012 14:36:40 -0700
Message-ID: <1340660200-27437-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59790 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756883Ab2FYVcf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 17:32:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so7102210pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 14:32:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

It is replaced by BTN_TOOL_FINGER.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 2714ce6..726eb64 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -505,7 +505,7 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 		if (intf->cur_altsetting->desc.bInterfaceNumber == 0) {
 			features->device_type = 0;
 		} else if (intf->cur_altsetting->desc.bInterfaceNumber == 2) {
-			features->device_type = BTN_TOOL_DOUBLETAP;
+			features->device_type = BTN_TOOL_FINGER;
 			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 		}
 	}
-- 
1.7.7.6

