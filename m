From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 3/7] msi-wmi: rework init
Date: Thu, 10 Dec 2009 14:18:15 +0100
Message-ID: <1260451099-25620-4-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42837 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759335AbZLJN1g (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:36 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

There should be less code duplication with usage of gotos
Driver won't load if there's no hardware to control
Safer error handling at input driver allocation

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/msi-wmi.c |   64 ++++++++++++++++++++++------------------
 1 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index fb988d8..dcb048c 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -284,6 +284,8 @@ static int __init msi_wmi_input_setup(void)
 	int err;
 
 	msi_wmi_input_dev = input_allocate_device();
+	if (!msi_wmi_input_dev)
+		return -ENOMEM;
 
 	msi_wmi_input_dev->name = "MSI WMI hotkeys";
 	msi_wmi_input_dev->phys = "wmi/input0";
@@ -314,40 +316,44 @@ static int __init msi_wmi_init(void)
 {
 	int err;
 
-	if (wmi_has_guid(MSIWMI_EVENT_GUID)) {
-		err = wmi_install_notify_handler(MSIWMI_EVENT_GUID,
-						 msi_wmi_notify, NULL);
-		if (err)
-			return -EINVAL;
-
-		err = msi_wmi_input_setup();
-		if (err) {
-			wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
-			return -EINVAL;
-		}
+	if (!wmi_has_guid(MSIWMI_EVENT_GUID)) {
+		printk(KERN_ERR
+		       "This machine doesn't have MSI-hotkeys through WMI\n");
+		return -ENODEV;
+	}
+	err = wmi_install_notify_handler(MSIWMI_EVENT_GUID,
+			msi_wmi_notify, NULL);
+	if (err)
+		return -EINVAL;
 
-		if (!acpi_video_backlight_support()) {
-			backlight = backlight_device_register(DRV_NAME,
-					      NULL, NULL, &msi_backlight_ops);
-			if (IS_ERR(backlight)) {
-				wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
-				input_unregister_device(msi_wmi_input_dev);
-				return -EINVAL;
-			}
+	err = msi_wmi_input_setup();
+	if (err)
+		goto err_uninstall_notifier;
 
-			backlight->props.max_brightness = ARRAY_SIZE(backlight_map) - 1;
-			err = bl_get(NULL);
-			if (err < 0) {
-				wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
-				input_unregister_device(msi_wmi_input_dev);
-				backlight_device_unregister(backlight);
-				return -EINVAL;
-			}
-			backlight->props.brightness = err;
-		}
+	if (!acpi_video_backlight_support()) {
+		backlight = backlight_device_register(DRV_NAME,
+				NULL, NULL, &msi_backlight_ops);
+		if (IS_ERR(backlight))
+			goto err_free_input;
+
+		backlight->props.max_brightness = ARRAY_SIZE(backlight_map) - 1;
+		err = bl_get(NULL);
+		if (err < 0)
+			goto err_free_backlight;
+
+		backlight->props.brightness = err;
 	}
 	printk(KERN_INFO DRV_PFX "Event handler installed\n");
+
 	return 0;
+
+err_free_backlight:
+	backlight_device_unregister(backlight);
+err_free_input:
+	input_unregister_device(msi_wmi_input_dev);
+err_uninstall_notifier:
+	wmi_remove_notify_handler(MSIWMI_EVENT_GUID);
+	return err;
 }
 
 static void __exit msi_wmi_exit(void)
-- 
1.6.5.3

