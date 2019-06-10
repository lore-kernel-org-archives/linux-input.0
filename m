From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 1/3] dt-bindings: Add pixart vendor
Date: Mon, 10 Jun 2019 11:29:43 +0200
Message-ID: <20190610092945.6330-2-amergnat@baylibre.com>
References: <20190610092945.6330-1-amergnat@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610092945.6330-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
List-Id: linux-input@vger.kernel.org

PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
capacitive touch controllers and related imaging application development.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 33a65a45e319..ac5060e8de8d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -661,6 +661,8 @@ patternProperties:
     description: Picochip Ltd
   "^pine64,.*":
     description: Pine64
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.17.1
