Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6601C433EF
	for <linux-input@archiver.kernel.org>; Fri,  3 Jun 2022 05:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbiFCFLO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 3 Jun 2022 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239964AbiFCFLE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Jun 2022 01:11:04 -0400
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 22:11:03 PDT
Received: from jax4mhob15.registeredsite.com (jax4mhob15.registeredsite.com [64.69.218.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD832049
        for <linux-input@vger.kernel.org>; Thu,  2 Jun 2022 22:11:02 -0700 (PDT)
Received: from mailpod.hostingplatform.com ([10.30.71.206])
        by jax4mhob15.registeredsite.com (8.14.4/8.14.4) with ESMTP id 2535B0eO092882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-input@vger.kernel.org>; Fri, 3 Jun 2022 01:11:00 -0400
Received: (qmail 31756 invoked by uid 0); 3 Jun 2022 05:11:00 -0000
X-TCPREMOTEIP: 204.168.181.193
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@204.168.181.193)
  by 0 with ESMTPA; 3 Jun 2022 05:11:00 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        geert+renesas@glider.be, martink@posteo.de, hechtb@gmail.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v2 2/2] dt-bindings: Input: st1232 - Support power supply regulators
Date:   Fri,  3 Jun 2022 07:10:58 +0200
Message-Id: <20220603051058.6075-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add support for the VDD and IOVDD power supply inputs. This allows the
chip to share its supplies with other components (e.g. panel) and manage
them.

This provides the devicetree bindings.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Split devicetree and code parts

 .../bindings/input/touchscreen/sitronix,st1232.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
index 1d8ca19fd37a..240be8d49232 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix,st1232.yaml
@@ -28,6 +28,12 @@ properties:
     description: A phandle to the reset GPIO
     maxItems: 1
 
+  vdd-supply:
+    description: Power supply regulator for the chip
+
+  vddio-supply:
+    description: Power supply regulator for the I2C bus
+
 required:
   - compatible
   - reg
-- 
2.17.1

