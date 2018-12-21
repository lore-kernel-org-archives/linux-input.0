From: Philippe Schenker <dev@pschenker.ch>
Subject: [PATCH v5 1/8] dt-bindings: stmpe: reformatting parameter list and use tabs only
Date: Fri, 21 Dec 2018 14:46:30 +0100
Message-ID: <20181221134638.20600-2-dev@pschenker.ch>
References: <20181221134638.20600-1-dev@pschenker.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch
Cc: robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, digetx@gmail.com, lee.jones@linaro.org, coquelin.stm32@gmail.com, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, Max Krummenacher <max.krummenacher@toradex.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

This patch reformats the parameter list for stmpe device in a
table-style so it is more clear to read.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

---

Changes in v5:
 - Made a one column list
 - Added lee's Acked-for-MFD
 - Changed author of commit to use correct email.

Changes in v4:
 - New separate precursor patch for holding reformatting

Changes in v3: None
Changes in v2: None

 .../bindings/input/touchscreen/stmpe.txt      | 64 +++++++++++++------
 .../devicetree/bindings/mfd/stmpe.txt         | 14 ++--
 2 files changed, 53 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
index 127baa31a77a..bf66a55a7de5 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
@@ -5,24 +5,52 @@ Required properties:
  - compatible: "st,stmpe-ts"
 
 Optional properties:
-- st,sample-time: ADC converstion time in number of clock.  (0 -> 36 clocks, 1 ->
-  44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks, 5 -> 96 clocks, 6
-  -> 144 clocks), recommended is 4.
-- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
-- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
-  reference)
-- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
-- st,ave-ctrl: Sample average control (0 -> 1 sample, 1 -> 2 samples, 2 -> 4
-  samples, 3 -> 8 samples)
-- st,touch-det-delay: Touch detect interrupt delay (0 -> 10 us, 1 -> 50 us, 2 ->
-  100 us, 3 -> 500 us, 4-> 1 ms, 5 -> 5 ms, 6 -> 10 ms, 7 -> 50 ms) recommended
-  is 3
-- st,settling: Panel driver settling time (0 -> 10 us, 1 -> 100 us, 2 -> 500 us, 3
-  -> 1 ms, 4 -> 5 ms, 5 -> 10 ms, 6 for 50 ms, 7 -> 100 ms) recommended is 2
-- st,fraction-z: Length of the fractional part in z (fraction-z ([0..7]) = Count of
-  the fractional part) recommended is 7
-- st,i-drive: current limit value of the touchscreen drivers (0 -> 20 mA typical 35
-  mA max, 1 -> 50 mA typical 80 mA max)
+- st,sample-time	: ADC conversion time in number of clock.
+				0 -> 36 clocks
+				1 -> 44 clocks
+				2 -> 56 clocks
+				3 -> 64 clocks
+				4 -> 80 clocks (recommended)
+				5 -> 96 clocks
+				6 -> 144 clocks
+- st,mod-12b		: ADC Bit mode
+				0 -> 10bit ADC
+				1 -> 12bit ADC
+- st,ref-sel		: ADC reference source
+				0 -> internal
+				1 -> external
+- st,adc-freq		: ADC Clock speed
+				0 -> 1.625 MHz
+				1 -> 3.25 MHz
+				2 || 3 -> 6.5 MHz
+- st,ave-ctrl		: Sample average control
+				0 -> 1 sample
+				1 -> 2 samples
+				2 -> 4 samples
+				3 -> 8 samples
+- st,touch-det-delay	: Touch detect interrupt delay (recommended is 3)
+				0 -> 10 us
+				1 -> 50 us
+				2 -> 100 us
+				3 -> 500 us
+				4 -> 1 ms
+				5 -> 5 ms
+				6 -> 10 ms
+				7 -> 50 ms
+- st,settling		: Panel driver settling time (recommended is 2)
+				0 -> 10 us
+				1 -> 100 us
+				2 -> 500 us
+				3 -> 1 ms
+				4 -> 5 ms
+				5 -> 10 ms
+				6 -> 50 ms
+				7 -> 100 ms
+- st,fraction-z		: Length of the fractional part in z (recommended is 7)
+			  (fraction-z ([0..7]) = Count of the fractional part)
+- st,i-drive		: current limit value of the touchscreen drivers
+				0 -> 20 mA (typical 35mA max)
+				1 -> 50 mA (typical 80 mA max)
 
 Node name must be stmpe_touchscreen and should be child node of stmpe node to
 which it belongs.
diff --git a/Documentation/devicetree/bindings/mfd/stmpe.txt b/Documentation/devicetree/bindings/mfd/stmpe.txt
index c797c05cd3c2..a46e7177195d 100644
--- a/Documentation/devicetree/bindings/mfd/stmpe.txt
+++ b/Documentation/devicetree/bindings/mfd/stmpe.txt
@@ -4,15 +4,15 @@ STMPE is an MFD device which may expose the following inbuilt devices: gpio,
 keypad, touchscreen, adc, pwm, rotator.
 
 Required properties:
- - compatible                   : "st,stmpe[610|801|811|1600|1601|2401|2403]"
- - reg                          : I2C/SPI address of the device
+ - compatible			: "st,stmpe[610|801|811|1600|1601|2401|2403]"
+ - reg				: I2C/SPI address of the device
 
 Optional properties:
- - interrupts                   : The interrupt outputs from the controller
- - interrupt-controller         : Marks the device node as an interrupt controller
- - wakeup-source                : Marks the input device as wakable
- - st,autosleep-timeout         : Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
- - irq-gpio                     : If present, which GPIO to use for event IRQ
+ - interrupts			: The interrupt outputs from the controller
+ - interrupt-controller		: Marks the device node as an interrupt controller
+ - wakeup-source		: Marks the input device as wakable
+ - st,autosleep-timeout		: Valid entries (ms); 4, 16, 32, 64, 128, 256, 512 and 1024
+ - irq-gpio			: If present, which GPIO to use for event IRQ
 
 Example:
 
-- 
2.19.2
