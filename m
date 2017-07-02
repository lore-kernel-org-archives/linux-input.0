From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/5] HID: asus: Fix T100TA touchpad y dimensions
Date: Sun,  2 Jul 2017 16:34:13 +0200
Message-ID: <20170702143416.23643-3-hdegoede@redhat.com>
References: <20170702143416.23643-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751682AbdGBOeX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 2 Jul 2017 10:34:23 -0400
In-Reply-To: <20170702143416.23643-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

When adding the initial support I only looked at the maximum coordinates
but the Y axis is inverted, so I should have checked the minimum
coodinates which never reach 0 due to max_y being wrong, fix this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4632481c5ab7..4ff4add14974 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -107,7 +107,7 @@ static const struct asus_touchpad_info asus_i2c_tp = {
 
 static const struct asus_touchpad_info asus_t100ta_tp = {
 	.max_x = 2240,
-	.max_y = 1758,
+	.max_y = 1120,
 	.contact_size = 5,
 	.max_contacts = 5,
 };
-- 
2.13.0

