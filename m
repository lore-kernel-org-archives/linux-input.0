From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v3 2/3] dt-bindings: input: Refer to touchscreen.txt for goodix ts
Date: Fri, 15 Feb 2019 15:11:52 +0100
Message-ID: <99085b90c327193f6bdb9b0a505daa6a9848e1c6.1550239328.git.agx@sigxcpu.org>
References: <cover.1550239328.git.agx@sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1550239328.git.agx@sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, Matthias Brugger <matthias.bgg@gmail.com>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Refer to touchscreen.txt for generic touch properties. This avoids
duplication and we're using the generic code to parse these in the
driver. While at that add touchscreen-size-{x,y} which are respected by
the driver as well.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../bindings/input/touchscreen/goodix.txt           | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 57d3d8870a09..8cf0b4d38a7e 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -19,11 +19,14 @@ Optional properties:
  - irq-gpios		: GPIO pin used for IRQ. The driver uses the
 			  interrupt gpio pin as output to reset the device.
  - reset-gpios		: GPIO pin used for reset
-
- - touchscreen-inverted-x  : X axis is inverted (boolean)
- - touchscreen-inverted-y  : Y axis is inverted (boolean)
- - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
-                             (swapping is done after inverting the axis)
+ - touchscreen-inverted-x
+ - touchscreen-inverted-y
+ - touchscreen-size-x
+ - touchscreen-size-y
+ - touchscreen-swapped-x-y
+
+The touchscreen-* properties are documented in touchscreen.txt in this
+directory.
 
 Example:
 
-- 
2.20.1
