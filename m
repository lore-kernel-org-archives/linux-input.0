Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD68C433EF
	for <linux-input@archiver.kernel.org>; Mon, 18 Apr 2022 11:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiDRLoV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 18 Apr 2022 07:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiDRLoV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Apr 2022 07:44:21 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92954DFFD
        for <linux-input@vger.kernel.org>; Mon, 18 Apr 2022 04:41:42 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id q3so17647633wrj.7
        for <linux-input@vger.kernel.org>; Mon, 18 Apr 2022 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEmwddWNrln8o5MIbMhjcLSkBL4WLbIhWOW4+t0x+vo=;
        b=AJvL1K/+t23+hXQuSCG+KS8bxKKhS0C/EArkq09orOWUPUN7T98MPDZCKjpYEV1spS
         St+I9b5PS4f8PISkr/ev+WRei6ILzhKgDizxKEpl1X7PRjzFlYF2fRt7WUtkZ2UfEFAR
         p9qVCPJwRMLCJiH+zSNjZDrnSEU9GXCl/txJM2KLjPLayw+eypIHwuh+sd4KqnDJSrwL
         7KZYRW+X5hvudhyYOJAMCrFukqa3aELRj7Jwi3tOfEcLqLlG+IltO08aR3w1+hCN67e9
         RSnl/vWP1vTslNFUpkKkKGf/ONnXxhGZlZOcZU6vN0bZDoTSxMOvOgwQuRHEwFyCM8eT
         BCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pEmwddWNrln8o5MIbMhjcLSkBL4WLbIhWOW4+t0x+vo=;
        b=IcFpxStSfyxQslRWs9e8wEezDvxEurYVyVqfNS9mt39EcV1WHMGjmkVPOLo/uum/9d
         Or1eG8bNu35pLrfi1QKLeWCKDggKMP1uqFTyfOp1YdeZ3cyDQPQpVmYI/TgHI2qwQJv/
         UYzziOot9e5xP1KRzQo5pL286Z1TYBqSOybtYBcGm3j0jprs/9B68641rw6iWcjcqKJ6
         N7bmxXbaX5KpyevGZ96KjIzuO4edguoytEJcUvVoqffW34rUpNS2uNUli8hWr6wLvdg/
         HdVaLAmU/CiBfWMbenfwaREro3Qrr3uc5a9S+xJMyplv+1oqhXyh2EFphqeYUe2mMjm0
         WwTA==
X-Gm-Message-State: AOAM530diA1nj/z6DntI5DOhaMz1EmF+SRQ09KzwNWKN2z95ur2C/Kzz
        RJSyR1ZL21lijGcJ1HlqA8F0deAxbXswcQ==
X-Google-Smtp-Source: ABdhPJxPQMtR+z4Q2ZTAcjvgZ6NgsNhVYnlqgT12k3iHDVPHej+aPyFvyeXUk716PTLKcCPzCyitVQ==
X-Received: by 2002:a05:6000:1e08:b0:20a:873f:13b3 with SMTP id bj8-20020a0560001e0800b0020a873f13b3mr7258288wrb.52.1650282101084;
        Mon, 18 Apr 2022 04:41:41 -0700 (PDT)
Received: from deepwhite.fritz.box ([2001:9e8:2205:7500:31a3:8b23:14e3:7ccf])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b00207b49d3023sm10007211wrq.44.2022.04.18.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:41:40 -0700 (PDT)
From:   Pavel Rojtberg <rojtberg@gmail.com>
X-Google-Original-From: Pavel Rojtberg < rojtberg@gmail.com >
To:     linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org
Cc:     Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH v2 0/3] Input: xpad - sync with github fork
Date:   Mon, 18 Apr 2022 13:40:19 +0200
Message-Id: <20220418114022.23673-1-rojtberg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Pavel Rojtberg <rojtberg@gmail.com>

This upstreams some changes contributed on github.
The first patch merely updates the list of supported devices.
Compared to github and v1, sorting of the lists is preserved.

The remaining patches improve xbox360w gamepad support.
Those were verified by me, as I own that device.

Cameron Gutman (1):
  Input: xpad - fix wireless 360 controller breaking after suspend

Pavel Rojtberg (1):
  Input: xpad - add supported devices as contributed on github

Santosh De Massari (1):
  Input: xpad - Poweroff XBOX360W on mode button long press

 drivers/input/joystick/xpad.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

-- 
2.25.1

