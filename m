Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D262E95A98
	for <linux-input@archiver.kernel.org>; Mon,  9 Oct 2023 13:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377432AbjJINoq (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377430AbjJINop (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Oct 2023 09:44:45 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BEDB9;
        Mon,  9 Oct 2023 06:44:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E79AC000D;
        Mon,  9 Oct 2023 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696859081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vUYzMwSfVeBad0eaI2EWOBhFHB3PlEhqoHrWQZxPG0M=;
        b=oAsHRhjq9z2ucBSCfKynWry3NWhc3Y+QPtLWZXwvESiNAsLkxc1JXd90dYmWbB8EgSBGBx
        eDkVnyNq0ktEXuEXd4UYFCiQTBxmCDrqZXSjHY07PZHZXDGKOltxFkiLwhTpUsB9BXPwy+
        21Q59a+D+vMB0EaVoWiJ1USPZLDo+A5jYDnEvu3hTjKnfEMN72WymOfkdL5tstnT/EZX5o
        uHavaCjQL9Q5JzVRo7Mz80bCFan3WIFgUsNo1BOxpscopa92xoau14xJhS0T2ucZybg8Ca
        97u5y0u0xhHB6a9XWEnrGY6uD2UqZ6Y7eI7FrOwlkX1Z6u9ude7QEA79BTYS7w==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mark.satterthwaite@touchnetix.com,
        pedro.torruella@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add TouchNetix AS
Date:   Mon,  9 Oct 2023 15:44:33 +0200
Message-Id: <20231009134435.36311-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009134435.36311-1-kamel.bouhara@bootlin.com>
References: <20231009134435.36311-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add vendor prefix for TouchNetix AS (https://www.touchnetix.com/products/).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..78581001a79c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1400,6 +1400,8 @@ patternProperties:
     description: Toradex AG
   "^toshiba,.*":
     description: Toshiba Corporation
+  "^touchnetix,.*":
+    description: TouchNetix AS
   "^toumaz,.*":
     description: Toumaz
   "^tpk,.*":
-- 
2.25.1

