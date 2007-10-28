From: Helge Deller <deller@gmx.de>
Subject: [PATCH] inport.c & logibm.c should use KERN_WARNING instead of KERN_ERR
Date: Sun, 28 Oct 2007 19:58:05 +0100
Message-ID: <200710281958.05589.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: dmitry.torokhov@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Many mouse drivers are often compiled (e.g. in Linux distributions) into the kernel at the same time just to make sure that at least one driver will suceed to find it's mouse device.
Nevertheless, only the inport and logitech busmouse mouse drivers report with KERN_ERR log level if the mouse wasn't found.
I think they should use KERN_WARNING instead, because it's not an error if the mouse isn't attached at all.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/input/mouse/inport.c b/drivers/input/mouse/inport.c
index 655a392..db3a80e 100644
--- a/drivers/input/mouse/inport.c
+++ b/drivers/input/mouse/inport.c
@@ -144,7 +144,7 @@ static int __init inport_init(void)
 	b = inb(INPORT_SIGNATURE_PORT);
 	c = inb(INPORT_SIGNATURE_PORT);
 	if (a == b || a != c) {
-		printk(KERN_ERR "inport.c: Didn't find InPort mouse at %#x\n", INPORT_BASE);
+		printk(KERN_WARNING "inport.c: Didn't find InPort mouse at %#x\n", INPORT_BASE);
 		err = -ENODEV;
 		goto err_release_region;
 	}
diff --git a/drivers/input/mouse/logibm.c b/drivers/input/mouse/logibm.c
index b23a4f3..a53d1d8 100644
--- a/drivers/input/mouse/logibm.c
+++ b/drivers/input/mouse/logibm.c
@@ -134,7 +134,7 @@ static int __init logibm_init(void)
 	udelay(100);
 
 	if (inb(LOGIBM_SIGNATURE_PORT) != LOGIBM_SIGNATURE_BYTE) {
-		printk(KERN_ERR "logibm.c: Didn't find Logitech busmouse at %#x\n", LOGIBM_BASE);
+		printk(KERN_WARNING "logibm.c: Didn't find Logitech busmouse at %#x\n", LOGIBM_BASE);
 		err = -ENODEV;
 		goto err_release_region;
 	}
