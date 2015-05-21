From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 21 May 2015 13:42:25 +0200
Message-ID: <1432208546-18615-2-git-send-email-geert+renesas@glider.be>
References: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

DT nodes should use the more specific adi,adxl345 and adi,adxl346
compatible values instead. As the ADXL346 is backward-compatible with
the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
in that order.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add Acked-by.

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad0c4ac916dd75ed..00f8652e193a940c 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -19,8 +19,7 @@ adi,adt7475		+/-1C TDM Extended Temp Range I.C
 adi,adt7476		+/-1C TDM Extended Temp Range I.C
 adi,adt7490		+/-1C TDM Extended Temp Range I.C
 adi,adxl345		Three-Axis Digital Accelerometer
-adi,adxl346		Three-Axis Digital Accelerometer
-adi,adxl34x		Three-Axis Digital Accelerometer
+adi,adxl346		Three-Axis Digital Accelerometer (backward-compatibility value "adi,adxl345" must be listed too)
 at,24c08		i2c serial eeprom  (24cxx)
 atmel,24c00		i2c serial eeprom  (24cxx)
 atmel,24c01		i2c serial eeprom  (24cxx)
-- 
1.9.1

