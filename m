From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] Input: soc_button_array - Silence -ENOENT error on Dell XPS13 9365
Date: Sun, 20 Aug 2017 11:42:21 +0200
Message-ID: <20170820094221.7629-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbdHTJmY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 20 Aug 2017 05:42:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

The Dell XPS13 9365 has an INT33D2 ACPI node with no GPIOs, causing
the following error in dmesg:

[    7.172275] soc_button_array: probe of INT33D2:00 failed with error -2

This commit silences this, by returning -ENODEV when there are no GPIOs.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=196679
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 27b99831cb97..0f7cce70f748 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -334,7 +334,7 @@ static int soc_button_probe(struct platform_device *pdev)
 	error = gpiod_count(dev, NULL);
 	if (error < 0) {
 		dev_dbg(dev, "no GPIO attached, ignoring...\n");
-		return error;
+		return -ENODEV;
 	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-- 
2.13.4

