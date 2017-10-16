From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4.14 REGRESSION fix] Input: axp20x-pek - Fix module not auto-loading for axp221 pek
Date: Mon, 16 Oct 2017 15:34:22 +0200
Message-ID: <20171016133422.14327-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752431AbdJPNe2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 16 Oct 2017 09:34:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>

Now that we have a platform_device_id table and multiple supported ids
we should be using MODULE_DEVICE_TABLE instead of MODULE_ALIAS.

This fixes a regression on Bay and Cherry Trail devices, where the power
button is now enumerated as an "axp221-pek" and it was impossible to
wakeup these devices from suspend since the module did not load.

Cc: Quentin Schulz <quentin.schulz@free-electrons.com>
Fixes: c3cc94470bd3 ("Input: axp20x-pek - add support for AXP221 PEK")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/axp20x-pek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 6cee5adc3b5c..debeeaeb8812 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -403,6 +403,7 @@ static const struct platform_device_id axp_pek_id_match[] = {
 	},
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
 
 static struct platform_driver axp20x_pek_driver = {
 	.probe		= axp20x_pek_probe,
@@ -417,4 +418,3 @@ module_platform_driver(axp20x_pek_driver);
 MODULE_DESCRIPTION("axp20x Power Button");
 MODULE_AUTHOR("Carlo Caione <carlo@caione.org>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:axp20x-pek");
-- 
2.14.2

