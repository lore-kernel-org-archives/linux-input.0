From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH v6 2/2] ARM: dts: Add haptic node for exynos3250-rinato
Date: Fri, 12 Dec 2014 19:32:29 +0900
Message-ID: <1418380349-32588-3-git-send-email-jaewon02.kim@samsung.com>
References: <1418380349-32588-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:63561 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933474AbaLLKcj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Dec 2014 05:32:39 -0500
In-reply-to: <1418380349-32588-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Jaewon Kim <jaewon02.kim@samsung.com>

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

