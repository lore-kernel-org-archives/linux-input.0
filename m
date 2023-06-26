Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9B7EB64DA
	for <linux-input@archiver.kernel.org>; Mon, 26 Jun 2023 13:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjFZNAV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Jun 2023 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFZNAU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Jun 2023 09:00:20 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935C5D8;
        Mon, 26 Jun 2023 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687784419;
  x=1719320419;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cy+2M20OlzQuqjrdtvJVVcbvb5gNEV9YaxQhkt8pYjs=;
  b=R3ow75IN2qMBBEbu8dJ/J9fkWpOAGz8tw5ZhyfH6tujOYVfW6tQBRpAG
   kQOefmiiZHBvJR8AyrIEbTRIEm8X6VynU5i7FgVsKodQqzH9LSvkYgzur
   owED40Pn8uZF/gSLmZiN4D9T0Oug8TS8TG1Ovt42Leu0Avkc6DVkq4A0g
   5LAWMInWTA94GLtnOaSlK9Q2hXD0UqkmW89GP5z+BO06z2cWdhLWwnCOr
   ovda4o2rihmp6bXBC7H7l10rfGpCL++9JJHTeEYvUD/sIXppcN5kh5Fbu
   X1FKsGHSeWwkKt5nYHSaMi90bBcgjz2GtlsSUrxxm1snbTHgGqc8x/ABB
   w==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 0/2] Input: cap11xx add advanced sensitivity settings
Date:   Mon, 26 Jun 2023 15:00:04 +0200
Message-ID: <20230626130006.850254-1-jiriv@axis.com>
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

Changes in v2:
  - Removed "sensitivity-base-shift" parameter (not HW propertie) in PATCH 2.
  - Used IRQ from I2C subsystem instead of parsing it again.
  - Fixed some documentation issues in PATCH 1
  
Changes in v3:
  - Remove incorrectly used "Reviewed-by" tag in PATCH 1 and 2

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add advanced sensitivity
    settings
  Input: cap11xx - add advanced sensitivity settings

 .../bindings/input/microchip,cap11xx.yaml     |  77 +++++-
 drivers/input/keyboard/cap11xx.c              | 250 ++++++++++++++----
 2 files changed, 269 insertions(+), 58 deletions(-)

-- 
2.25.1

