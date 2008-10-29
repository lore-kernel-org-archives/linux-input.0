From: akpm@linux-foundation.org
Subject: [patch 6/7] i8042: add Blue FB5601 to noloop exception table
Date: Wed, 29 Oct 2008 14:19:45 -0700
Message-ID: <200810292119.m9TLJjSQ019163@imap1.linux-foundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35830 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754098AbYJ2VUN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Oct 2008 17:20:13 -0400
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
@@ -143,6 +143,14 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
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
