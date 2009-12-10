From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH 2/7] msi-wmi: remove useless includes
Date: Thu, 10 Dec 2009 14:18:14 +0100
Message-ID: <1260451099-25620-3-git-send-email-anisse@astier.eu>
References: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:42837 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759331AbZLJN1i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Dec 2009 08:27:38 -0500
In-Reply-To: <1260451099-25620-1-git-send-email-anisse@astier.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matt Chen <machen@novell.com>, Anisse Astier <anisse@astier.eu>

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/platform/x86/msi-wmi.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index 7e0dab6..fb988d8 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -23,14 +23,8 @@
 
 
 #include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/types.h>
 #include <linux/input.h>
-#include <acpi/acpi_drivers.h>
 #include <linux/acpi.h>
-#include <linux/string.h>
-#include <linux/hrtimer.h>
 #include <linux/backlight.h>
 
 MODULE_AUTHOR("Thomas Renninger <trenn@suse.de>");
-- 
1.6.5.3

