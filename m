From: Hans Verkuil <hansverk@cisco.com>
Subject: [PATCHv10 03/16] dts: exynos4412-odroid*: enable the HDMI CEC device
Date: Thu, 12 Nov 2015 13:21:32 +0100
Message-ID: <7ef1997ed75b7085261f46ee88d292099b4e2f15.1447329279.git.hansverk@cisco.com>
References: <cover.1447329279.git.hansverk@cisco.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1447329279.git.hansverk@cisco.com>
In-Reply-To: <cover.1447329279.git.hansverk@cisco.com>
References: <cover.1447329279.git.hansverk@cisco.com>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, lars@opdenkamp.eu, linux@arm.linux.org.uk, Kamil Debski <kamil@wypas.org>, Hans Verkuil <hans.verkuil@cisco.com>
List-Id: linux-input@vger.kernel.org

From: Kamil Debski <kamil@wypas.org>

Add a dts node entry and enable the HDMI CEC device present in the Exynos4
family of SoCs.

Signed-off-by: Kamil Debski <kamil@wypas.org>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index eb37952..5c4393d 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -222,6 +222,10 @@
 		enable-active-high;
 	};
 
+	cec@100B0000 {
+		status = "okay";
+	};
+
 	hdmi_ddc: i2c-ddc {
 		compatible = "i2c-gpio";
 		gpios = <&gpe4 2 0 &gpe4 3 0>;
-- 
2.6.2
