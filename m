From: Roy Im <roy.im.opensource@diasemi.com>
Subject: [PATCH V4 2/3] dt-bindings: input: Add document bindings for DA7280
Date: Tue, 21 Aug 2018 14:44:31 +0900
Message-ID: <0d2a3c034a567d3a3ccd2e965f40e9af28f7e4d3.1534830272.git.Roy.Im@diasemi.com>
References: <cover.1534830272.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1534830272.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


Add device tree binding information for DA7280 haptic driver.
Example bindings for DA7280 are added.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v4: Fixed commit message, properties.

v3: Fixed subject format.

v2: No changes


 .../devicetree/bindings/input/dlg,da7280.txt       |  101 ++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt

diff --git a/Documentation/devicetree/bindings/input/dlg,da7280.txt b/Documentation/devicetree/bindings/input/dlg,da7280.txt
new file mode 100644
index 0000000..a61e9f0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/dlg,da7280.txt
@@ -0,0 +1,101 @@
+Dialog Semiconductor DA7280 Haptics bindings
+
+Required properties:
+- compatible: Should be "dlg,da7280".
+- reg: Specifies the I2C slave address.
+
+- interrupt-parent : Specifies the phandle of the interrupt controller to
+  which the IRQs from DA7280 are delivered to.
+
+- dlg,vib-mode:
+  "LRA-MODE" - Linear Resonance Actuator mode.
+  "ERM-BAR" - Bar type Eccentric Rotating Mass mode.
+  "ERM-COIN" - Coin type Eccentric Rotating Mass mode.
+
+- dlg,op-mode: Haptic operation mode.
+  Possible values:
+	1 - Direct register override mode triggered by i2c(default),
+	2 - PWM data source mode setting duty to 0 - 0xffff(0% - 100%),
+	3 - Register triggered waveform memory mode, the pattern assigned
+	    to the PS_SEQ_ID played as much times as PS_SEQ_LOOP,
+	4 - Edge triggered waveform memory mode, external GPI(N) condtrol
+	    are required to enable/disable and it needs to keep
+	    device enabled by sending magnitude (X > 0),
+	    the pattern is assigned to the GPI(N)_SEQUENCE_ID below
+	    For more details, please see the datasheet.
+
+- dlg,nom-microvolt: Nominal actuator voltage rating.
+  Valid values: 0 - 6000000.
+- dlg,abs-max-microvolt: Absolute actuator maximum voltage rating.
+  Valid values: 0 - 6000000.
+- dlg,imax-microamp: Actuator max current rating.
+  Valid values: 0 - 252000.
+  Default: 130000.
+- dlg,impd-micro-ohms: the impedance of the actuator in micro ohm,
+  as read from its datasheet.
+  Valid values: 0 - 1500000000.
+
+Optional properties:
+- pwms : phandle to the physical PWM(Pulse Width Modulation) device.
+  PWM properties should be named "pwms". And number of cell is different
+  for each pwm device.
+  (See Documentation/devicetree/bindings/pwm/pwm.txt
+   for further information relating to pwm properties)
+
+- dlg,ps-seq-id: the PS_SEQ_ID(pattern ID in waveform memory inside chip)
+  to play back when RTWM-MODE is enabled.
+  Valid range: 0 - 15.
+- dlg,ps-seq-loop: the PS_SEQ_LOOP, Number of times the pre-stored sequence
+  pointed to by PS_SEQ_ID or GPI(N)_SEQUENCE_ID is repeated.
+  Valid range: 0 - 15.
+- dlg,gpiN-seq-id: the GPI(N)_SEQUENCE_ID, pattern to play
+  when gpi0 is triggered, 'N' must be 0 - 2.
+  Valid range: 0 - 15.
+- dlg,gpiN-mode: the pattern mode which can select either
+  "Single-pattern" or "Multi-pattern", 'N' must be 0 - 2.
+- dlg,gpiN-polarity: gpiN polarity which can be chosen among
+  "Rising-edge", "Falling-edge" and "Both-edge",
+  'N' must be 0 - 2
+  Haptic will work by this edge option in case of ETWM-MODE.
+
+- dlg,resonant-freq-hz: use in case of LRA-MODE.
+  the frequency range: 50 - 300.
+  Default: 205.
+
+- dlg,bemf-sens-enable: Enable for internal loop computations.
+- dlg,freq-track-enable: Enable for resonant frequency tracking.
+- dlg,acc-enable: Enable for active acceleration.
+- dlg,rapid-stop-enable: Enable for rapid stop.
+- dlg,amp-pid-enable: Enable for the amplitude PID.
+- dlg,mem-array: use in case that memory registers should be updated,
+  Please fill the whole buffers(100 bytes) to avoid any error in driver.
+  For example,
+	dlg,mem-array = <
+		0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08 0x09 0x0A
+		...
+		0x71 0x72 0x73 0x74 0x75 0x76 0x77 0x78 0x79 0x7A
+		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+		0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+	>;
+
+For further information, see device datasheet.
+
+======
+
+Example:
+
+	haptics: da7280-haptics@4a {
+		compatible = "dlg,da7280";
+		reg = <0x4a>;
+		interrupt-parent = <&gpio6>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		dlg,vib-mode = "LRA-MODE";
+		dlg,op-mode = <1>;
+		dlg,nom-microvolt = <2000000>;
+		dlg,abs-max-microvolt = <2000000>;
+		dlg,imax-microamp = <170000>;
+		dlg,resonant-freq-hz = <180>;
+		dlg,impd-micro-ohms = <10500000>;
+		dlg,freq-track-enable;
+		dlg,rapid-stop-enable;
+	};
-- 
end-of-patch for PATCH V4
