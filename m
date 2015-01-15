From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2 1/2] DT: i2c: Deprecate adi,adxl34x compatible string
Date: Thu, 15 Jan 2015 16:54:14 +0200
Message-ID: <1421333655-31029-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1421333655-31029-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Geert Uytterhoeven <geert@glider.be>
List-Id: linux-input@vger.kernel.org

DT nodes should use the more specific adi,adxl345 and adi,adxl346
compatible values instead. As the ADXL346 is backward-compatible with
the ADXL345, ADXL346 nodes must list both adi,adxl346 and adi,adxl345,
in that order.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 9f41d05be3be..757e42510517 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -18,8 +18,7 @@ adi,adt7475		+/-1C TDM Extended Temp Range I.C
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
2.0.5

