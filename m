From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH v5 4/6] dt-bindings: mfd: Add bindings for the keys as subnode of PMIC
Date: Wed, 27 Sep 2017 18:44:06 +0800
Message-ID: <1506509048-19032-5-git-send-email-chen.zhong@mediatek.com>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Eddie Huang <eddie.huang@mediatek.com>, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Chen Zhong <chen.zhong@mediatek.com>, Jaechul Lee <jcsing.lee@samsung.com>, Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch adds documentation for device tree bindings for keys support
as the subnode of MT6397/MT6323 PMIC.

Acked-by: Rob Herring <robh@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 Documentation/devicetree/bindings/mfd/mt6397.txt |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
index 522a3bb..d1df77f 100644
--- a/Documentation/devicetree/bindings/mfd/mt6397.txt
+++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
@@ -7,6 +7,7 @@ MT6397/MT6323 is a multifunction device with the following sub modules:
 - GPIO
 - Clock
 - LED
+- Keys
 
 It is interfaced to host controller using SPI interface by a proprietary hardware
 called PMIC wrapper or pwrap. MT6397/MT6323 MFD is a child device of pwrap.
@@ -40,6 +41,11 @@ Optional subnodes:
 		- compatible: "mediatek,mt6323-led"
 	see Documentation/devicetree/bindings/leds/leds-mt6323.txt
 
+- keys
+	Required properties:
+		- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+	see Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+
 Example:
 	pwrap: pwrap@1000f000 {
 		compatible = "mediatek,mt8135-pwrap";
-- 
1.7.9.5
