Return-Path: <SRS0=ydAt=DE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF0C47423
	for <linux-input@archiver.kernel.org>; Sun, 27 Sep 2020 12:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2921423976
	for <linux-input@archiver.kernel.org>; Sun, 27 Sep 2020 12:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBd66uAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgI0Mfy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 27 Sep 2020 08:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0Mfy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 27 Sep 2020 08:35:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A960AC0613CE;
        Sun, 27 Sep 2020 05:35:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so3635645wmi.1;
        Sun, 27 Sep 2020 05:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SES3DZ4a0IImJFsUJIvWgnAMy9Zb1WlVH702l/NNI7U=;
        b=SBd66uAMWJzhyUq/17TPpwJ6JRaH9vkRwbCsPbPLaCxe1JRaJGU7L2hem51LqBclmS
         YQfV+rCj57WDXd+rA8VhzzyA1AewQc6NsIW1s7Al1DQlKxdjHYWhfZqxxuolM0BsOAZj
         KMjqaQ2D0ksMGH0c5uSP4GqN6KssFZCKMoUd57tDuKip/fqQBirW2GcQsA7u/LnuTQW+
         pRQPOcy8/h36aroFICA+h66B+YH6fNqZndN7hOiw0tIXyU/7Owze00sazhtEPvdSj2IT
         pbkgAUebuNEDFruk3HHtUHzBTdXHecpG6JdU4BcwPdDa9pK+XQ4gg/Ch3N3kLT1U2pZc
         ++fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SES3DZ4a0IImJFsUJIvWgnAMy9Zb1WlVH702l/NNI7U=;
        b=Qjmak8vR04xJd1UqJONIcXceihbTzixbcRn19YFwkCogyLxwnnMKwK1yc6S/9n3JHZ
         QZ3dIBY9ZXIfYSgilRmqzMeeoJXTN+DtW+J60gQWX7jY0xRBh5C/gbw0w5L7tbft0KpD
         k0JnqGB8tO1Zhg9p8MUVIXuryyrWm7ZjNn3jtaB3mDUur1W1sZ71oLs65LbZil0jaOXf
         NYBgumvt+00/FYrDu3V7+8vxJWYW8x5NtpTJOSQakt3mewKSywEu4uDimq55NbuN62mL
         Yw5+WkOhkcvARqn3sKMqJxDLUH64icGwh9ddi266V+J6FG2aL0txPXIh7s3RjgoZayz4
         oCVQ==
X-Gm-Message-State: AOAM530LRBDZsA/yu8o/m65K8+r8KsF64VP0JUTFOzRsuiPrnjioZUaq
        2QxnF+3/ERDtEGzjubMpti4=
X-Google-Smtp-Source: ABdhPJyf3xFJ4IgWwgAsinRT1W5gv8ZMpnNcHu6EDP4QCLudZTHmf+FNYshzNeuWsd9pC1jC8Cdh1A==
X-Received: by 2002:a7b:c307:: with SMTP id k7mr7109490wmj.31.1601210152228;
        Sun, 27 Sep 2020 05:35:52 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id y6sm9470090wrn.41.2020.09.27.05.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 05:35:51 -0700 (PDT)
From:   kholk11@gmail.com
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, rydberg@bitmath.org, priv.luk@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kholk11@gmail.com, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, phone-devel@vger.kernel.org
Subject: [PATCH v2 0/3] Add Novatek NT36xxx touchscreen driver
Date:   Sun, 27 Sep 2020 14:35:39 +0200
Message-Id: <20200927123542.553852-1-kholk11@gmail.com>
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

Changes in v2:
- Fixed sparse warnings from lkp kernel test robot

AngeloGioacchino Del Regno (3):
  dt-bindings: Add vendor prefix for Novatek Microelectronics Corp.
  Input: Add Novatek NT36xxx touchscreen driver
  dt-bindings: touchscreen: Add binding for Novatek NT36xxx series
    driver

 .../input/touchscreen/novatek,nt36xxx.yaml    |  56 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/input/touchscreen/Kconfig             |  12 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/nt36xxx.c           | 742 ++++++++++++++++++
 drivers/input/touchscreen/nt36xxx.h           | 122 +++
 6 files changed, 935 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/novatek,nt36xxx.yaml
 create mode 100644 drivers/input/touchscreen/nt36xxx.c
 create mode 100644 drivers/input/touchscreen/nt36xxx.h

-- 
2.28.0

