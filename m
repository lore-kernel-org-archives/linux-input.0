From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/3] dt-bindings: input: sitronix-st1232: add compatible string for ST1633
Date: Mon, 28 Jan 2019 09:44:47 +0100
Message-ID: <20190128084449.16070-1-martink@posteo.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

From: Martin Kepplinger <martin.kepplinger@ginzinger.com>

The st1232 driver gains support for the ST1633 controller too; update
the bindings doc accordingly.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 .../bindings/input/touchscreen/sitronix-st1232.txt          | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
index 64ad48b824a2..e73e826e0f2a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
@@ -1,7 +1,9 @@
-* Sitronix st1232 touchscreen controller
+* Sitronix st1232 or st1633 touchscreen controller
 
 Required properties:
-- compatible: must be "sitronix,st1232"
+- compatible: must contain one of
+  * "sitronix,st1232"
+  * "sitronix,st1633"
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
 
-- 
2.20.1
