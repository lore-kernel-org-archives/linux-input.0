Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C689C77B71
	for <linux-input@archiver.kernel.org>; Fri, 14 Apr 2023 23:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjDNXix (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 14 Apr 2023 19:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNXiw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Apr 2023 19:38:52 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640265260;
        Fri, 14 Apr 2023 16:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1681515531;
  x=1713051531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ydv940Xa+5P2EMaQhnzv/nXM4eZImQyTFtHYz7eUDH4=;
  b=mTx01zSVwFdAnHQXpfm8aajkvtn9tRHJgz3qoOFM7AY7YM/ZPPix/l3m
   VSIO8JUZp39t82hWlfO1PerpFO+iwK+migFBr0/9VkBQDFDU/A/azUEsk
   payrfF1De6WdzzguXbs7AIoyK88DuwFADCfCSfFpA5pRCzcrywHST1J7W
   DlmkJgNDOBQAbfeH1YLdf++HdMjyZIcpmujJ4VaHWFDrd14Qxd5CgAH2O
   0IfgfayP1yXiHQYdlsU2XPme8/3/VTY5CCowKyv1MhQd99TAc7nkGqbgT
   56mcUCo9I8xj4v/C3iumzlfvo66+BZtGwZ8cjH7eAO2swUCdYcNE4xUqx
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] Input: cap11xx add advanced sensitivity settings
Date:   Sat, 15 Apr 2023 01:38:13 +0200
Message-ID: <20230414233815.4004526-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

PATCH 1 - add documentation for new options
PATCH 2 - add support for advanced settings into driver

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings

 .../bindings/input/microchip,cap11xx.yaml     |  64 ++++-
 drivers/input/keyboard/cap11xx.c              | 263 +++++++++++++++---
 2 files changed, 278 insertions(+), 49 deletions(-)

-- 
2.25.1

