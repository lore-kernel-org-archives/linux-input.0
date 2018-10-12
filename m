From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/5] dt-bindings: add more optional properties for elan_i2c touchpads
Date: Fri, 12 Oct 2018 16:24:11 +0200
Message-ID: <20181012142413.26107-4-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Some new touchpads IC are connected through PS/2 and I2C. On some of these
new IC, the I2C part doesn't have all of the information available.
We need to be able to forward the touchpad parameters from PS/2 and
thus, we need those new optional properties.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
index 797607460735..ace6bcb0b4eb 100644
--- a/Documentation/devicetree/bindings/input/elan_i2c.txt
+++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
@@ -13,6 +13,14 @@ Optional properties:
   pinctrl binding [1]).
 - vcc-supply: a phandle for the regulator supplying 3.3V power.
 - elan,trackpoint: touchpad can support a trackpoint (boolean)
+- elan,clickpad: touchpad is a clickpad (the entire surface is a button)
+- elan,max_x: the maximum reported value on the X axis
+- elan,max_y: the maximum reported value on the Y axis
+- elan,min_x: the minimum reported value on the X axis
+- elan,min_y: the minimum reported value on the Y axis
+- elan,x_res: the resolution of the X axis (in units per mm)
+- elan,y_res: the resolution of the Y axis (in units per mm)
+- elan,width: max reported width of a blob
 
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 [1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-- 
2.14.3
