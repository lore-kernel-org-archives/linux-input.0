From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V3 1/1] input: gpio-keys: add support for disable button from DT
Date: Wed, 13 Jan 2016 12:56:20 +0530
Message-ID: <1452669980-16460-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com
Cc: galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-input@vger.kernel.org

Add support to disable the button from DT via status property
if given button is not supporting on given platforms.

This will help to re-use the existing dtsi file with status
enable/disable across platforms.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1: 
- Converted print to dev_dbg.
Changes from V2:
- use of_get_available_child_count() and for_each_available_child_of_node()

 drivers/input/keyboard/gpio_keys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index bef317f..ef6ca1c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -613,7 +613,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	nbuttons = of_get_child_count(node);
+	nbuttons = of_get_available_child_count(node);
 	if (nbuttons == 0)
 		return ERR_PTR(-ENODEV);
 
@@ -629,7 +629,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
 	i = 0;
-	for_each_child_of_node(node, pp) {
+	for_each_available_child_of_node(node, pp) {
 		enum of_gpio_flags flags;
 
 		button = &pdata->buttons[i++];
-- 
2.1.4
