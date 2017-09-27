From: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v5 3/6] dt-bindings: input: Add document bindings for mtk-pmic-keys
Date: Wed, 27 Sep 2017 18:44:05 +0800
Message-ID: <1506509048-19032-4-git-send-email-chen.zhong@mediatek.com>
References: <1506509048-19032-1-git-send-email-chen.zhong@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1506509048-19032-1-git-send-email-chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This patch adds the device tree binding documentation for the MediaTek
pmic keys found on PMIC MT6397/MT6323.

Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |   43 ++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
new file mode 100644
index 0000000..2888d07
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -0,0 +1,43 @@
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
+- linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
+
+Optional Properties:
+- wakeup-source: See Documentation/devicetree/bindings/power/wakeup-source.txt
+- mediatek,long-press-mode: Long press key shutdown setting, 1 for
+	pwrkey only, 2 for pwrkey/homekey together, others for disabled.
+- power-off-time-sec: See Documentation/devicetree/bindings/input/keys.txt
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
+			mediatek,long-press-mode = <1>;
+			power-off-time-sec = <0>;
+
+			power {
+				linux,keycodes = <116>;
+				wakeup-source;
+			};
+
+			home {
+				linux,keycodes = <114>;
+			};
+		};
+
+	};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
