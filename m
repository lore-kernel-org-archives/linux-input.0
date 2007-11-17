From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] Input: add i8042.noloop quirk for MS Virtual Machine
Date: Sat, 17 Nov 2007 10:46:45 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711171045390.12807@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:35438 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750835AbXKQJqr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Nov 2007 04:46:47 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Lawrence Steeger <vendor@russte.com>

From: Jiri Kosina <jkosina@suse.cz>

Input: add i8042.noloop quirk for MS Virtual Machine

When booted under Microsoft Virtual Machine, the noloop quirk is needed,
otherwise PS/2 mouse is not properly detected.

Reported-by: Lawrence Steeger <vendor@russte.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index f8fe421..c5e68dc 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -110,6 +110,14 @@ static struct dmi_system_id __initdata i8042_dmi_noloop_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
 		},
 	},
+	{
+		.ident = "Microsoft Virtual Machine",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
+		},
+	},
 	{ }
 };
