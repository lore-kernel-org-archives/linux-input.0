From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] HID: corsair: Convert to use module_hid_driver
Date: Wed, 16 Dec 2015 16:56:39 +0800
Message-ID: <1450256199.17220.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36368 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754500AbbLPI4o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 03:56:44 -0500
Received: by mail-pf0-f180.google.com with SMTP id o64so9009696pfb.3
        for <linux-input@vger.kernel.org>; Wed, 16 Dec 2015 00:56:44 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: =?ISO-8859-1?Q?Cl=E9ment?= Vuchener <clement.vuchener@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hid/hid-corsair.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index bcefb9e..5855196 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -655,18 +655,7 @@ static struct hid_driver corsair_driver = {
 	.input_mapping = corsair_input_mapping,
 };
 
-static int __init corsair_init(void)
-{
-	return hid_register_driver(&corsair_driver);
-}
-
-static void corsair_exit(void)
-{
-	hid_unregister_driver(&corsair_driver);
-}
-
-module_init(corsair_init);
-module_exit(corsair_exit);
+module_hid_driver(corsair_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Clement Vuchener");
-- 
2.1.4



