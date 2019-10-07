From: Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 2/3] dt-bindings: mms114: document melfas,mms345l binding
Date: Mon,  7 Oct 2019 22:33:42 +0200
Message-ID: <20191007203343.101466-3-stephan@gerhold.net>
References: <20191007203343.101466-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191007203343.101466-1-stephan@gerhold.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@samsung.com>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
List-Id: linux-input@vger.kernel.org

The mms114 driver now supports MMS345L; document the
melfas,mms345l binding that is used for it.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 Documentation/devicetree/bindings/input/touchscreen/mms114.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
index 2cd954051d29..707234cfd7e6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
@@ -1,9 +1,10 @@
-* MELFAS MMS114/MMS152 touchscreen controller
+* MELFAS MMS114/MMS152/MMS345L touchscreen controller
 
 Required properties:
 - compatible: should be one of:
 	- "melfas,mms114"
 	- "melfas,mms152"
+	- "melfas,mms345l"
 - reg: I2C address of the chip
 - interrupts: interrupt to which the chip is connected
 - touchscreen-size-x: See [1]
-- 
2.23.0
