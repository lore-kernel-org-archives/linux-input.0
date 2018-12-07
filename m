From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/8] Input: dt-bindings: tm2-touchkey: Add support for midas touchkey
Date: Fri,  7 Dec 2018 11:58:05 +0100
Message-ID: <20181207105811.1831-3-pawel.mikolaj.chmiel@gmail.com>
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

From: Simon Shields <simon@lineageos.org>

Document compatible for midas touchkey.

Signed-off-by: Simon Shields <simon@lineageos.org>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
index 0c252d9306da..dfb3b9f0ee40 100644
--- a/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
+++ b/Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
@@ -1,7 +1,9 @@
 Samsung tm2-touchkey
 
 Required properties:
-- compatible: must be "cypress,tm2-touchkey"
+- compatible:
+    * "cypress,tm2-touchkey" - for the touchkey found on the tm2 board
+    * "cypress,midas-touchkey" - for the touchkey found on midas boards
 - reg: I2C address of the chip.
 - interrupts: interrupt to which the chip is connected (see interrupt
 	binding[0]).
-- 
2.17.1
