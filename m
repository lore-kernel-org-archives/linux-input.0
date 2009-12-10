From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 4/7] msi-wmi: remove custom runtime debug implementation
Date: Thu, 10 Dec 2009 14:18:16 +0100
Message-ID: <1260451099-25620-5-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:45121 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759394AbZLJN1i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:38 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

Rely on DYNAMIC_DEBUG instead if needed

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/msi-wmi.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index dcb048c..75e422b 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -31,10 +31,6 @@ MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
 MODULE_DESCRIPTION("MSI laptop WMI hotkeys driver");
 MODULE_LICENSE("GPL");
 
-static int debug;
-module_param(debug, int, 0);
-MODULE_PARM_DESC(debug, "Set this to 1 to let the driver be more verbose");
-
 MODULE_ALIAS("wmi:551A1F84-FBDD-4125-91DB-3EA8F44F1D45");
 MODULE_ALIAS("wmi:B6F3EEF2-3D2F-49DC-9DE3-85BCE18C62F2");
 
@@ -54,10 +50,7 @@ MODULE_ALIAS("dmi:*:svnMICRO-STARINTERNATIONAL*:pnMS-6638:*");
 #define MSIWMI_BIOS_GUID "551A1F84-FBDD-4125-91DB-3EA8F44F1D45"
 #define MSIWMI_EVENT_GUID "B6F3EEF2-3D2F-49DC-9DE3-85BCE18C62F2"
 
-#define dprintk(msg...)	do {			\
-	if (debug)				\
-		printk(KERN_INFO DRV_PFX  msg); \
-	} while (0)
+#define dprintk(msg...) pr_debug(DRV_PFX msg)
 
 struct key_entry {
 	char type;		/* See KE_* below */
@@ -343,7 +336,7 @@ static int __init msi_wmi_init(void)
 
 		backlight->props.brightness = err;
 	}
-	printk(KERN_INFO DRV_PFX "Event handler installed\n");
+	dprintk("Event handler installed\n");
 
 	return 0;
 
-- 
1.6.5.3

