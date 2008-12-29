From: Helge Deller <deller@gmx.de>
Subject: [PATCH] drivers/input/serio/hp_sdc.c: fix crash when removing hp_sdc
 module
Date: Mon, 29 Dec 2008 13:19:45 +0100
Message-ID: <4958C061.2050702@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050402010102020408030801"
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Linux/m68k <linux-m68k@vger.kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frans Pop <elendil@planet.nl>
List-Id: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402010102020408030801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

resending, as I forgot to CC: Geert and linux-m68k

-------- Original Message --------
Subject: [PATCH] drivers/input/serio/hp_sdc.c: fix crash when removing
hp_sdc module
Date: Fri, 26 Dec 2008 21:24:31 +0100
From: Helge Deller <deller@gmx.de>
To: linux-input@vger.kernel.org,  Dmitry Torokhov
<dmitry.torokhov@gmail.com>
CC: Helge Deller <deller@gmx.de>, Frans Pop <elendil@planet.nl>

On parisc machines, which don't have HIL, removing the hp_sdc module
panics the kernel. Fix this by returning early in hp_sdc_exit() if no HP
SDC controller was found.

Add functionality to probe for the hp_sdc_mlc kernel module (which takes
care of the upper layer HIL functionality on parisc) after two seconds.
This is needed to get all the other HIL drivers (keyboard / mouse/ ..)
drivers automatically loaded by udev later as well.

Signed-off-by: Helge Deller <deller@gmx.de>

 hp_sdc.c |   24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)



--------------050402010102020408030801
Content-Type: text/x-patch;
 name="hp_sdc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hp_sdc.patch"

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index bfe4924..1c9410d 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -819,6 +819,7 @@ static const struct parisc_device_id hp_sdc_tbl[] = {
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
@@ -944,13 +952,26 @@ static int __init hp_sdc_init_hppa(struct parisc_device *d)
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


--------------050402010102020408030801--
