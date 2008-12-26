From: Helge Deller <deller@gmx.de>
Subject: [PATCH] input/keyboard/hilkbd.c: fix crash when removing hilkbd module
Date: Fri, 26 Dec 2008 20:51:21 +0100
Message-ID: <495535B9.5070009@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000901060502010008030002"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:45820 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750933AbYLZTw5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Dec 2008 14:52:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Frans Pop <elendil@planet.nl>

This is a multi-part message in MIME format.
--------------000901060502010008030002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On parisc machines, which don't have HIL, removing the hilkbd module
panics the kernel. Fix this by adding proper implementations for the
probe and remove functions to the parisc_driver structure.

A few functions were renamed to clean up the code and make it easier
readable.

Disable the MODULE_DEVICE_TABLE() macro on parisc since the kernel
module autoloader should instead prefer the hp_sdc driver which takes
care of full HIL support, including HIL mouse and HIL tablets.

Signed-off-by: Helge Deller <deller@gmx.de>
CC: Geert Uytterhoeven <geert@linux-m68k.org>


--------------000901060502010008030002
Content-Type: text/x-patch;
 name="hilkbd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hilkbd.patch"

diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index aacf71f..9711547 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -198,9 +198,8 @@ static void hil_do(unsigned char cmd, unsigned char *data, unsigned int len)
 }
 
 
-/* initialise HIL */
-static int __init
-hil_keyb_init(void)
+/* initialize HIL */
+static int __init hil_keyb_init(void)
 {
 	unsigned char c;
 	unsigned int i, kbid;
@@ -308,13 +307,39 @@ err1:
 	return err;
 }
 
+static void __exit hil_keyb_exit(void)
+{
+	/* exit if there is no HIL keyboard */
+	if (!hil_dev.dev)
+		return;
+
+	if (HIL_IRQ) {
+		disable_irq(HIL_IRQ);
+		free_irq(HIL_IRQ, hil_dev.dev_id);
+	}
+
+	/* Turn off interrupts */
+	hil_do(HIL_INTOFF, NULL, 0);
+
+	input_unregister_device(hil_dev.dev);
+
+	hil_dev.dev = NULL;
+
+#if defined(CONFIG_HP300)
+	release_region(HILBASE+HIL_DATA, 2);
+#endif
+}
 
 #if defined(CONFIG_PARISC)
-static int __init
-hil_init_chip(struct parisc_device *dev)
+static int __init hil_probe_chip(struct parisc_device *dev)
 {
+	/* Only allow one HIL keyboard */
+	if (hil_dev.dev)
+		return -ENODEV;
+
 	if (!dev->irq) {
-		printk(KERN_WARNING "HIL: IRQ not found for HIL bus at 0x%08lx\n", dev->hpa.start);
+		printk(KERN_WARNING "HIL: IRQ not found for HIL bus at 0x%p\n",
+			(void *)dev->hpa.start);
 		return -ENODEV;
 	}
 
@@ -327,17 +352,27 @@ hil_init_chip(struct parisc_device *dev)
 	return hil_keyb_init();
 }
 
+static int __exit hil_remove_chip(struct parisc_device *dev)
+{
+	hil_keyb_exit();
+	return 0;
+}
+
 static struct parisc_device_id hil_tbl[] = {
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00073 },
 	{ 0, }
 };
 
+#if 0
+/* Disabled to avoid conflicts with the HP SDC HIL drivers */
 MODULE_DEVICE_TABLE(parisc, hil_tbl);
+#endif
 
 static struct parisc_driver hil_driver = {
 	.name =		"hil",
 	.id_table =	hil_tbl,
-	.probe =	hil_init_chip,
+	.probe =	hil_probe_chip,
+	.remove =	hil_remove_chip,
 };
 #endif /* CONFIG_PARISC */
 
@@ -354,22 +389,10 @@ static int __init hil_init(void)
 
 static void __exit hil_exit(void)
 {
-	if (HIL_IRQ) {
-		disable_irq(HIL_IRQ);
-		free_irq(HIL_IRQ, hil_dev.dev_id);
-	}
-
-	/* Turn off interrupts */
-	hil_do(HIL_INTOFF, NULL, 0);
-
-	input_unregister_device(hil_dev.dev);
-
-	hil_dev.dev = NULL;
-
 #if defined(CONFIG_PARISC)
 	unregister_parisc_driver(&hil_driver);
 #else
-	release_region(HILBASE+HIL_DATA, 2);
+	hil_keyb_exit();
 #endif
 }
 

--------------000901060502010008030002--

