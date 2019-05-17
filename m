From: Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 2/2] dt-bindings: input: Add wakeup-source for atmel,maxtouch
Date: Fri, 17 May 2019 23:17:41 +0200
Message-ID: <20190517211741.8906-2-stefano.manni@gmail.com>
References: <20190517211741.8906-1-stefano.manni@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190517211741.8906-1-stefano.manni@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Stefano Manni <stefano.manni@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add wakeup support to the maxtouch driver.

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
index c88919480d37..7491a8843c85 100644
--- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
+++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
@@ -31,6 +31,10 @@ Optional properties for main touchpad device:
 
 - reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
 
+- wakeup-source: use any event on touchscreen as wakeup event.
+    (Legacy property support: "linux,wakeup")
+
+
 Example:
 
 	touch@4b {
@@ -38,4 +42,5 @@ Example:
 		reg = <0x4b>;
 		interrupt-parent = <&gpio>;
 		interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_LOW>;
+		wakeup-source;
 	};
-- 
2.20.1
