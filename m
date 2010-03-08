From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] INPUT: enable remote wakeup for PNP i8042 keyboard ports
Date: Mon, 8 Mar 2010 16:52:42 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1003081651220.1297-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48904 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755859Ab0CHVwn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Mar 2010 16:52:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This patch (as1355) enables remote wakeup by default on PNP i8042
keyboard ports.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- usb-2.6.orig/drivers/input/serio/i8042-x86ia64io.h
+++ usb-2.6/drivers/input/serio/i8042-x86ia64io.h
@@ -624,6 +624,9 @@ static int i8042_pnp_kbd_probe(struct pn
 		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
 	}
 
+	/* Keyboard ports are always supposed to be wakeup-enabled */
+	device_set_wakeup_enable(&dev->dev, true);
+
 	i8042_pnp_kbd_devices++;
 	return 0;
 }

