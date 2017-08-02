From: Chen Zhong <chen.zhong@mediatek.com>
Subject: [PATCH 1/4] dt-bindings: input: Add document bindings for
 mtk-pmic-keys
Date: Wed, 2 Aug 2017 11:17:17 +0800
Message-ID: <1501643840-21485-2-git-send-email-chen.zhong@mediatek.com>
References: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1501643840-21485-1-git-send-email-chen.zhong@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

This patch adds the device tree binding documentation for the MediaTek
pmic keys found on PMIC MT6397/MT6323.

Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
---
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
new file mode 100644
index 0000000..c5b230f
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -0,0 +1,36 @@
+MediaTek MT6397/MT6323 PMIC Keys Device Driver
+
+There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
+and homekey. The key functions are defined as the subnode of the function
+node provided by MT6397/MT6323 PMIC that is being defined as one kind
+of Muti-Function Device (MFD)
+
+For MT6397/MT6323 MFD bindings see:
+Documentation/devicetree/bindings/mfd/mt6397.txt
+
+Required properties:
+- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- mediatek,pwrkey-code: Keycode of pwrkey
+
+Optional Properties:
+- mediatek,homekey-code: Keycode of homekey
+- mediatek,long-press-mode: Long press key shutdown setting, 1 for
+	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
+- mediatek,long-press-duration: Long press key shutdown duration setting,
+	0/1/2/3 for 8/11/14/5 seconds.
+
+Example:
+
+	pmic: mt6397 {
+		compatible = "mediatek,mt6397";
+
+		...
+
+		mt6397keys: mt6397keys {
+			compatible = "mediatek,mt6397-keys";
+			mediatek,pwrkey-code = <116>;
+			mediatek,homekey-code = <114>;
+			mediatek,long-press-mode = <1>;
+			mediatek,long-press-duration = <0>;
+		};
+	};
\ No newline at end of file
-- 
1.7.9.5
