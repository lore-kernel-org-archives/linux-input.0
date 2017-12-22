From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 03/14] dt-bindings: iio: add binding support for iio trigger
 provider/consumer
Date: Fri, 22 Dec 2017 17:07:10 +0200
Message-ID: <1513955241-10985-4-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add bindings for producer/consumer for iio triggers.

Similar with iio channels, the iio triggers can be connected between drivers:
one driver will be a producer by registering iio triggers, and another driver
will connect as a consumer.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 .../devicetree/bindings/iio/iio-bindings.txt       | 52 +++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/iio-bindings.txt b/Documentation/devicetree/bindings/iio/iio-bindings.txt
index 68d6f8c..d861f0df 100644
--- a/Documentation/devicetree/bindings/iio/iio-bindings.txt
+++ b/Documentation/devicetree/bindings/iio/iio-bindings.txt
@@ -11,6 +11,10 @@ value of a #io-channel-cells property in the IIO provider node.
 
 [1] http://marc.info/?l=linux-iio&m=135902119507483&w=2
 
+Moreover, the provider can have a set of triggers that can be attached to
+from the consumer drivers.
+
+
 ==IIO providers==
 
 Required properties:
@@ -18,6 +22,11 @@ Required properties:
 		   with a single IIO output and 1 for nodes with multiple
 		   IIO outputs.
 
+Optional properties:
+#io-trigger-cells: Number of cells for the IIO trigger specifier. Typically 0
+		   for nodes with a single IIO trigger and 1 for nodes with
+		   multiple IIO triggers.
+
 Example for a simple configuration with no trigger:
 
 	adc: voltage-sensor@35 {
@@ -26,7 +35,7 @@ Example for a simple configuration with no trigger:
 		#io-channel-cells = <1>;
 	};
 
-Example for a configuration with trigger:
+Example for a configuration with channels provided by trigger:
 
 	adc@35 {
 		compatible = "some-vendor,some-adc";
@@ -42,6 +51,17 @@ Example for a configuration with trigger:
 		};
 	};
 
+Example for a configuration for a trigger provider:
+
+	adc: sensor-with-trigger@35 {
+		compatible = "some-vendor,some-adc";
+		reg = <0x35>;
+		#io-channel-cells = <1>;
+		#io-trigger-cells = <1>;
+		/* other properties */
+	};
+
+
 ==IIO consumers==
 
 Required properties:
@@ -61,16 +81,38 @@ io-channel-ranges:
 		IIO channels from this node. Useful for bus nodes to provide
 		and IIO channel to their children.
 
+io-triggers:	List of phandle and IIO specifier pairs, one pair
+		for each trigger input to the device. Note: if the
+		IIO trigger provider specifies '0' for #io-trigger-cells,
+		then only the phandle portion of the pair will appear.
+
+io-trigger-names:
+		List of IIO trigger input name strings sorted in the same
+		order as the io-triggers property. Consumers drivers
+		will use io-trigger-names to match IIO trigger input names
+		with IIO specifiers.
+
+io-trigger-ranges:
+		Empty property indicating that child nodes can inherit named
+		IIO triggers from this node. Useful for bus nodes to provide
+		IIO triggers to their children.
+
 For example:
 
 	device {
 		io-channels = <&adc 1>, <&ref 0>;
 		io-channel-names = "vcc", "vdd";
+		io-triggers = <&adc 0>, <&adc 1>;
+		io-trigger-names = "continuous", "external";
 	};
 
 This represents a device with two IIO inputs, named "vcc" and "vdd".
 The vcc channel is connected to output 1 of the &adc device, and the
 vdd channel is connected to output 0 of the &ref device.
+The device also connects to two IIO trigger inputs, named "continuous" and
+"external". The continuous trigger is connected to the trigger output 0 of the
+&adc device, and the external trigger is connected to the trigger output 1 of
+the same &adc device.
 
 ==Example==
 
@@ -78,6 +120,7 @@ vdd channel is connected to output 0 of the &ref device.
 		compatible = "maxim,max1139";
 		reg = <0x35>;
 		#io-channel-cells = <1>;
+		#io-trigger-cells = <1>;
 	};
 
 	...
@@ -94,4 +137,11 @@ vdd channel is connected to output 0 of the &ref device.
 		compatible = "some-consumer";
 		io-channels = <&adc 10>, <&adc 11>;
 		io-channel-names = "adc1", "adc2";
+		io-triggers = <&adc 0>;
+	};
+
+	some_other_consumer {
+		compatible = "some-other-consumer";
+		io-triggers = <&adc 1>, <&adc 2>;
+		io-trigger-names = "edge-triggered", "pwm-generated";
 	};
-- 
2.7.4
