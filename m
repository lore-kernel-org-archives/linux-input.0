From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH v3 2/3] input: pwm-beeper: add documentation for volume devicetree bindings
Date: Thu, 19 Jan 2017 16:24:09 +0100
Message-ID: <48a18fbdabcce57ee8efa57b9b6033d1462ab492.1484838551.git.frieder.schrempf@exceet.de>
References: <cover.1484838551.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1484838551.git.frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
To: robh@kernel.org
Cc: dmitry.torokhov@gmail.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, luis@debethencourt.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@exceet.de>
List-Id: linux-input@vger.kernel.org

This patch adds the documentation for the devicetree bindings to set
the volume levels.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
Changes in v3:
 - change description of volume-levels to be used for linear levels
 
 .../devicetree/bindings/input/pwm-beeper.txt         | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
index be332ae..496b68f 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -5,3 +5,23 @@ Registers a PWM device as beeper.
 Required properties:
 - compatible: should be "pwm-beeper"
 - pwms: phandle to the physical PWM device
+
+Optional properties:
+- volume-levels: Array of PWM duty cycle values that correspond to
+      linear volume levels. These need to be in the range of 0 to 500,
+      while 0 means 0% duty cycle (mute) and 500 means 50% duty cycle
+      (max volume).
+      Please note that the actual volume of most beepers is highly
+      non-linear, which means that low volume levels are probably somewhere
+      in the range of 1 to 30 (0.1-3% duty cycle).
+- default-volume-level: the default volume level (index into the
+      array defined by the "volume-levels" property)
+
+Example:
+
+	pwm-beeper {
+		compatible = "pwm-beeper";
+		pwms = <&pwm4 0 5000>;
+		volume-levels = <0 8 20 40 500>;
+		default-volume-level = <4>;
+	};
-- 
2.7.4
