From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v6 1/4] dt-bindings: input: touchscreen: goodix: Document regulator properties
Date: Tue, 19 Feb 2019 15:46:26 +0530
Message-ID: <20190219101629.15977-2-jagan@amarulasolutions.com>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190219101629.15977-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

Goodix CTP controllers support analog, digital and gpio regulator
supplies on relevant controller pin configurations.

Out of which AVDD28 and VDDIO regulators are required in few goodix CTP
chips during power-on sequence.

AVDD22, DVDD12 regulators have no relevant functionality described from
datasheet [1].

So, document both AVDD28, VDDIO regulators into optional properties since
few of the goodix chip do work without these regulator power-on sequence.

[1] GT5663 Datasheet_English_20151106_Rev.01

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..b9b8f196dc90 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,8 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
+ - VDDIO-supply		: GPIO power supply regulator on VDDIO pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3
