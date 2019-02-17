From: Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 3/4] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date: Sun, 17 Feb 2019 14:44:35 +0530
Message-ID: <20190217091436.3702-4-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Rob Herring <robh+dt@kernel.org>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-amarula@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>, Jagan Teki <jagan@amarulasolutions.com>
List-Id: linux-input@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures, it support chipdata which is similar to
existing GT1151 and require AVDD28 supply for some boards.

Document the compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 8f6e6eede64d..29c149d91a05 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
 				 or "goodix,gt912"
-- 
2.18.0.321.gffc6fa0e3
