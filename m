From: Yan Li <yan.i.li@intel.com>
Subject: [PATCH] More i8042-reset quirks for MSI Wind-clone netbooks
Date: Mon, 15 Jun 2009 22:16:13 +0800
Message-ID: <20090615141613.GA7876@sage.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:14408 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbZFOOQP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2009 10:16:15 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: yanli@infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, greg@kroah.com

When testing Moblin on various netbooks, we've got reports that many
MSI Wind clones need the i8042 reset quirks for the keyboard and/or
touchpad's proper function.

Signed-off-by: Yan Li <yan.i.li@intel.com>
---
 drivers/input/serio/i8042-x86ia64io.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index fb8a3cd..924e8ed 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -392,6 +392,34 @@ static struct dmi_system_id __initdata i8042_dmi_reset_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
 		},
 	},
+	{
+		.ident = "Acer Aspire One 150",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
+		},
+	},
+	{
+		.ident = "Advent 4211",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
+		},
+	},
+	{
+		.ident = "Medion Akoya Mini E1210",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
+		},
+	},
+	{
+		.ident = "Mivvy M310",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
+		},
+	},
 	{ }
 };
 
-- 
1.6.3.1


-- 
Best regards,
Li, Yan

Moblin Team, Opensource Technology Center, SSG, Intel
Office tel.: +86-10-82171695 (inet: 8-758-1695)
OpenPGP key: 5C6C31EF
IRC: yanli on network irc.freenode.net
