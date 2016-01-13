From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 1/2] input: gpio-keys: add support for disable button from DT
Date: Wed, 13 Jan 2016 11:44:16 +0530
Message-ID: <1452665657-9412-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12060 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbcAMGYj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 01:24:39 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com
Cc: galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, Laxman Dewangan <ldewangan@nvidia.com>

Add support to disable the button from DT via status property
if given button is not supporting on given platforms.

This will help to re-use the existing dtsi file with status
enable/disable across platforms.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Converted print to dev_dbg.

 drivers/input/keyboard/gpio_keys.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index bef317f..08bada8 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -632,6 +632,14 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	for_each_child_of_node(node, pp) {
 		enum of_gpio_flags flags;
 
+		/* Ignore the button if status of node is disabled */
+		error = of_device_is_available(pp);
+		if (!error) {
+			dev_dbg(dev, "Button %s is ignored\n", pp->name);
+			pdata->nbuttons--;
+			continue;
+		}
+
 		button = &pdata->buttons[i++];
 
 		button->gpio = of_get_gpio_flags(pp, 0, &flags);
-- 
2.1.4

