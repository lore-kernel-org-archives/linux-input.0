From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 6/7] msi-wmi: replace one-condition switch-case with if statement
Date: Thu, 10 Dec 2009 14:18:18 +0100
Message-ID: <1260451099-25620-7-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:7370 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759502AbZLJN1m (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:42 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/msi-wmi.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index d757935..2c2afc1 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -243,14 +243,10 @@ static void msi_wmi_notify(u32 value, void *context)
 			}
 			key->last_pressed = cur;
 
-			switch (key->type) {
-			case KE_KEY:
-				/* Brightness is served via acpi video driver */
-				if (!backlight &&
-				    (key->keycode == KEY_BRIGHTNESSUP ||
-				     key->keycode == KEY_BRIGHTNESSDOWN))
-					break;
-
+			if (key->type == KE_KEY &&
+			/* Brightness is served via acpi video driver */
+			(backlight || (key->keycode != KEY_BRIGHTNESSUP &&
+			key->keycode != KEY_BRIGHTNESSDOWN))) {
 				dprintk("Send key: 0x%X - "
 					"Input layer keycode: %d\n", key->code,
 					 key->keycode);
@@ -260,7 +256,6 @@ static void msi_wmi_notify(u32 value, void *context)
 				input_report_key(msi_wmi_input_dev,
 						 key->keycode, 0);
 				input_sync(msi_wmi_input_dev);
-				break;
 			}
 		} else
 			printk(KERN_INFO "Unknown key pressed - %x\n",
-- 
1.6.5.3

