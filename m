From: David Lechner <david@lechnology.com>
Subject: [PATCH v2 2/3] dt-bindings: Input: Add optional amp-supply property to pwm-beeper
Date: Wed, 11 Jan 2017 14:02:00 -0600
Message-ID: <1484164921-30587-3-git-send-email-david@lechnology.com>
References: <1484164921-30587-1-git-send-email-david@lechnology.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:49955 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757355AbdAKUCT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Jan 2017 15:02:19 -0500
In-Reply-To: <1484164921-30587-1-git-send-email-david@lechnology.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org

This adds an optional amp-supply property to pwm-beeper. This is a
regulator that acts as an amplifier for the beeper.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/devicetree/bindings/input/pwm-beeper.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
index be332ae..529408b 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -5,3 +5,19 @@ Registers a PWM device as beeper.
 Required properties:
 - compatible: should be "pwm-beeper"
 - pwms: phandle to the physical PWM device
+
+Optional properties:
+- amp-supply: phandle to a regulator that acts as an amplifier for the beeper
+
+Example:
+
+beeper_amp: amplifier {
+	compatible = "fixed-regulator";
+	gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+};
+
+beeper {
+	compatible = "pwm-beeper";
+	pwms = <&pwm0>;
+	amp-supply = <&beeper_amp>;
+};
-- 
2.7.4

