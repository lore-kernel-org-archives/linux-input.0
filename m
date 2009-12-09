From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/2] dell-laptop: Update rfkill state on kill switch
Date: Wed,  9 Dec 2009 13:33:29 -0500
Message-ID: <1260383609-7681-2-git-send-email-mjg@redhat.com>
References: <1260383609-7681-1-git-send-email-mjg@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1260383609-7681-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, dtor@mail.ru, lenb@kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-input@vger.kernel.org

The rfkill interface on Dells only sends a notification that the switch
has been changed via the keyboard controller. Add a filter so we can
pick these notifications up and update the rfkill state appropriately.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/platform/x86/dell-laptop.c |   40 ++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 9061111..9dbec0f 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -22,6 +22,7 @@
 #include <linux/rfkill.h>
 #include <linux/power_supply.h>
 #include <linux/acpi.h>
+#include <linux/i8042.h>
 #include "../../firmware/dcdbas.h"
 
 #define BRIGHTNESS_TOKEN 0x7d
@@ -206,6 +207,16 @@ static const struct rfkill_ops dell_rfkill_ops = {
 	.query = dell_rfkill_query,
 };
 
+static void dell_rfkill_update(void)
+{
+	if (wifi_rfkill)
+		dell_rfkill_query(wifi_rfkill, (void *)1);
+	if (bluetooth_rfkill)
+		dell_rfkill_query(bluetooth_rfkill, (void *)2);
+	if (wwan_rfkill)
+		dell_rfkill_query(wwan_rfkill, (void *)3);
+}
+
 static int dell_setup_rfkill(void)
 {
 	struct calling_interface_buffer buffer;
@@ -310,6 +321,26 @@ static struct backlight_ops dell_ops = {
 	.update_status  = dell_send_intensity,
 };
 
+bool dell_laptop_i8042_filter(unsigned char data, unsigned int flags,
+			      struct serio *port)
+{
+	static bool extended;
+
+	if (unlikely(data == 0xe0)) {
+		extended = true;
+		return false;
+	} else if (unlikely(extended)) {
+		switch (data) {
+		case 0x8:
+			dell_rfkill_update();
+			break;
+		}
+		extended = false;
+	}
+
+	return false;
+}
+
 static int __init dell_init(void)
 {
 	struct calling_interface_buffer buffer;
@@ -333,6 +364,13 @@ static int __init dell_init(void)
 		goto out;
 	}
 
+	ret = i8042_install_filter(I8042_KBD_PORT_NO, dell_laptop_i8042_filter);
+	if (ret) {
+		printk(KERN_WARNING
+		       "dell-laptop: Unable to install key filter\n");
+		goto out;
+	}
+
 #ifdef CONFIG_ACPI
 	/* In the event of an ACPI backlight being available, don't
 	 * register the platform controller.
@@ -369,6 +407,7 @@ static int __init dell_init(void)
 
 	return 0;
 out:
+	i8042_remove_filter(I8042_KBD_PORT_NO, dell_laptop_i8042_filter);
 	if (wifi_rfkill)
 		rfkill_unregister(wifi_rfkill);
 	if (bluetooth_rfkill)
@@ -381,6 +420,7 @@ out:
 
 static void __exit dell_exit(void)
 {
+	i8042_remove_filter(I8042_KBD_PORT_NO, dell_laptop_i8042_filter);
 	backlight_device_unregister(dell_backlight_device);
 	if (wifi_rfkill)
 		rfkill_unregister(wifi_rfkill);
-- 
1.6.5.2

