From: Helge Deller <deller@gmx.de>
Subject: [PATCH, HP SDC] add option to disable HP SDC driver
Date: Sun, 13 Jul 2008 18:12:56 +0200
Message-ID: <200807131812.56801.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:38810 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751977AbYGMQNA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Jul 2008 12:13:00 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Add "no_hpsdc" kernel module option to the hp_sdc driver, so that
the driver can be instructed to not enable the HP SDC port.

This is useful on some older HPPA boxes with HIL keyboard 
and HIL mouse where the new HP SDC HIL drivers don't work 
yet. By disabling the new hp_sdc driver users are able to use
the older hilkbd driver instead.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index edfedd9..ba11d1b 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -105,6 +105,10 @@ EXPORT_SYMBOL(__hp_sdc_enqueue_transaction);
 EXPORT_SYMBOL(hp_sdc_enqueue_transaction);
 EXPORT_SYMBOL(hp_sdc_dequeue_transaction);
 
+static unsigned int hp_sdc_disabled;
+module_param_named(no_hpsdc, hp_sdc_disabled, bool, 0);
+MODULE_PARM_DESC(no_hpsdc, "Do not enable HP SDC driver.");
+
 static hp_i8042_sdc	hp_sdc;	/* All driver state is kept in here. */
 
 /*************** primitives for use in any context *********************/
@@ -980,6 +984,11 @@ static int __init hp_sdc_register(void)
 	unsigned char i;
 #endif
 
+	if (hp_sdc_disabled) {
+		printk(KERN_WARNING PREFIX "HP SDC driver disabled by no_hpsdc=1.\n");
+		return -ENODEV;
+	}
+	
 	hp_sdc.dev = NULL;
 	hp_sdc.dev_err = 0;
 #if defined(__hppa__)
