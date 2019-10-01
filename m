Return-Path: <SRS0=p1C8=X2=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D6FC352AA
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9FC21855
	for <linux-input@archiver.kernel.org>; Tue,  1 Oct 2019 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="cAuoUUt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbfJAO35 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:29:57 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:56398 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388922AbfJAO3z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Oct 2019 10:29:55 -0400
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 286E6A06E5;
        Tue,  1 Oct 2019 16:29:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1569940193;
        bh=T5y8rYo1ChPRnQan76zQKfnGw0/ifzLo7zhRzVnYC5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cAuoUUt/W4Fb5y07V6+Mywf47w2NHRYYpM4EgjijT0sPrF7Ov1VuSkaEGkw66ek09
         +i7MtbM6exlihGkpAr6s2JxQrDe1oEiCgpxZf7AG23LAfMNLgiT4JrdxuC0Cf0XaE+
         b/NRrtUNnsQHMkdCez62nTGP0UbuB5jXfNBwZcdk=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 1/5] dt-bindings: input: Add common input binding in json-schema
Date:   Tue,  1 Oct 2019 16:29:36 +0200
Message-Id: <1569940180-11417-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1569940180-11417-1-git-send-email-michal.vokac@ysoft.com>
References: <1569940180-11417-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Create schema for the common input properties.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes since v1:
 - New patch in the series.

Rob, you suggested to extract the common properties from
fsl,mpr121-touchkey.yaml into this file. In the meantime I realized that
the linux,keycodes property is already documented in keys.txt.

What do you suggest to do? Some possible options:
 - Just remove the linux,keycodes propery from keys.txt.
 - Merge this input.yaml with all content of keys.txt. How to name the result?
 - Something else?

 Documentation/devicetree/bindings/input/input.yaml | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/input.yaml

diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
new file mode 100644
index 000000000000..494e7d031ea3
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/input.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common input schema binding
+
+maintainers:
+  - Dmitry Torokhov <dmitry.torokhov@gmail.com>
+
+properties:
+  linux,keycodes:
+    description:
+      Specifies an array of numeric keycode values to be used for reporting
+      button presses. The array can contain up to 12 entries.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32-array
+      - items:
+          minimum: 0
+          maximum: 0xff
+
+  autorepeat:
+    description: Enable autorepeat when key is pressed and held down.
+    type: boolean
-- 
2.1.4

