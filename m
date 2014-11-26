From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v3 2/2] ARM: dts: Add regulator-haptic device node for
 exynos3250-rinato
Date: Wed, 26 Nov 2014 22:30:02 +0900
Message-ID: <1417008602-22841-3-git-send-email-jaewon02.kim@samsung.com>
References: <1417008602-22841-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1417008602-22841-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Pankaj Dubey <pankaj.dubey@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

This patch adds regulator-haptic device node controlled by regulator.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 84380fa..da03005 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -104,6 +104,13 @@
 			};
 		};
 	};
+
+	haptics {
+		compatible = "regulator-haptic";
+		haptic-supply = <&motor_reg>;
+		min-microvolt = <1100000>;
+		max-microvolt = <2700000>;
+	};
 };
 
 &adc {
-- 
1.7.9.5
