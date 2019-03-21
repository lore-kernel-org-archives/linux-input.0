From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 1/4] dt-bindings: input: touchscreen: goodix: Document regulator properties
Date: Thu, 21 Mar 2019 13:51:01 +0530
Message-ID: <20190321082104.2874-2-jagan@amarulasolutions.com>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8cf0b4d38a7e..255673250bbd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -19,6 +19,8 @@ Optional properties:
  - irq-gpios		: GPIO pin used for IRQ. The driver uses the
 			  interrupt gpio pin as output to reset the device.
  - reset-gpios		: GPIO pin used for reset
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
+ - VDDIO-supply		: GPIO power supply regulator on VDDIO pin
  - touchscreen-inverted-x
  - touchscreen-inverted-y
  - touchscreen-size-x
-- 
2.18.0.321.gffc6fa0e3
