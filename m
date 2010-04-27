From: akpm@linux-foundation.org
Subject: [patch 2/3] usbtouchscreen: support bigger iNexio touchscreens
Date: Tue, 27 Apr 2010 14:12:38 -0700
Message-ID: <201004272112.o3RLCcnp020085@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58617 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753834Ab0D0VNW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Apr 2010 17:13:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, linux@rainbow-software.org, oliver@neukum.org

From: Ondrej Zary <linux@rainbow-software.org>

Bigger Nexio touchscreens not only send more data but also the header
values are modified somehow.  Fix the header somehow (it's a guesswork but
it works at least on one 46" touchscreen with 2.00SMS firmware) and also
increase rept_size.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Cc: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/usbtouchscreen.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff -puN drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-support-bigger-inexio-touchscreens drivers/input/touchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-support-bigger-inexio-touchscreens
+++ a/drivers/input/touchscreen/usbtouchscreen.c
@@ -858,6 +858,11 @@ static int nexio_read_data(struct usbtou
 	if ((pkt[0] & 0xe0) != 0xe0)
 		return 0;
 
+	if (be16_to_cpu(packet->data_len) > 0xff)
+		packet->data_len = cpu_to_be16(be16_to_cpu(packet->data_len) - 0x100);
+	if (be16_to_cpu(packet->x_len) > 0xff)
+		packet->x_len = cpu_to_be16(be16_to_cpu(packet->x_len) - 0x80);
+
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
 
@@ -1113,7 +1118,7 @@ static struct usbtouch_device_info usbto
 
 #ifdef CONFIG_TOUCHSCREEN_USB_NEXIO
 	[DEVTYPE_NEXIO] = {
-		.rept_size	= 128,
+		.rept_size	= 1024,
 		.irq_always	= true,
 		.read_data	= nexio_read_data,
 		.init		= nexio_init,
_
