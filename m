From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 6/8] Input: dt-bindings: tm2-touchkey: Document new keycodes property
Date: Fri,  7 Dec 2018 11:58:09 +0100
Message-ID: <20181207105811.1831-7-pawel.mikolaj.chmiel@gmail.com>
References: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181207105811.1831-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Document new optional property for setting custom keycodes.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index dfb3b9f0ee40..3b54d997b8de 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -10,6 +10,9 @@ Required properties:
 - vcc-supply : internal regulator output. 1.8V
 - vdd-supply : power supply for IC 3.3V
 
+Optional properties:
+- keycodes: array of keycodes (max 4), default KEY_PHONE and KEY_BACK
+
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Example:
@@ -23,5 +26,6 @@ Example:
 			interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
 			vcc-supply=<&ldo32_reg>;
 			vdd-supply=<&ldo33_reg>;
+			keycodes = /bits/ 8 <KEY_PHONE KEY_BACK>;
 		};
 	};
-- 
2.17.1
