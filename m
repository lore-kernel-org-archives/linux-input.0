From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 2/2] devicetree: i2c-hid: Add reset property
Date: Tue, 31 Oct 2017 11:03:16 +0800
Message-ID: <1509418996-25348-2-git-send-email-hl@rock-chips.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, jikos@kernel.org, robh@kernel.org
Cc: benjamin.tissoires@redhat.com, jani.nikula@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, briannorris@chromium.org, devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>
List-Id: linux-input@vger.kernel.org

Document a "reset" and "assert-reset-us", it can be used for
driver control reset property. And reuse post-power-on-delay-ms
for deassert reset delay.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 Documentation/devicetree/bindings/input/hid-over-i2c.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
index 28e8bd8..6ab0eed 100644
--- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
+++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
@@ -31,7 +31,9 @@ device-specific compatible properties, which should be used in addition to the
 
 - vdd-supply: phandle of the regulator that provides the supply voltage.
 - post-power-on-delay-ms: time required by the device after enabling its regulators
-  before it is ready for communication. Must be used with 'vdd-supply'.
+  or deassert reset pin before it is ready for communication.
+- reset: phandle of the gpio that provides for hid reset pin.
+- assert-reset-us: the device require reset assert time.
 
 Example:
 
-- 
2.7.4
