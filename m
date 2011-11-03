From: Tomas =?utf-8?B?TWlsamVub3ZpxIc=?= <TomasM@tomasm.tk>
Subject: [PATCH]  Input: add newer HP Pavilion dv4s to 'notimeout' and 'nomux' blacklists
Date: Thu, 03 Nov 2011 12:37:26 +1000
Message-ID: <1536567.07NNFmgTxM@hp-tmm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 60-242-0-245.static.tpgi.com.au ([60.242.0.245]:53416 "EHLO
	mail.tomasm.tk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754465Ab1KCCqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Nov 2011 22:46:44 -0400
Received: from hp-tmm.localnet (unknown [192.168.0.42])
	by mail.tomasm.tk (Postfix) with ESMTPS id 7AD4D200E5B
	for <linux-input@vger.kernel.org>; Thu,  3 Nov 2011 12:34:06 +1000 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Touchpad input doesn't work with newer HP Pavilion dv4 laptops due to bad i8042
timeout data.  Booting with i8042.notimeout and i8042.nomux successfully works
around the problem.

This patch adds the devices to the i8042 notimeout and nomux blacklists.

Signed-off-by: Tomas Miljenovic <TomasM@tomasm.tk>
---
diff -up a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h	2011-07-22 12:17:23.000000000 +1000
+++ b/drivers/input/serio/i8042-x86ia64io.h	2011-11-03 00:09:07.701073695 +1000
@@ -431,6 +431,13 @@ static const struct dmi_system_id __init
 			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
 		},
 	},
+        {
+                /* Newer HP Pavilion dv4 models */
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
+                },
+        },
 	{ }
 };
 
@@ -560,6 +567,13 @@ static const struct dmi_system_id __init
 			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
 		},
 	},
+                {
+                /* Newer HP Pavilion dv4 models */
+                .matches = {
+                        DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+                        DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
+                },
+        },
 	{ }
 };
 

