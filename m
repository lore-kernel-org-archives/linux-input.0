Return-Path: <SRS0=1TPC=D5=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A9AC61DD8
	for <linux-input@archiver.kernel.org>; Thu, 22 Oct 2020 15:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF4224654
	for <linux-input@archiver.kernel.org>; Thu, 22 Oct 2020 15:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368971AbgJVP7g (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 22 Oct 2020 11:59:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:48766 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368920AbgJVP7T (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32E0BAC48;
        Thu, 22 Oct 2020 15:59:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>, Stefan Wahren <wahrenst@gmx.net>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 08/10] dt-bindings: pwm: Add binding for RPi firmware PWM bus
Date:   Thu, 22 Oct 2020 17:58:55 +0200
Message-Id: <20201022155858.20867-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022155858.20867-1-nsaenzjulienne@suse.de>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The PWM bus controlling the fan in RPi's official PoE hat can only be
controlled by the board's co-processor.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---
Changes since v1:
 - Update bindings to use 2 #pwm-cells

 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml | 20 +++++++++++++++++++
 .../pwm/raspberrypi,firmware-pwm.h            | 13 ++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-pwm.h

diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
index a2c63c8b1d10..8029ce958c48 100644
--- a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.yaml
@@ -64,6 +64,21 @@ properties:
       - compatible
       - "#reset-cells"
 
+  pwm:
+    type: object
+
+    properties:
+      compatible:
+        const: raspberrypi,firmware-pwm
+
+      "#pwm-cells":
+        # See pwm.yaml in this directory for a description of the cells format.
+        const: 2
+
+    required:
+      - compatible
+      - "#pwm-cells"
+
     additionalProperties: false
 
 required:
@@ -87,5 +102,10 @@ examples:
             compatible = "raspberrypi,firmware-reset";
             #reset-cells = <1>;
         };
+
+        pwm: pwm {
+            compatible = "raspberrypi,firmware-pwm";
+            #pwm-cells = <1>;
+        };
     };
 ...
diff --git a/include/dt-bindings/pwm/raspberrypi,firmware-pwm.h b/include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
new file mode 100644
index 000000000000..27c5ce68847b
--- /dev/null
+++ b/include/dt-bindings/pwm/raspberrypi,firmware-pwm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Nicolas Saenz Julienne
+ * Author: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#ifndef _DT_BINDINGS_RASPBERRYPI_FIRMWARE_PWM_H
+#define _DT_BINDINGS_RASPBERRYPI_FIRMWARE_PWM_H
+
+#define RASPBERRYPI_FIRMWARE_PWM_POE		0
+#define RASPBERRYPI_FIRMWARE_PWM_NUM		1
+
+#endif
-- 
2.28.0

