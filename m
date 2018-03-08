From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v5 2/3] Input: gpio-keys - allow setting wakeup event action in DT
Date: Thu,  8 Mar 2018 15:32:12 +0800
Message-ID: <20180308073213.8419-3-jeffy.chen@rock-chips.com>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: briannorris@google.com, heiko@sntech.de, dtor@google.com, dianders@google.com, Jeffy Chen <jeffy.chen@rock-chips.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

Allow specifying event actions to trigger wakeup when using the
gpio-keys input device as a wakeup source.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
Specify wakeup event action instead of irq trigger type as Brian
suggested.

 Documentation/devicetree/bindings/input/gpio-keys.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index a94940481e55..996ce84352cb 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -26,6 +26,14 @@ Optional subnode-properties:
 	  If not specified defaults to 5.
 	- wakeup-source: Boolean, button can wake-up the system.
 			 (Legacy property supported: "gpio-key,wakeup")
+	- wakeup-event-action: Specifies whether the key should wake the
+	  system when asserted, when deasserted, or both. This property is
+	  only valid for keys that wake up the system (e.g., when the
+	  "wakeup-source" property is also provided).
+	  Supported values are defined in linux-event-codes.h:
+		EV_ACT_ASSERTED		- asserted
+		EV_ACT_DEASSERTED	- deasserted
+		EV_ACT_ANY		- both asserted and deasserted
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
-- 
2.11.0
