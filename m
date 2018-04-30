From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 3/9] dt-bindings: input: touchscreen: add pressure
 threshold touchscreen property
Date: Mon, 30 Apr 2018 13:32:09 +0300
Message-ID: <1525084335-11276-4-git-send-email-eugen.hristev@microchip.com>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jic23@kernel.org, ludovic.desroches@microchip.com, alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, nicolas.ferre@microchip.com, dmitry.torokhov@gmail.com, robh@kernel.org
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add a common touchscreen optional property that will specify
the minimum pressure applied to the screen that is needed
such that the driver will report the touch event.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
index 537643e..c84047a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
@@ -7,6 +7,9 @@ Optional properties for Touchscreens:
 				  (in pixels)
  - touchscreen-max-pressure	: maximum reported pressure (arbitrary range
 				  dependent on the controller)
+ - touchscreen-threshold-pressure: minimum pressure on the touchscreen to be
+				  achieved in order for the touchscreen
+				  driver to report a touch event.
  - touchscreen-fuzz-x		: horizontal noise value of the absolute input
 				  device (in pixels)
  - touchscreen-fuzz-y		: vertical noise value of the absolute input
-- 
2.7.4
