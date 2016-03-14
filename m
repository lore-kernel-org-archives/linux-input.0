From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: [PATCH] USB: input: powermate: fix oops with malicious USB descriptors
Date: Mon, 14 Mar 2016 10:12:53 -0400
Message-ID: <1457964773-29512-1-git-send-email-jwboyer@fedoraproject.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

The powermate driver expects at least one valid USB endpoint in its
probe function.  If given malicious descriptors that specify 0 for
the number of endpoints, it will crash.  Validate the number of
endpoints on the interface before using them.

The full report for this issue can be found here:
http://seclists.org/bugtraq/2016/Mar/85

Reported-by: Ralf Spenneberg <ralf@spenneberg.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
---
 drivers/input/misc/powermate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index 63b539d3daba..84909a12ff36 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -307,6 +307,9 @@ static int powermate_probe(struct usb_interface *intf, const struct usb_device_i
 	int error = -ENOMEM;
 
 	interface = intf->cur_altsetting;
+	if (interface->desc.bNumEndpoints < 1)
+		return -EINVAL;
+
 	endpoint = &interface->endpoint[0].desc;
 	if (!usb_endpoint_is_int_in(endpoint))
 		return -EIO;
-- 
2.5.0
