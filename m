From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH RESEND 2/2] ARM: dts: exynos3250-monk: Add regulator-haptic
 node for haptics
Date: Wed, 21 Jan 2015 16:56:00 +0900
Message-ID: <1421826960-26491-3-git-send-email-jaewon02.kim@samsung.com>
References: <1421826960-26491-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26558 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbbAUH4W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2015 02:56:22 -0500
In-reply-to: <1421826960-26491-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>

This patch adds regulator-haptic device node controlled by regulator.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos3250-monk.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
index 24822aa..7102d88 100644
--- a/arch/arm/boot/dts/exynos3250-monk.dts
+++ b/arch/arm/boot/dts/exynos3250-monk.dts
@@ -109,6 +109,13 @@
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

