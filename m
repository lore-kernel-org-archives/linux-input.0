From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 04/10] dt-bindings: add more optional properties for elan_i2c touchpads
Date: Tue, 21 May 2019 15:27:06 +0200
Message-ID: <20190521132712.2818-5-benjamin.tissoires@redhat.com>
References: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, Aaron Ma <aaron.ma@canonical.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Some new touchpads IC are connected through PS/2 and I2C. On some of these
new IC, the I2C part doesn't have all of the information available.
We need to be able to forward the touchpad parameters from PS/2 and
thus, we need those new optional properties.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

--

changes in v2:
- Use of generic touchscreen properties for min/max and resolutions
- add elan,middle-button
- add elan,*_traces
---
 Documentation/devicetree/bindings/input/elan_i2c.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
index 797607460735..9963247706f2 100644
--- a/Documentation/devicetree/bindings/input/elan_i2c.txt
+++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
@@ -13,9 +13,20 @@ Optional properties:
   pinctrl binding [1]).
 - vcc-supply: a phandle for the regulator supplying 3.3V power.
 - elan,trackpoint: touchpad can support a trackpoint (boolean)
+- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
+- elan,middle-button: touchpad has a physical middle button
+- elan,x_traces: number of antennas on the x axis
+- elan,y_traces: number of antennas on the y axis
+- some generic touchscreen properties [2]:
+  * touchscreen-size-x
+  * touchscreen-size-y
+  * touchscreen-x-mm
+  * touchscreen-y-mm
+
 
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 [1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
+[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
 
 Example:
 	&i2c1 {
-- 
2.21.0
