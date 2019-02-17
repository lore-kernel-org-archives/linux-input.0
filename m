From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/4] dt-bindings: input: touchscreen: goodix: Document regulator properties
Date: Sun, 17 Feb 2019 14:44:33 +0530
Message-ID: <20190217091436.3702-2-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Out of which AVDD28 regulator is mandatory supplied regulator in most
of the board designs, so document AVDD28 as required property and
rest marked as optional regulators.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../devicetree/bindings/input/touchscreen/goodix.txt       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..8f6e6eede64d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,13 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
+
+Optional properties:
+
+ - AVDD22-supply	: Analog power supply regulator on AVDD22 pin
+ - DVDD12-supply	: Digital power supply regulator on DVDD12 pin
+ - VDDIO-supply		: GPIO power supply regulator on VDDIO pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3
