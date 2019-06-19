From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v4 3/7] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Wed, 19 Jun 2019 16:20:09 +0200
Message-ID: <20190619142013.20913-4-fparent@baylibre.com>
References: <20190619142013.20913-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190619142013.20913-1-fparent@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com, lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v4:

	* Patch was previously sent separately but merge to this patch series
	  since there is a hard dependency on the MFD patch.

---
 .../devicetree/bindings/input/mtk-pmic-keys.txt       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 2888d07c2ef0..858f78e7262c 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -1,15 +1,18 @@
-MediaTek MT6397/MT6323 PMIC Keys Device Driver
+MediaTek MT6397/MT6392/MT6323 PMIC Keys Device Driver
 
-There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
+There are two key functions provided by MT6397/MT6392/MT6323 PMIC, pwrkey
 and homekey. The key functions are defined as the subnode of the function
 node provided by MT6397/MT6323 PMIC that is being defined as one kind
 of Muti-Function Device (MFD)
 
-For MT6397/MT6323 MFD bindings see:
+For MT6397/MT6392/MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6397-keys"
+	- "mediatek,mt6392-keys"
+	- "mediatek,mt6323-keys"
 - linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
 
 Optional Properties:
-- 
2.20.1
