From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] input: soc_button_array: Properly map usage-page 7 usage 0xe3 to KEY_LEFTMETA
Date: Mon, 10 Apr 2017 21:36:45 +0200
Message-ID: <20170410193645.9797-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752777AbdDJTgs (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 15:36:48 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, russianneuromancer@ya.ru

When submitting the support for the ACPI0011 windows tablet keys device
I mapped the "windows" logo homekey to KEY_HOMEPAGE. But this is
inconsistent with how it is done on windows tablets using the
old PNP0C40 ACPI device and it does not match the Hut spec, which says
that usage-page 7 usage 0xe3 is "Keyboard Left GUI".

This commit maps usage-page 7 usage 0xe3 to KEY_LEFTMETA fixing this.

Cc: russianneuromancer@ya.ru
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index d75a8a3..e1d42f1 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -187,7 +187,7 @@ static int soc_button_parse_btn_desc(struct device *dev,
 		info->wakeup = true;
 	} else if (upage == 0x07 && usage == 0xe3) {
 		info->name = "home";
-		info->event_code = KEY_HOMEPAGE;
+		info->event_code = KEY_LEFTMETA;
 		info->wakeup = true;
 	} else if (upage == 0x0c && usage == 0xe9) {
 		info->name = "volume_up";
-- 
2.9.3

