From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/7] Input: cm109 - fix NULL-deref at probe
Date: Mon, 13 Mar 2017 13:35:34 +0100
Message-ID: <20170313123539.28103-3-johan@kernel.org>
References: <20170313123539.28103-1-johan@kernel.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170313123539.28103-1-johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Alfred E . Heggestad" <aeh-VqIxOk2P1jc@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Make sure to check the number of endpoints to avoid dereferencing a
NULL-pointer should a malicious device lack endpoints.

Fixes: c04148f915e5 ("Input: add driver for USB VoIP phones with CM109
chipset")
Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>	# 2.6.28
Cc: Alfred E. Heggestad <aeh-VqIxOk2P1jc@public.gmane.org>

Signed-off-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/input/misc/cm109.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
index 9cc6d057c302..23c191a2a071 100644
--- a/drivers/input/misc/cm109.c
+++ b/drivers/input/misc/cm109.c
@@ -700,6 +700,10 @@ static int cm109_usb_probe(struct usb_interface *intf,
 	int error = -ENOMEM;
 
 	interface = intf->cur_altsetting;
+
+	if (interface->desc.bNumEndpoints < 1)
+		return -ENODEV;
+
 	endpoint = &interface->endpoint[0].desc;
 
 	if (!usb_endpoint_is_int_in(endpoint))
-- 
2.12.0

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
