From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - validate USB endpoint type during probe
Date: Tue, 12 Sep 2017 11:12:12 -0700
Message-ID: <20170912181212.15427-1-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38899 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdILSMO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Sep 2017 14:12:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, andreyknvl@google.com, Cameron Gutman <aicommander@gmail.com>

We should only see devices with interrupt endpoints. Ignore any other
endpoints that we find, so we don't send try to send them interrupt URBs
and trigger a WARN down in the USB stack.

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Cc: <stable@vger.kernel.org> # c01b5e7464f0 Input: xpad - don't depend on endpoint order
Cc: <stable@vger.kernel.org>
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
To be able to hit any of the LTS kernels, we'll need to also cherry pick
c01b5e7464f0 ("Input: xpad - don't depend on endpoint order"). In hindsight,
this commit also addresses a malicious USB device case, since a device could
purposefully trick us into sending URBs to an endpoint in the wrong direction.
---
 drivers/input/joystick/xpad.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8e34ef643c7..d86e59515b9c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1764,10 +1764,12 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		struct usb_endpoint_descriptor *ep =
 				&intf->cur_altsetting->endpoint[i].desc;
 
-		if (usb_endpoint_dir_in(ep))
-			ep_irq_in = ep;
-		else
-			ep_irq_out = ep;
+		if (usb_endpoint_xfer_int(ep)) {
+			if (usb_endpoint_dir_in(ep))
+				ep_irq_in = ep;
+			else
+				ep_irq_out = ep;
+		}
 	}
 
 	if (!ep_irq_in || !ep_irq_out) {
-- 
2.14.1
