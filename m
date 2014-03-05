From: Gabriel FERNANDEZ <gabriel.fernandez@st.com>
Subject: [PATCH 4/5] ARM: STi: DT: add keyscan for stih41x-b2000
Date: Wed,  5 Mar 2014 04:39:31 +0100
Message-ID: <1393990772-9567-5-git-send-email-gabriel.fernandez@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, kernel@stlinux.com, Lee Jones <lee.jones@linaro.org>, Gabriel Fernandez <gabriel.fernandez@st.com>, Giuseppe Condorelli <giuseppe.condorelli@st.com>
List-Id: linux-input@vger.kernel.org

Add keyscan setup for stih415/h416 b2000.
Both have same raw/column lines number, debounce time and keymap.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 arch/arm/boot/dts/stih41x-b2000.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
index 1e6aa92..cf06beb 100644
--- a/arch/arm/boot/dts/stih41x-b2000.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
@@ -6,6 +6,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * publishhed by the Free Software Foundation.
  */
+#include <dt-bindings/input/input.h>
 / {
 
 	memory{
@@ -46,5 +47,16 @@
 
 			status = "okay";
 		};
+
+		keyscan: keyscan@fe4b0000 {
+			keypad,num-rows = <4>;
+			keypad,num-columns = <4>;
+			st,debounce_us = <5000>;
+			linux,keymap = < /* in0	in1	in2	in3 */
+				KEY_F13 KEY_F9  KEY_F5 KEY_F1		/* out0 */
+				KEY_F14 KEY_F10 KEY_F6 KEY_F2		/* out1 */
+				KEY_F15 KEY_F11 KEY_F7 KEY_F3		/* out2 */
+				KEY_F16 KEY_F12 KEY_F8 KEY_F4 >;	/* out3 */
+		};
 	};
 };
-- 
1.9.0
