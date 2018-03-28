From: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 1/4] dt-bindings: mfd: Add Gateworks System Controller
 bindings
Date: Wed, 28 Mar 2018 08:14:00 -0700
Message-ID: <1522250043-8065-2-git-send-email-tharvey@gateworks.com>
References: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1522250043-8065-1-git-send-email-tharvey@gateworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

This patch adds documentation of device-tree bindings for the
Gateworks System Controller (GSC).

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3:
 - replaced _ with -
 - remove input bindings
 - added full description of hwmon
 - fix unit address of hwmon child nodes

---
 .../devicetree/bindings/mfd/gateworks-gsc.txt      | 135 +++++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.txt

diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt b/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
new file mode 100644
index 0000000..8f530ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.txt
@@ -0,0 +1,135 @@
+Gateworks System Controller multi-function device
+
+The GSC is a Multifunction I2C slave device with the following submodules:
+- WDT
+- GPIO
+- Pushbutton controller
+- HWMON
+
+Required properties:
+- compatible : Must be "gw,gsc"
+- reg: I2C address of the device
+- interrupts: interrupt triggered by GSC_IRQ# signal
+- interrupt-parent: Interrupt controller GSC is connected to
+- #interrupt-cells: should be <1>, index of the interrupt within the
+  controller, in accordance with the "one cell" variant of
+  <devicetree/bindings/interrupt-controller/interrupt.txt>
+
+Optional nodes:
+* watchdog:
+The GSC provides a Watchdog monitor which can power cycle the board's
+primary power supply on most board models when tripped.
+
+Required watchdog properties:
+- compatible: must be "gw,gsc-watchdog"
+
+* hwmon:
+The GSC provides a set of Analog to Digitcal Converter (ADC) pins used for
+temperature and/or voltage monitoring.
+
+Required hwmon properties:
+- compatible: must be "gw,gsc-hwmon"
+
+Optional hwmon properties:
+- gw,reference-voltage: ADC reference voltage (mV) used in scaling raw ADCs
+- gw,resolution: ADC resolution (ie 4096) used in scaling raw ADCs
+
+Each hwmon child node defines an ADC input on the chip which the GSC may
+report cooked values (ie temperature sensor based on thermister), raw values,
+(ie voltage rail with a pre-scaling resistor divider), or a fan controller
+setpoint.
+
+Required hwmon child properties:
+- type: one of the following ADC types:
+  "gw,hwmon-temperature" - reports temperature in C*10
+  "gw,hwmon-voltage" - reports a pre-scaled voltage value
+  "gw,hwmon-voltage-raw" - reports a raw ADC that is scaled with
+       vreference, resolution, and optional resistor divider
+  "gw,hwmon-fan" - a fan temperature setpoint in C*10
+- reg: offset of the ADC register
+- label: name of the ADC input or FAN setpoint
+
+Optional hwmon child properties:
+- gw,voltage-divider: An array of two integers containing the resistor
+  values R1 and R2 of the optinal resistor divider on a raw ADC
+- gw,voltage-offset: a mV voltage offset to apply to a raw ADC (ie to
+  compensate for a diode drop)
+
+Example:
+
+	gsc: gsc@20 {
+		compatible = "gw,gsc";
+		reg = <0x20>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <4 GPIO_ACTIVE_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+
+		watchdog {
+			compatible = "gw,gsc-watchdog";
+		};
+
+		hwmon {
+			compatible = "gw,gsc-hwmon";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			gw,reference-voltage = <2500>;
+			gw,resolution = <4096>;
+
+			hwmon@0 { /* A0: Board Temperature */
+				type = "gw,hwmon-temperature";
+				reg = <0x00>;
+				label = "temp";
+			};
+
+			hwmon@2 { /* A1: Input Voltage (raw ADC) */
+				type = "gw,hwmon-voltage-raw";
+				reg = <0x02>;
+				label = "vdd_vin";
+				gw,voltage-divider = <22100 1000>;
+				gw,voltage-offset = <800>;
+			};
+
+			hwmon@b { /* A2: Battery voltage */
+				type = "gw,hwmon-voltage";
+				reg = <0x0b>;
+				label = "vdd_bat";
+			};
+
+			hwmon@2c { /* fan temperature setpoint for 50% duty */
+				type = "gw,hwmon-fan";
+				reg = <0x2c>;
+				label = "fan_50p";
+			};
+
+			hwmon@2e { /* fan1 */
+				type = "gw,hwmon-fan";
+				reg = <0x2e>;
+				label = "fan_60p";
+			};
+
+			hwmon@30 { /* fan2 */
+				type = "gw,hwmon-fan";
+				reg = <0x30>;
+				label = "fan_70p";
+			};
+
+			hwmon@32 { /* fan3 */
+				type = "gw,hwmon-fan";
+				reg = <0x32>;
+				label = "fan_80p";
+			};
+
+			hwmon@34 { /* fan4 */
+				type = "gw,hwmon-fan";
+				reg = <0x34>;
+				label = "fan_90p";
+			};
+
+			hwmon@36 { /* fan5 */
+				type = "gw,hwmon-fan";
+				reg = <0x36>;
+				label = "fan_100p";
+			};
+		};
+	};
-- 
2.7.4
