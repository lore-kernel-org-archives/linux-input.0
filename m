From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 2/2] input: gpio-keys: add support to name the gpio-keys
Date: Tue, 12 Jan 2016 17:02:50 +0530
Message-ID: <1452598370-28509-2-git-send-email-ldewangan@nvidia.com>
References: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6031 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933396AbcALLnW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2016 06:43:22 -0500
In-Reply-To: <1452598370-28509-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, dmitry.torokhov@gmail.com
Cc: pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Laxman Dewangan <ldewangan@nvidia.com>

Add support from DT to name the gpio-keys driver to have
desired key name for this input system.

This helps userspace code to get name and perform proper
event to key mapping in some of cases. In android, the
user space map the key code to application code using
key character layout and for this it uses the name of
input system.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.txt | 1 +
 drivers/input/keyboard/gpio_keys.c                    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index cf1333d..2e6bcd2 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -4,6 +4,7 @@ Required properties:
 	- compatible = "gpio-keys";
 
 Optional properties:
+	- gpio-keys,name: String, name of the gpio-keys input system.
 	- autorepeat: Boolean, Enable auto repeat feature of Linux input
 	  subsystem.
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index cf068cb..c95dc3b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -628,6 +628,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
+	of_property_read_string(node, "gpio-keys,name", &pdata->name);
+
 	i = 0;
 	for_each_child_of_node(node, pp) {
 		enum of_gpio_flags flags;
-- 
2.1.4

