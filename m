From: Donghoon Han <nazgul33@gmail.com>
Subject: [PATCH V2 2/2] Input: rotaty-encoder - Add DT binding document
Date: Tue,  8 Jan 2019 01:42:49 +0900
Message-ID: <20190107164249.2342-3-nazgul33@gmail.com>
References: <20190107164249.2342-1-nazgul33@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107164249.2342-1-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add DT binding document for rotary-encoder, keycode options.

Signed-off-by: Donghoon Han <nazgul33@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>
Cc: devicetree@vger.kernel.org
To: linux-input@vger.kernel.org
---
 .../devicetree/bindings/input/rotary-encoder.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index f99fe5cdeaec..9986ec2af2d4 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -12,6 +12,10 @@ Optional properties:
 - rotary-encoder,relative-axis: register a relative axis rather than an
   absolute one. Relative axis will only generate +1/-1 events on the input
   device, hence no steps need to be passed.
+- rotary-encoder,relative-keys : generate pair of key events. This setting
+  behaves just like relative-axis, generating key events instead.
+  (Keycodes[2] corresponds to -1/1 events.)
+- rotary-encoder,relative-keycodes : keycodes for relative-keys
 - rotary-encoder,rollover: Automatic rollover when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,steps-per-period: Number of steps (stable states) per period.
@@ -48,3 +52,11 @@ Example:
 			rotary-encoder,encoding = "binary";
 			rotary-encoder,rollover;
 		};
+
+		rotary@2 {
+			compatible = "rotary-encoder";
+			gpios = <&gpio 21 0>, <&gpio 22 0>;
+			rotary-encoder,relative-keys;
+			rotary-encoder,relative-keycode = <103>, <108>;
+			rotary-encoder,steps-per-period = <2>;
+		};
-- 
2.17.1
