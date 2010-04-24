From: Florian Ragwitz <rafl@debian.org>
Subject: [PATCH 2/4] Input: Add an option to force the use of the elantech extension
Date: Sat, 24 Apr 2010 22:41:00 +0200
Message-ID: <1272141662-23431-3-git-send-email-rafl@debian.org>
References: <1272141662-23431-1-git-send-email-rafl@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:54455 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0DXV0l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Apr 2010 17:26:41 -0400
In-Reply-To: <1272141662-23431-1-git-send-email-rafl@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Florian Ragwitz <rafl@debian.org>

Apparently hardware vendors now ship elantech touchpads with different version
magic. This options allows for them to be tested easier with the current driver
in order to add their magic to the whitelist later.

Signed-off-by: Florian Ragwitz <rafl@debian.org>
---
 drivers/input/mouse/elantech.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 07f6b17..bfd08c7 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -25,6 +25,10 @@
 			printk(KERN_DEBUG format, ##arg);	\
 	} while (0)
 
+static unsigned int force_elantech;
+module_param_named(force_elantech, force_elantech, bool, 0644);
+MODULE_PARM_DESC(force_elantech, "Force the Elantech PS/2 protocol extension to be used, 1 = enabled, 0 = disabled (default).");
+
 /*
  * Send a Synaptics style sliced query command
  */
@@ -596,8 +600,12 @@ int elantech_detect(struct psmouse *psmouse, bool set_properties)
 		 param[0], param[1], param[2]);
 
 	if (param[0] == 0 || param[1] != 0) {
-		pr_debug("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
-		return -1;
+		if (!force_elantech) {
+			pr_debug("elantech.c: Probably not a real Elantech touchpad. Aborting.\n");
+			return -1;
+		}
+
+		pr_debug("elantech.c: Probably not a real Elantech touchpad. Enabling anyway due to force_elantech.\n");
 	}
 
 	if (set_properties) {
-- 
1.7.0.5

