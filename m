From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 3/8] dt-bindings: input: touchscreen: sx8654: add compatible models
Date: Wed, 17 Oct 2018 14:51:11 +0200
Message-ID: <20181017125116.20077-4-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

As the sx865[456] share the same datasheet and differ only in the
presence of a "capacitive proximity detection circuit" and a "haptics
motor driver for LRA/ERM" add them to the compatbiles. As the driver
doesn't implement these features it should be no problem.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
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
