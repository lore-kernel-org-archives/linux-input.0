From: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Subject: [PATCH 2/3] dt-bindings: Input: Add enable-gpios to pwm-beeper
Date: Thu,  5 Jan 2017 20:43:53 -0600
Message-ID: <1483670635-25060-3-git-send-email-david@lechnology.com>
References: <1483670635-25060-1-git-send-email-david@lechnology.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1483670635-25060-1-git-send-email-david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This adds an optional enable-gpios property to pwm-beeper. This gpio is
used to enable the beeper. For example, the beeper may have an amplifier
that needs to be switched on.

Signed-off-by: David Lechner <david-nq/r/kbU++upp/zk7JDF2g@public.gmane.org>
---
 Documentation/devicetree/bindings/input/pwm-beeper.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.txt b/Documentation/devicetree/bindings/input/pwm-beeper.txt
index be332ae..1c6bcf8 100644
--- a/Documentation/devicetree/bindings/input/pwm-beeper.txt
+++ b/Documentation/devicetree/bindings/input/pwm-beeper.txt
@@ -5,3 +5,14 @@ Registers a PWM device as beeper.
 Required properties:
 - compatible: should be "pwm-beeper"
 - pwms: phandle to the physical PWM device
+
+Optional properties:
+- enable-gpios: phandle to gpio to enable the beeper
+
+Example:
+
+beeper {
+	compatible = "pwm-beeper";
+	pwms = <&pwm0>;
+	enable-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+};
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
