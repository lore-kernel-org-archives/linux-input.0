Return-Path: <SRS0=R9rl=DD=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DECC2D0A8
	for <linux-input@archiver.kernel.org>; Sat, 26 Sep 2020 12:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337D62080C
	for <linux-input@archiver.kernel.org>; Sat, 26 Sep 2020 12:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhaRNiCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgIZMsA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 26 Sep 2020 08:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgIZMsA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 26 Sep 2020 08:48:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BB1C0613CE;
        Sat, 26 Sep 2020 05:48:00 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so6836494wrx.7;
        Sat, 26 Sep 2020 05:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5iK8RTd/hZzrA+71AIsly33K52cZ+ekEJK/vPtSCPI=;
        b=mhaRNiCnuAPccKzv172Ime5NOJez0GvNvUIPJTGsUcWUMzktTmhEBBj0W5uHNAJHja
         gI8JvRXb062R+JeyfctHxBcUNQSJqsR1sFkdhrB9n5LUvdsiP6tAvKHJ5wRdHbApuqVL
         m3qWVE9TxcfznXibvvkT8WzJDcnc6UObGqnScfs2OTWBR6tqx3XPxf50XzD4r7V/9/d/
         ZisUPhgIal9FPlS+p+aLwPXpLcakSIKJgfpGdSAAfArmCfbgYLOXfmVxVBqrEMULHwD0
         Gh+9aruCQ1WHm/e6hJLojDMFWroioIqKpTTo/SSjeIcv2T6eLjsJatiS4CO41vH1dQF/
         cG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5iK8RTd/hZzrA+71AIsly33K52cZ+ekEJK/vPtSCPI=;
        b=GC9sWbwvVLIfs8Kk22evY1G2n0I/uLty8mgLhfA3HkxOIbwOyUnRXMYpdjpqKJcXgf
         Vl0Cw9UijwhUAGNTfE2N0+drKVxk/YGjmrERLIb8oIPYzJA4/3I/iMPKlyJZmWyo1SLt
         eV3tcrO/A8p6TOJsTCxHIT/07EendVkXT/l45VMfky+5abrRyOolfLYu6LBdKdg3idmo
         a6HR5KdDaLInOccLQZNJrieLdSL/Pdr4pSNlq8z0kP0XMZKK4/swToqsTvrauhCucXgG
         5QUqRa1TyYe3PQu/JWWcqt1vy9hoLyeSR6iqKxno7qnqjbAgA6FBRXWIFXbGosP9VNdf
         t11g==
X-Gm-Message-State: AOAM532XBcogkwKBhP6gjJQeKYNZLaw7KTytmG7PnKzYmmSZUeUpoyBl
        TsGuZ7ygGqXX8XMlZ5zVPFU=
X-Google-Smtp-Source: ABdhPJwPcw05RM4NWxOXiyvYH/v7tutGpGWSIdz6+/p3AN+5Lng+64UIyYWYj9VmUctx7ZfKKP1w5g==
X-Received: by 2002:a5d:43cf:: with SMTP id v15mr9579562wrr.269.1601124478834;
        Sat, 26 Sep 2020 05:47:58 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id i15sm6909901wrb.91.2020.09.26.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 05:47:58 -0700 (PDT)
From:   kholk11@gmail.com
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, rydberg@bitmath.org, priv.luk@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>
Subject: [PATCH 0/3] Add Novatek NT36xxx touchscreen driver
Date:   Sat, 26 Sep 2020 14:47:44 +0200
Message-Id: <20200926124747.12465-1-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: AngeloGioacchino Del Regno <kholk11@gmail.com>

This patch series adds support for the Novatek NT36xxx Series' In-Cell
touchscreen (integrated into the DriverIC).

This patch series has been tested against the following devices:
 - Sony Xperia 10        (SDM630 Ganges Kirin)
 - Sony Xperia 10 Plus   (SDM636 Ganges Mermaid)

AngeloGioacchino Del Regno (3):
  dt-bindings: Add vendor prefix for Novatek Microelectronics Corp.
  Input: Add Novatek NT36xxx touchscreen driver
  dt-bindings: touchscreen: Add binding for Novatek NT36xxx series
    driver

 .../input/touchscreen/novatek,nt36xxx.yaml    |  56 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/nt36xxx.c           | 741 ++++++++++++++++++
 drivers/input/touchscreen/nt36xxx.h           | 122 +++
 6 files changed, 934 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/novatek,nt36xxx.yaml
 create mode 100644 drivers/input/touchscreen/nt36xxx.c
 create mode 100644 drivers/input/touchscreen/nt36xxx.h

-- 
2.28.0

