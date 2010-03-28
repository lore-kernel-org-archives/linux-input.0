From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] [resend] usbtouchscreen: support bigger iNexio touchscreens
Date: Sun, 28 Mar 2010 22:15:38 +0200
Message-ID: <201003282215.41522.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, daniel.ritz@gmx.ch, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Bigger Nexio touchscreens not only send more data but also the header values
are modified somehow. Fix the header somehow (it's a guesswork but it works
at least on one 46" touchscreen with 2.00SMS firmware) and also increase
rept_size.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-2.6.34-rc1-orig/drivers/input/touchscreen/usbtouchscreen.c	2010-03-16 13:34:51.000000000 +0100
+++ linux-2.6.34-rc1/drivers/input/touchscreen/usbtouchscreen.c	2010-03-16 13:46:15.000000000 +0100
@@ -858,6 +858,11 @@
 	if ((pkt[0] & 0xe0) != 0xe0)
 		return 0;
 
+	if (be16_to_cpu(packet->data_len) > 0xff)
+		packet->data_len = cpu_to_be16(be16_to_cpu(packet->data_len) - 0x100);
+	if (be16_to_cpu(packet->x_len) > 0xff)
+		packet->x_len = cpu_to_be16(be16_to_cpu(packet->x_len) - 0x80);
+
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
 
@@ -1113,7 +1118,7 @@
 
 #ifdef CONFIG_TOUCHSCREEN_USB_NEXIO
 	[DEVTYPE_NEXIO] = {
-		.rept_size	= 128,
+		.rept_size	= 1024,
 		.irq_always	= true,
 		.read_data	= nexio_read_data,
 		.init		= nexio_init,


-- 
Ondrej Zary
