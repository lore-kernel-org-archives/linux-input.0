From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: [PATCH 2/2] ARM: dts: Add regulator-haptic device node for
 exynos3250-rinato
Date: Thu, 20 Nov 2014 22:31:40 +0900
Message-ID: <1416490300-28865-3-git-send-email-jaewon02.kim@samsung.com>
References: <1416490300-28865-1-git-send-email-jaewon02.kim@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:58085 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbaKTNc0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Nov 2014 08:32:26 -0500
In-reply-to: <1416490300-28865-1-git-send-email-jaewon02.kim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>

This patch adds regulator-haptic device node controlled by regulator.

Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
---
 arch/arm/boot/dts/exynos3250-rinato.dts |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 84380fa..8172815 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -104,6 +104,13 @@
 			};
 		};
 	};
+
+	regulator-haptic {
+		compatible = "regulator-haptic";
+		haptic-supply = <&motor_reg>;
+		min-microvolt = <1100000>;
+		max-microvolt = <2700000>;
+	};
 };
 
 &adc {
-- 
1.7.9.5

