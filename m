From: Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH v2 5/8] dt-bindings: input: touchscreen: sx8654: add sx8650 to comatibles
Date: Wed, 17 Oct 2018 14:51:13 +0200
Message-ID: <20181017125116.20077-6-richard.leitner@skidata.com>
References: <20181017125116.20077-1-richard.leitner@skidata.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017125116.20077-1-richard.leitner@skidata.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Leitner <richard.leitner@skidata.com>
List-Id: linux-input@vger.kernel.org

As the sx8650 is quite similar to the sx8654 support for it will be
added in the driver. Therefore add it to the compatibles.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 Documentation/devicetree/bindings/input/touchscreen/sx8654.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
index a538678424dd..0ebe6dd043c7 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/sx8654.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible: must be one of the following, depending on the model:
+	"semtech,sx8650"
 	"semtech,sx8654"
 	"semtech,sx8655"
 	"semtech,sx8656"
-- 
2.11.0
