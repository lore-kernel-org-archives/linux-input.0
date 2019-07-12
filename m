From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 1/3] dt-bindings: Add pixart vendor
Date: Fri, 12 Jul 2019 11:40:48 +0200
Message-ID: <20190712094050.17432-2-amergnat@baylibre.com>
References: <20190712094050.17432-1-amergnat@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190712094050.17432-1-amergnat@baylibre.com>
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
index 18b79c4cf7d5..120529f40c7c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -705,6 +705,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.17.1
