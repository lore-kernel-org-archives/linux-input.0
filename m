From: yalin wang <yalin.wang2010@gmail.com>
Subject: [PATCH] goldfish: add goldfish match node for dt driver probe
Date: Fri,  6 Nov 2015 13:24:01 +0800
Message-ID: <1446787441-18846-1-git-send-email-yalin.wang2010@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, yalin.wang2010@gmail.com, peter.senna@gmail.com, joe@perches.com, dan.carpenter@oracle.com, alan@linux.intel.com, somyaanand214@gmail.com, mahfouz.saif.elyazal@gmail.com, ricardo.ribalda@gmail.com, ravi2j@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/input/keyboard/goldfish_events.c  |  9 +++++++++
 drivers/platform/goldfish/goldfish_pipe.c | 11 ++++++++++-
 drivers/power/goldfish_battery.c          | 11 ++++++++++-
 drivers/staging/goldfish/goldfish_audio.c | 11 ++++++++++-
 drivers/staging/goldfish/goldfish_nand.c  |  9 +++++++++
 drivers/tty/goldfish.c                    | 11 ++++++++++-
 drivers/video/fbdev/goldfishfb.c          | 10 +++++++++-
 7 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/goldfish_events.c b/drivers/input/keyboard/goldfish_events.c
index 907e4e2..7b99ab8 100644
--- a/drivers/input/keyboard/goldfish_events.c
+++ b/drivers/input/keyboard/goldfish_events.c
@@ -18,6 +18,7 @@
 #include <linux/types.h>
 #include <linux/input.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
@@ -178,10 +179,18 @@ static int events_probe(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_events_match[] = {
+	{ .compatible = "generic,goldfish-events-keypad" },
+	{ },
+};
+#endif
+
 static struct platform_driver events_driver = {
 	.probe	= events_probe,
 	.driver	= {
 		.name	= "goldfish_events",
+		.of_match_table	= of_match_ptr(goldfish_events_match),
 	},
 };
 
diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index e7a29e2..55b6d7c 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -50,6 +50,7 @@
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
 #include <linux/miscdevice.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/sched.h>
@@ -615,11 +616,19 @@ static int goldfish_pipe_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_pipe_match[] = {
+	{ .compatible = "generic,android-pipe" },
+	{ },
+};
+#endif
+
 static struct platform_driver goldfish_pipe = {
 	.probe = goldfish_pipe_probe,
 	.remove = goldfish_pipe_remove,
 	.driver = {
-		.name = "goldfish_pipe"
+		.name = "goldfish_pipe",
+		.of_match_table	= of_match_ptr(goldfish_pipe_match),
 	}
 };
 
diff --git a/drivers/power/goldfish_battery.c b/drivers/power/goldfish_battery.c
index a50bb98..48b057d 100644
--- a/drivers/power/goldfish_battery.c
+++ b/drivers/power/goldfish_battery.c
@@ -18,6 +18,7 @@
 
 #include <linux/module.h>
 #include <linux/err.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/types.h>
@@ -227,11 +228,19 @@ static int goldfish_battery_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_battery_match[] = {
+	{ .compatible = "generic,goldfish-battery" },
+	{ },
+};
+#endif
+
 static struct platform_driver goldfish_battery_device = {
 	.probe		= goldfish_battery_probe,
 	.remove		= goldfish_battery_remove,
 	.driver = {
-		.name = "goldfish-battery"
+		.name = "goldfish-battery",
+		.of_match_table	= of_match_ptr(goldfish_battery_match),
 	}
 };
 module_platform_driver(goldfish_battery_device);
diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index b0927e4..f0c5118 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
 #include <linux/pci.h>
@@ -344,11 +345,19 @@ static int goldfish_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_audio_match[] = {
+	{ .compatible = "generic,goldfish-audio" },
+	{ },
+};
+#endif
+
 static struct platform_driver goldfish_audio_driver = {
 	.probe		= goldfish_audio_probe,
 	.remove		= goldfish_audio_remove,
 	.driver = {
-		.name = "goldfish_audio"
+		.name = "goldfish_audio",
+		.of_match_table	= of_match_ptr(goldfish_audio_match),
 	}
 };
 
diff --git a/drivers/staging/goldfish/goldfish_nand.c b/drivers/staging/goldfish/goldfish_nand.c
index 623353db5..f26de0f 100644
--- a/drivers/staging/goldfish/goldfish_nand.c
+++ b/drivers/staging/goldfish/goldfish_nand.c
@@ -23,6 +23,7 @@
 #include <linux/ioport.h>
 #include <linux/vmalloc.h>
 #include <linux/mtd/mtd.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/goldfish.h>
@@ -430,11 +431,19 @@ static int goldfish_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_nand_match[] = {
+	{ .compatible = "generic,goldfish-nand" },
+	{ },
+};
+#endif
+
 static struct platform_driver goldfish_nand_driver = {
 	.probe		= goldfish_nand_probe,
 	.remove		= goldfish_nand_remove,
 	.driver = {
 		.name = "goldfish_nand"
+		.of_match_table	= of_match_ptr(goldfish_nand_match),
 	}
 };
 
diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 0f82c0b..a49f4a2 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -15,6 +15,7 @@
 
 #include <linux/console.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
@@ -324,11 +325,19 @@ static int goldfish_tty_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_tty_match[] = {
+	{ .compatible = "generic,goldfish-tty" },
+	{ },
+};
+#endif
+
 static struct platform_driver goldfish_tty_platform_driver = {
 	.probe = goldfish_tty_probe,
 	.remove = goldfish_tty_remove,
 	.driver = {
-		.name = "goldfish_tty"
+		.name = "goldfish_tty",
+		.of_match_table = of_match_ptr(goldfish_tty_match),
 	}
 };
 
diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 7f6c9e6..809c502 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 
 enum {
@@ -304,12 +305,19 @@ static int goldfish_fb_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id goldfish_fb_match[] = {
+	{ .compatible = "generic,goldfish-fb" },
+	{ },
+};
+#endif
 
 static struct platform_driver goldfish_fb_driver = {
 	.probe		= goldfish_fb_probe,
 	.remove		= goldfish_fb_remove,
 	.driver = {
-		.name = "goldfish_fb"
+		.name = "goldfish_fb",
+		.of_match_table = of_match_ptr(goldfish_fb_match),
 	}
 };
 
-- 
1.9.1

