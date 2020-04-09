Return-Path: <SRS0=a2ag=5Z=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4FC2BB55
	for <linux-input@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0952083E
	for <linux-input@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgDIOOJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:14:09 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45465 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgDIOOJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Apr 2020 10:14:09 -0400
X-Originating-IP: 78.193.40.249
Received: from localhost (unknown [78.193.40.249])
        (Authenticated sender: kamel.bouhara@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id B7EFAFF80E;
        Thu,  9 Apr 2020 14:14:07 +0000 (UTC)
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2 2/3] dt-bindings: counter: atmel-tcb-capture counter
Date:   Thu,  9 Apr 2020 16:14:00 +0200
Message-Id: <20200409141401.321222-3-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
References: <20200409141401.321222-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Describe the devicetree binding for the ATMEL TCB counter. Each counter
blocks exposes three independent counters.

However, when configured in quadrature decoder, both channel <0> and <1>
are required for speed/position and rotation capture (yet only the
position is captured).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 .../bindings/counter/atmel-tcb-capture.yaml   | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml

diff --git a/Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml b/Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml
new file mode 100644
index 000000000000..ca8b31c1f869
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/atmel-tcb-capture.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/counter/atmel-tcb-capture.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel TCB Counter
+
+maintainers:
+  - Kamel Bouhara <kamel.bouhara@bootlin.com>
+
+properties:
+  compatible:
+    const: "atmel,tcb-capture"
+
+  reg:
+    description: TCB capture channel to register as counter device.
+      Each channel is independent therefore only one channel is
+      registered by default execpt for the QDEC mode where both TCB0's
+      channels <0> and  <1> are required.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    tcb0: timer@f800c000 {
+        qdec: timer@0 {
+            compatible = "atmel,tcb-capture";
+            reg = <0>, <1>;
+        };
+    };
-- 
2.25.0

