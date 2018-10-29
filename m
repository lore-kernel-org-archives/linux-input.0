From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH v5 7/8] dt-bindings: watchdog: document stpmic1 pmic watchdog
Date: Mon, 29 Oct 2018 16:22:07 +0000
Message-ID: <1540830122-2577-8-git-send-email-p.paillet@st.com>
References: <1540830122-2577-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540830122-2577-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

The stpmic1 PMIC embeds a watchdog which is disabled by default.
In case of watchdog, the PMIC goes off.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes in v5: nothing

 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt b/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
new file mode 100644
index 0000000..7cc1407
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
@@ -0,0 +1,11 @@
+STMicroelectronics STPMIC1 Watchdog
+
+Required properties:
+
+- compatible : should be "st,stpmic1-wdt"
+
+Example:
+
+watchdog {
+	compatible = "st,stpmic1-wdt";
+};
-- 
1.9.1
