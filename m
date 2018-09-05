From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 2/2] dt-bindings: egalax-ts: add support for wakeup event action
Date: Wed,  5 Sep 2018 17:26:47 +0800
Message-ID: <1536139607-16848-2-git-send-email-Anson.Huang@nxp.com>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, marco.franchi@nxp.com, fabio.estevam@nxp.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linux-imx@nxp.com
List-Id: linux-input@vger.kernel.org

Add support for wakeup event action, this would allow the device
to configure whether to be a wakeup source of system suspend.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
index 92fb262..296a9cd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
@@ -6,6 +6,7 @@ Required properties:
 - interrupts: touch controller interrupt
 - wakeup-gpios: the gpio pin to be used for waking up the controller
   and also used as irq pin
+- wakeup-source: boolean, touch screen can wake-up the system
 
 Example:
 
@@ -15,4 +16,5 @@ Example:
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 2>;
 		wakeup-gpios = <&gpio1 9 0>;
+		wakeup-source;
 	};
-- 
2.7.4
