From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [RFC/RFT 3/5] USB: usbtouch: Prevent possible deadlock
Date: Fri, 12 Mar 2010 15:42:53 +0100
Message-ID: <201003121542.53537.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

>From 5e4fc75d1031ca1c621c0f85cf1e903ffd8fb758 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 11 Mar 2010 15:06:51 +0100
Subject: [PATCH 3/5] USB: usbtouch: Prevent possible deadlock

For autosuspend memory in suspend/resume must be allocated with
GFP_NOIO.

Signed-off-by: Oliver Neukum <neukum-shG/GajIFYqbacvFa/9K2g@public.gmane.org>
---
 drivers/input/touchscreen/usbtouchscreen.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 8836761..f15aa2e 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -508,7 +508,7 @@ static int dmc_tsc10_init(struct usbtouch_usb *usbtouch)
 	int ret = -ENOMEM;
 	unsigned char *buf;
 
-	buf = kmalloc(2, GFP_KERNEL);
+	buf = kmalloc(2, GFP_NOIO);
 	if (!buf)
 		goto err_nobuf;
 	/* reset */
@@ -756,7 +756,7 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	if (!input_ep || !output_ep)
 		return -ENXIO;
 
-	buf = kmalloc(NEXIO_BUFSIZE, GFP_KERNEL);
+	buf = kmalloc(NEXIO_BUFSIZE, GFP_NOIO);
 	if (!buf)
 		goto out_buf;
 
@@ -788,11 +788,11 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 		switch (buf[0]) {
 		case 0x83:	/* firmware version */
 			if (!firmware_ver)
-				firmware_ver = kstrdup(&buf[2], GFP_KERNEL);
+				firmware_ver = kstrdup(&buf[2], GFP_NOIO);
 			break;
 		case 0x84:	/* device name */
 			if (!device_name)
-				device_name = kstrdup(&buf[2], GFP_KERNEL);
+				device_name = kstrdup(&buf[2], GFP_NOIO);
 			break;
 		}
 	}
@@ -806,19 +806,19 @@ static int nexio_init(struct usbtouch_usb *usbtouch)
 	/* prepare ACK URB */
 	ret = -ENOMEM;
 
-	usbtouch->priv = kmalloc(sizeof(struct nexio_priv), GFP_KERNEL);
+	usbtouch->priv = kmalloc(sizeof(struct nexio_priv), GFP_NOIO);
 	if (!usbtouch->priv)
 		goto out_buf;
 
 	priv = usbtouch->priv;
 
-	priv->ack_buf = kmalloc(sizeof(nexio_ack_pkt), GFP_KERNEL);
+	priv->ack_buf = kmalloc(sizeof(nexio_ack_pkt), GFP_NOIO);
 	if (!priv->ack_buf)
 		goto err_priv;
 
 	memcpy(priv->ack_buf, nexio_ack_pkt, sizeof(nexio_ack_pkt));
 
-	priv->ack = usb_alloc_urb(0, GFP_KERNEL);
+	priv->ack = usb_alloc_urb(0, GFP_NOIO);
 	if (!priv->ack) {
 		dbg("%s - usb_alloc_urb failed: usbtouch->ack", __func__);
 		goto err_ack_buf;
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
