From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property
Date: Mon,  6 Jul 2015 12:55:32 +0200
Message-ID: <1436180132-26190-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

Replace the deprecated generic "adi,adxl34x" compatible value by the
adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
i2c: Deprecate adi,adxl34x compatible string").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
support"), which is in v4.2-rc1.

This is v2 of "ARM: shmobile: kzm9g dts: Add adxl345-specific compatible
property".

v2:
  - Drop deprecated "adi,adxl34x"
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 24b4cd24dceb2f9e..7fc5602810ad0da1 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -206,7 +206,7 @@
 	};
 
 	accelerometer@1d {
-		compatible = "adi,adxl34x";
+		compatible = "adi,adxl345";
 		reg = <0x1d>;
 		interrupt-parent = <&irqpin3>;
 		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1

