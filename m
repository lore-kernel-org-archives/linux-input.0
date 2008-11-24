From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 3/4] HID: usbhid, use usb_endpoint_xfer_int
Date: Mon, 24 Nov 2008 16:20:08 +0100
Message-ID: <1227540009-14209-3-git-send-email-jirislaby@gmail.com>
References: <1227540009-14209-1-git-send-email-jirislaby@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.wellnetcz.com ([212.24.148.102]:46418 "EHLO
	smtp.wellnetcz.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbYKXPUN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2008 10:20:13 -0500
In-Reply-To: <1227540009-14209-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

Use usb_endpoint_xfer_int() instead of direct use of constants.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/hid/usbhid/hid-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 30f3add..f0a0f72 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -807,7 +807,7 @@ static int usbhid_start(struct hid_device *hid)
 		int interval;
 
 		endpoint = &interface->endpoint[n].desc;
-		if ((endpoint->bmAttributes & 3) != 3)		/* Not an interrupt endpoint */
+		if (!usb_endpoint_xfer_int(endpoint))
 			continue;
 
 		interval = endpoint->bInterval;
-- 
1.6.0.4

