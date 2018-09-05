From: Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] input: keyboard: gpio-keys: Fixed a documentation index issue.
Date: Wed,  5 Sep 2018 12:13:47 +0800
Message-ID: <20180905041347.19986-1-songqiang.1304521@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Song Qiang <songqiang.1304521@gmail.com>
List-Id: linux-input@vger.kernel.org

gpio_keys.c now exists in the drivers/input/keyboard/ rather than
drivers/input/.

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 Documentation/devicetree/bindings/input/gpio-keys.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index 996ce84352cb..7cccc49b6bea 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -1,4 +1,4 @@
-Device-Tree bindings for input/gpio_keys.c keyboard driver
+Device-Tree bindings for input/keyboard/gpio_keys.c keyboard driver
 
 Required properties:
 	- compatible = "gpio-keys";
-- 
2.17.1
