Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9C8C636D6
	for <linux-input@archiver.kernel.org>; Mon,  6 Feb 2023 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjBFPOb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 6 Feb 2023 10:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBFPO3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Feb 2023 10:14:29 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C393E12F25;
        Mon,  6 Feb 2023 07:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675696469;
  x=1707232469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PvpKb7yLkqMFdKtztiv7P/jYOiCMzuBhzTwslaeYKCw=;
  b=UevUwyZpnrLQNugSIx8J2CVjScU45K81W3C1mf5+B0ZolyZ7+SWQVmDM
   K9x3KUleagtm65jlM6L5YTVLOACNNGtrIcJiwq1kPIOh8CK7cZEnm/KyX
   PX7CH3gO04DACHdk7R9w7I9cmkl5WTlb3i2rOL+mTIsEaRYG8+0tILJXF
   0PAwJqSZJYf0HaqcI/u48z0YaS/jZjFXdmkPa8g9i9y0pTFcQC5tiP8xa
   dnpHElohnsI0qQGbHcGMXra0tDcZkL//3zth3qnQ1TXlKncOQdC8T0lLE
   Xw9q2JGSFcqsXEDisK6bRgDtt2IPnPvW+nb4eFpp696FIALkbhqXVIY56
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <linux-input@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <dmitry.torokhov@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <u.kleine-koenig@pengutronix.de>, <mkorpershoek@baylibre.com>,
        <jiriv@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and cap1298
Date:   Mon, 6 Feb 2023 16:13:30 +0100
Message-ID: <20230206151331.184634-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206151331.184634-1-jiriv@axis.com>
References: <20230206151331.184634-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail04w.axis.com (10.20.40.10) To se-mail01w.axis.com
 (10.20.40.7)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Add support for cap1203, cap1293 and cap1298.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
Changes in v2:
  - No changes.
  
Changes in v3:
  - No changes.
  
Changes in v4
  - Model names sorted alphabetically.

Changes in v5:
  - No changes.

 Documentation/devicetree/bindings/input/microchip,cap11xx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 67d4d8f86a2d..5fa625b5c5fb 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -19,7 +19,10 @@ properties:
       - microchip,cap1106
       - microchip,cap1126
       - microchip,cap1188
+      - microchip,cap1203
       - microchip,cap1206
+      - microchip,cap1293
+      - microchip,cap1298
 
   reg:
     maxItems: 1
-- 
2.25.1

