From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH V2 2/2] input: gpio-keys: add support to name the gpio-keys
Date: Wed, 13 Jan 2016 11:44:17 +0530
Message-ID: <1452665657-9412-2-git-send-email-ldewangan@nvidia.com>
References: <1452665657-9412-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452665657-9412-1-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, dmitry.torokhov@gmail.com, pawel.moll@arm.com, mark.rutland@arm.com
Cc: galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, Laxman Dewangan <ldewangan@nvidia.com>
List-Id: linux-input@vger.kernel.org

Add support from DT to name the gpio-keys driver to have
desired key name for this input system.

This helps userspace code to get name and perform proper
event to key mapping in some of cases. In android, the
user space map the key code to application code using
key character layout and for this it uses the name of
input system.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Use standard property "label" instead of custom property "gpio-keys,name"

 Documentation/devicetree/bindings/input/gpio-keys.txt | 1 +
 drivers/input/keyboard/gpio_keys.c                    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index cf1333d..f23bfa1 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -4,6 +4,7 @@ Required properties:
 	- compatible = "gpio-keys";
 
 Optional properties:
+	- label: String, name of the gpio-keys input system.
 	- autorepeat: Boolean, Enable auto repeat feature of Linux input
 	  subsystem.
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 08bada8..448f38f 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -628,6 +628,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
+	of_property_read_string(node, "label", &pdata->name);
+
 	i = 0;
 	for_each_child_of_node(node, pp) {
 		enum of_gpio_flags flags;
-- 
2.1.4
