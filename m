From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 09/12] Input: cros_ec_keyb - Make license text and module license match.
Date: Wed,  6 Jun 2018 17:08:57 +0200
Message-ID: <20180606150900.8342-10-enric.balletbo@collabora.com>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606150900.8342-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
boiler plate does not match, go for boiler plate license.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 drivers/input/keyboard/cros_ec_keyb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 79eb29550c34..9dd8c146699f 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -674,6 +674,6 @@ static struct platform_driver cros_ec_keyb_driver = {
 
 module_platform_driver(cros_ec_keyb_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("ChromeOS EC keyboard driver");
 MODULE_ALIAS("platform:cros-ec-keyb");
-- 
2.17.1
