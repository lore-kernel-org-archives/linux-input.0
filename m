From: akpm@linux-foundation.org
Subject: [patch 17/22] drivers/input/serio/hp_sdc.c: fix crash when removing hp_sdc module
Date: Wed, 04 Mar 2009 11:59:06 -0800
Message-ID: <200903041959.n24Jx70Q028463@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37763 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754205AbZCDUOi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 15:14:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, deller@gmx.de, elendil@planet.nl, geert@linux-m68k.org, grundler@parisc-linux.org, kyle@mcmartin.ca

From: Helge Deller <deller@gmx.de>

On parisc machines, which don't have HIL, removing the hp_sdc module
panics the kernel.  Fix this by returning early in hp_sdc_exit() if no HP
SDC controller was found.

Add functionality to probe for the hp_sdc_mlc kernel module (which takes
care of the upper layer HIL functionality on parisc) after two seconds. 
This is needed to get all the other HIL drivers (keyboard / mouse/ ..)
drivers automatically loaded by udev later as well.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Frans Pop <elendil@planet.nl>
Cc: Kyle McMartin <kyle@mcmartin.ca>
Cc: Grant Grundler <grundler@parisc-linux.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/hp_sdc.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff -puN drivers/input/serio/hp_sdc.c~drivers-input-serio-hp_sdcc-fix-crash-when-removing-hp_sdc-module drivers/input/serio/hp_sdc.c
--- a/drivers/input/serio/hp_sdc.c~drivers-input-serio-hp_sdcc-fix-crash-when-removing-hp_sdc-module
+++ a/drivers/input/serio/hp_sdc.c
@@ -819,6 +819,7 @@ static const struct parisc_device_id hp_
 MODULE_DEVICE_TABLE(parisc, hp_sdc_tbl);
 
 static int __init hp_sdc_init_hppa(struct parisc_device *d);
+static struct delayed_work moduleloader_work;
 
 static struct parisc_driver hp_sdc_driver = {
 	.name =		"hp_sdc",
@@ -930,8 +931,15 @@ static int __init hp_sdc_init(void)
 
 #if defined(__hppa__)
 
+static void request_module_delayed(struct work_struct *work)
+{
+	request_module("hp_sdc_mlc");
+}
+
 static int __init hp_sdc_init_hppa(struct parisc_device *d)
 {
+	int ret;
+
 	if (!d)
 		return 1;
 	if (hp_sdc.dev != NULL)
@@ -944,13 +952,26 @@ static int __init hp_sdc_init_hppa(struc
 	hp_sdc.data_io		= d->hpa.start + 0x800;
 	hp_sdc.status_io	= d->hpa.start + 0x801;
 
-	return hp_sdc_init();
+	INIT_DELAYED_WORK(&moduleloader_work, request_module_delayed);
+
+	ret = hp_sdc_init();
+	/* after sucessfull initialization give SDC some time to settle
+	 * and then load the hp_sdc_mlc upper layer driver */
+	if (!ret)
+		schedule_delayed_work(&moduleloader_work,
+			msecs_to_jiffies(2000));
+
+	return ret;
 }
 
 #endif /* __hppa__ */
 
 static void hp_sdc_exit(void)
 {
+	/* do nothing if we don't have a SDC */
+	if (!hp_sdc.dev)
+		return;
+
 	write_lock_irq(&hp_sdc.lock);
 
 	/* Turn off all maskable "sub-function" irq's. */
@@ -969,6 +990,7 @@ static void hp_sdc_exit(void)
 	tasklet_kill(&hp_sdc.task);
 
 #if defined(__hppa__)
+	cancel_delayed_work_sync(&moduleloader_work);
 	if (unregister_parisc_driver(&hp_sdc_driver))
 		printk(KERN_WARNING PREFIX "Error unregistering HP SDC");
 #endif
_
