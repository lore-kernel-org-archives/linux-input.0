Return-Path: <SRS0=GsZw=3Y=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5DEC3524B
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE8C2166E
	for <linux-input@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBDNSX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:18:23 -0500
Received: from mta-out1.inet.fi ([62.71.2.226]:32772 "EHLO johanna1.inet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgBDNSW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 4 Feb 2020 08:18:22 -0500
Received: from MinistryOfSillyWalk.home (84.248.30.195) by johanna1.inet.fi (9.0.019.26-1)
        id 5E1C39AA16035298; Tue, 4 Feb 2020 15:18:11 +0200
From:   Lauri Jakku <lja@iki.fi>
To:     oneukum@suse.com, benjamin.tissoires@redhat.com
Cc:     jikos@kernel.org, linux-input@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Lauri Jakku <lja@iki.fi>
Subject: [PATCH v3] USB: HID: random timeout failures tackle try.
Date:   Tue,  4 Feb 2020 15:15:56 +0200
Message-Id: <20200204131555.25534-1-lja@iki.fi>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

There is multiple reports of random behaviour of USB HID devices.

I have mouse that acts sometimes quite randomly, I debugged with
logs others have published: that there is HW timeouts that leave
device in state that it is errorneus.

To fix this, I introduce retry mechanism in root of USB HID drivers.

Fix does not slow down operations at all if there is no -ETIMEDOUT
got from control message sending.

If there is one, then sleep 20ms and try again. Retry count is 20
witch translates maximium of 400ms before giving up. If the 400ms
boundary is reached the HW is really bad.

JUST to be clear:
    This does not make USB HID devices to sleep anymore than
    before, if all is golden and no timeouts are got.

Why modify usb-hid-core: No need to modify driver by driver.
At this time i do not know all the USB HID devices that timeouts,
but what i've researched, there are issues.

Timeout given is divided by 100, but taken care that it is always
at least 10ms.

so total time in common worst-case-scenario is:

 sleep of 20ms + common timeout divided by 100 (50ms) makes
 70ms per loop, 20 loops => 1.4sec .

Signed-off-by: Lauri Jakku <lja@iki.fi>
---
 drivers/usb/core/message.c | 55 ++++++++++++++++++++++++++++++++++----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 5adf489428aa..614c762989ab 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -20,6 +20,7 @@
 #include <linux/usb/hcd.h>	/* for usbcore internals */
 #include <linux/usb/of.h>
 #include <asm/byteorder.h>
+#include <linux/errno.h>
 
 #include "usb.h"
 
@@ -137,7 +138,10 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 		    __u16 size, int timeout)
 {
 	struct usb_ctrlrequest *dr;
-	int ret;
+	int ret = -ETIMEDOUT;
+
+	/* retry_cnt * 20ms, max retry time set to 400ms */
+	int retry_cnt = 20;
 
 	dr = kmalloc(sizeof(struct usb_ctrlrequest), GFP_NOIO);
 	if (!dr)
@@ -149,11 +153,52 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 	dr->wIndex = cpu_to_le16(index);
 	dr->wLength = cpu_to_le16(size);
 
-	ret = usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
+	do {
+		ret = usb_internal_control_msg(dev,
+					pipe,
+					dr,
+					data,
+					size,
+					timeout);
+
+		/*
+		 * Linger a bit, prior to the next control message
+		 * or if return value is timeout, but do try few
+		 * times (max 400ms) before quitting. Adapt timeout
+		 * to be smaller when we have timeout'd first time.
+		 */
+		if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+			msleep(200);
+		else if (ret == -ETIMEDOUT) {
+			static timeout_happened = 0;
+
+			if ( ! timeout_happened ) {
+				timeout_happened = 1;
+
+				/* 
+				 * If timeout is given, divide it
+				 * by 100, if not, put 10ms timeout.
+				 * 
+				 * Then safeguard: if timeout is under
+				 * 10ms, make timeout to be 10ms.
+				 */
+
+				if (timeout > 0)
+					timeout /= 100;
+				else
+					timeout = 10;
+
+				if (timeout < 10)
+					timeout = 10;
+
+			}
+
+			msleep(20);
+		}
+
+		/* Loop while timeout, max loops: retry_cnt times. */
+	} while ((retry_cnt-- > 0) && (ret == -ETIMEDOUT));
 
-	/* Linger a bit, prior to the next control message. */
-	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
-		msleep(200);
 
 	kfree(dr);
 
-- 
2.25.0

