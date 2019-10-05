From: Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 1/3] dt-bindings: input: Add DT bindings for Whiskers switch
Date: Sat,  5 Oct 2019 18:13:45 +0800
Message-ID: <20191005101345.146460-1-ikjn@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Guenter Roeck <groeck@chromium.org>, Brian Norris <briannorris@chromium.org>, Enrico Granata <egranata@google.com>, Ting Shen <phoenixshen@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>, Ikjoon Jang <ikjn@chromium.org>
List-Id: linux-input@vger.kernel.org

Add the DT binding document for Hammer's TABLET_MODE switch.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 .../devicetree/bindings/input/cros-cbas.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cros-cbas.yaml

diff --git a/Documentation/devicetree/bindings/input/cros-cbas.yaml b/Documentation/devicetree/bindings/input/cros-cbas.yaml
new file mode 100644
index 000000000000..3bc989c6a295
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/cros-cbas.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/cros-cbas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS Hammer's Base Attached Switch
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+description:
+  This device is used to signal when a detachable base is attached to a
+  Chrome OS tablet. The node for this device must be under a cros-ec node
+  like google,cros-ec-spi or google,cros-ec-i2c.
+
+properties:
+  compatible:
+    const: google,cros-cbas
+
+required:
+  - compatible
-- 
2.23.0.581.g78d2f28ef7-goog
