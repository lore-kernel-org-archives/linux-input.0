Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6758C46467
	for <linux-input@archiver.kernel.org>; Tue,  3 Jan 2023 13:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjACNmE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 3 Jan 2023 08:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjACNmD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 3 Jan 2023 08:42:03 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024791114E;
        Tue,  3 Jan 2023 05:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1672753322;
  x=1704289322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UNQnZcPD5pQpA0xMHBwIkOibtF3daXspO7fcHHlLN0E=;
  b=JlfdQFphkIqx2cJISdbKN8POOBcpCzd1IfO96TJtTRkFBKo7R3ymtprB
   Kigo+a6D4Exz6tIuRXszB/XDd6yGmWwrflzH5GZQBs9l8soKXHERTclDi
   MIgcsGfm3gcrg8+/ts9GD+IcvpRg870UmA6+WH6S2/jnVT92hXC7U6g6D
   9YdNJ2F2Au24vM3v2Eqk7GQd8yp6V9kD6Oo8SlQRu3lqLrnWePAB123Kn
   xEWYYIkBCCFC2uFsPctgQHW4YogfvOCZkCijXfQdwWuDgkXu5sDfaMezb
   jf/StGc1DqgWnBomJWaZ/2xQGeGgndN2nRGI/M7EGioELR5TOE0xzkWSl
   A==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jiri Valek - 2N <jiriv@axis.com>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Input: cap11xx add support for cap1203, cap1293 and cap1298
Date:   Tue, 3 Jan 2023 14:41:02 +0100
Message-ID: <20230103134105.736346-1-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail03w.axis.com
 (10.20.40.9)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

PATCH 1 - add compatible string for new models
PATCH 2 - add support for new models into driver

Jiri Valek - 2N (2):
  dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and
    cap1298
  Input: cap11xx - add support for cap1203, cap1293 and cap1298

 .../bindings/input/microchip,cap11xx.yaml     |  3 +++
 drivers/input/keyboard/cap11xx.c              | 20 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.25.1

