From: Richard Leitner <richard.leitner@skidata.com>
Subject: [RESEND PATCH v2 3/8] dt-bindings: input: touchscreen: sx8654: add compatible models
Date: Tue, 18 Dec 2018 09:36:01 +0100
Message-ID: <20181218083606.25795-4-richard.leitner@skidata.com>
References: <20181218083606.25795-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218083606.25795-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, mark.rutland@arm.com
Cc: robh+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, richard.leitner@skidata.com
List-Id: linux-input@vger.kernel.org

As the sx865[456] share the same datasheet and differ only in the
presence of a "capacitive proximity detection circuit" and a "haptics
motor driver for LRA/ERM" add them to the compatbiles. As the driver
doesn't implement these features it should be no problem.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
index ca521d8f7d65..a538678424dd 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
@@ -1,7 +1,10 @@
 * Semtech SX8654 I2C Touchscreen Controller
 
 Required properties:
-- compatible: must be "semtech,sx8654"
+- compatible: must be one of the following, depending on the model:
+	"semtech,sx8654"
+	"semtech,sx8655"
+	"semtech,sx8656"
 - reg: i2c slave address
 - interrupts: touch controller interrupt
 
-- 
2.11.0
