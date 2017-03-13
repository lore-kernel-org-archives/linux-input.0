From: Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/7] Input: iforce - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:33 +0100
Message-ID: <20170313123539.28103-2-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36239 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752601AbdCMMgi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 08:36:38 -0400
In-Reply-To: <20170313123539.28103-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer or accessing memory that lie beyond the end of the endpoint
array should a malicious device lack the expected endpoints.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/input/joystick/iforce/iforce-usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d96aa27dfcdc..db64adfbe1af 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -141,6 +141,9 @@ static int iforce_usb_probe(struct usb_interface *intf,
 
 	interface = intf->cur_altsetting;
 
+	if (interface->desc.bNumEndpoints < 2)
+		return -ENODEV;
+
 	epirq = &interface->endpoint[0].desc;
 	epout = &interface->endpoint[1].desc;
 
-- 
2.12.0

