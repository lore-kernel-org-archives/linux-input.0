From: Pascal PAILLET-LME <p.paillet@st.com>
Subject: [PATCH 7/8] dt-bindings: watchdog: document stpmu1 pmic watchdog
Date: Thu, 5 Jul 2018 15:14:25 +0000
Message-ID: <1530803657-17684-8-git-send-email-p.paillet@st.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530803657-17684-1-git-send-email-p.paillet@st.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Cc: Pascal PAILLET-LME <p.paillet@st.com>
List-Id: linux-input@vger.kernel.org

From: pascal paillet <p.paillet@st.com>

The stpmu1 PMIC embeds a watchdog which is disabled by default.
In case of watchdog, the PMIC goes off.

Signed-off-by: pascal paillet <p.paillet@st.com>
---
 Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt b/Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt
new file mode 100644
index 0000000..b558b3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/st,stpmu1-wdt.txt
@@ -0,0 +1,11 @@
+STMicroelectronics STPMU1 Watchdog
+
+Required properties:
+
+- compatible : should be "st,stpmu1-wdt"
+
+Example:
+
+watchdog {
+	compatible = "st,stpmu1-wdt";
+};
-- 
1.9.1
