From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 5/7] msi-wmi: remove unused field 'instance' in key_entry structure
Date: Thu, 10 Dec 2009 14:18:17 +0100
Message-ID: <1260451099-25620-6-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:37968 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759310AbZLJN1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:40 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/msi-wmi.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index 75e422b..d757935 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -56,7 +56,6 @@ struct key_entry {
 	char type;		/* See KE_* below */
 	u16 code;
 	u16 keycode;
-	int instance;
 	ktime_t last_pressed;
 };
 
@@ -67,10 +66,10 @@ struct key_entry {
 enum { KE_KEY, KE_END };
 
 static struct key_entry msi_wmi_keymap[] = {
-	{ KE_KEY, 0xd0, KEY_BRIGHTNESSUP,   0, {0, } },
-	{ KE_KEY, 0xd1, KEY_BRIGHTNESSDOWN, 1, {0, } },
-	{ KE_KEY, 0xd2, KEY_VOLUMEUP,	2, {0, } },
-	{ KE_KEY, 0xd3, KEY_VOLUMEDOWN,	3, {0, } },
+	{ KE_KEY, 0xd0, KEY_BRIGHTNESSUP,   {0, } },
+	{ KE_KEY, 0xd1, KEY_BRIGHTNESSDOWN, {0, } },
+	{ KE_KEY, 0xd2, KEY_VOLUMEUP,	{0, } },
+	{ KE_KEY, 0xd3, KEY_VOLUMEDOWN,	{0, } },
 	{ KE_END, 0}
 };
 
-- 
1.6.5.3

