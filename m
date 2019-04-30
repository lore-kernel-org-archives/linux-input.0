From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 2/2] Input: edt-ft5x06 - add support for polled configuration
Date: Tue, 30 Apr 2019 20:58:59 +0200
Message-ID: <20190430185859.24015-2-nsaenzjulienne@suse.de>
References: <20190430185859.24015-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430185859.24015-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some devices might not provide an interrupt line for the touchscreen.
In that case the driver defaults to using a polled interface.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../devicetree/bindings/input/touchscreen/edt-ft5x06.txt  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 870b8c5cce9b..2605994a1257 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -24,10 +24,14 @@ Required properties:
            or:  "focaltech,ft6236"
 
  - reg:         I2C slave address of the chip (0x38)
- - interrupts:       interrupt specification for the touchdetect
-                     interrupt
 
 Optional properties:
+- interrupts: interrupt specification for the touchdetect interrupt, if not
+	      supplied the driver will deafult to polling.
+
+- poll-interval: Poll interval time in milliseconds, only relevant if no
+		 interrupt was provided.
+
  - reset-gpios: GPIO specification for the RESET input
  - wake-gpios:  GPIO specification for the WAKE input
 
-- 
2.21.0
