From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: shmobile: kzm9g dts: Add adxl345-specific compatible property
Date: Mon,  6 Jul 2015 11:59:06 +0200
Message-ID: <1436176746-10995-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

The accelerometer node used the generic compatible property only.
Add the device-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Depends on commit 3a38958d2477b718 ("Input: adxl34x - add OF match
support"), which is in v4.2-rc1.
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 24b4cd24dceb2f9e..ae91278d77b45b38 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -206,7 +206,7 @@
 	};
 
 	accelerometer@1d {
-		compatible = "adi,adxl34x";
+		compatible = "adi,adxl345", "adi,adxl34x";
 		reg = <0x1d>;
 		interrupt-parent = <&irqpin3>;
 		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1

