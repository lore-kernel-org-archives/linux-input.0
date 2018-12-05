From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/4] dt-bindings: input: touchscreen: goodix: Document AVDD28-supply property
Date: Thu,  6 Dec 2018 05:22:17 +0530
Message-ID: <20181205235220.3461-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
Cc: Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

Most of the Goodix CTP controllers are supply with AVDD28 pin.
which need to supply for controllers like GT5663 on some boards
to trigger the power.

So, document the supply property so-that the required board
that used on GT5663 can enable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Rename vcc-supply with AVDD28-supply

 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index f7e95c52f3c7..c4622c983e08 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -23,6 +23,7 @@ Optional properties:
  - touchscreen-inverted-y  : Y axis is inverted (boolean)
  - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
                              (swapping is done after inverting the axis)
+ - AVDD28-supply	: Analog power supply regulator on AVDD28 pin
 
 Example:
 
-- 
2.18.0.321.gffc6fa0e3
