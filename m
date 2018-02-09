From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 2/3] Input: gpio-keys - allow setting wakeup interrupt trigger type in DT
Date: Fri,  9 Feb 2018 19:55:09 +0800
Message-ID: <20180209115510.11868-3-jeffy.chen@rock-chips.com>
References: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180209115510.11868-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, dtor@google.com, dianders@google.com, Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

Allow specifying a different interrupt trigger type for wakeup when
using the gpio-keys input device as a wakeup source.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 Documentation/devicetree/bindings/input/gpio-keys.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a94940481e55..61926cef708f 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -26,6 +26,15 @@ Optional subnode-properties:
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
 			 (Legacy property supported: "gpio-key,wakeup")
+	- wakeup-trigger-type: Specifies the interrupt trigger type for wakeup.
+		 The value is defined in <dt-bindings/interrupt-controller/irq.h>
+		 Only the following flags are supported:
+			IRQ_TYPE_NONE
+			IRQ_TYPE_EDGE_RISING
+			IRQ_TYPE_EDGE_FALLING
+			IRQ_TYPE_EDGE_BOTH
+			IRQ_TYPE_LEVEL_HIGH
+			IRQ_TYPE_LEVEL_LOW
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
-- 
2.11.0
