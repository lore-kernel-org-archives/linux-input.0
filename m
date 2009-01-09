From: akpm@linux-foundation.org
Subject: [patch 05/17] i8042: add Blue FB5601 to noloop exception table
Date: Fri, 09 Jan 2009 12:19:45 -0800
Message-ID: <200901092019.n09KJjON017145@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57967 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753966AbZAIUUi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Jan 2009 15:20:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, sbader3@googlemail.com, stefan.bader@canonical.com

From: "Stefan Bader" <sbader3@googlemail.com>

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN drivers/input/serio/i8042-x86ia64io.h~i8042-add-blue-fb5601-to-noloop-execption-table drivers/input/serio/i8042-x86ia64io.h
--- a/drivers/input/serio/i8042-x86ia64io.h~i8042-add-blue-fb5601-to-noloop-execption-table
+++ a/drivers/input/serio/i8042-x86ia64io.h
@@ -151,6 +151,14 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
 		},
 	},
+	{
+		.ident = "Blue FB5601",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
+		},
+	},
 	{ }
 };
 
_
