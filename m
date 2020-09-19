Return-Path: <SRS0=rMy9=C4=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B06C43463
	for <linux-input@archiver.kernel.org>; Sat, 19 Sep 2020 21:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAE62311B
	for <linux-input@archiver.kernel.org>; Sat, 19 Sep 2020 21:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="XQpj98Rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgISVtu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 19 Sep 2020 17:49:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:23572 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgISVtu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 19 Sep 2020 17:49:50 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Bv3zz3X9nzHF;
        Sat, 19 Sep 2020 23:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1600551681; bh=ohM0S5ClFb6UySWMV75NN+FkUbDrXk65gXVg9hT1xAA=;
        h=Date:From:Subject:To:Cc:From;
        b=XQpj98RxtKaxt2PSLkQXZ9uO037mi2jsvWmIu/QDSObGyXJGJz0gxXhBZKG3ugCIG
         k499OMEcfVNvskvO7wVDzS/L1q7vhisp9BIhOm9tP/OPd+u4GbsxjvzIK/ghXwcBgS
         F3QI+YqSECGE4MhMpRUAi41g+0HYa0b3sy72TV5KUCjHUsPMzKH7tZAWT77hUX2Ibc
         /Ym0IhglU68TjdIVIz+WbUI7Q+WgvLk2rx8Zq/AcZm8uDZ48iw4WdK84RWiJoU/bcj
         a6wI4Q0RyZFlStTsZAmlOCfmz+/U98MadxxU3+tHAdWV8daFztGIoTKNUnrKypL6P2
         PKrFTY/Irh4lg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 19 Sep 2020 23:41:19 +0200
Message-Id: <cover.1600551334.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v7 0/4] input: elants: Support Asus TF300T and Nexus 7 touchscreen
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        James Chen <james.chen@emc.com.tw>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Scott Liu <scott.liu@emc.com.tw>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This series cleans up the driver a bit and implements changes needed to
support EKTF3624-based touchscreen used in Asus TF300T, Google Nexus 7
and similar Tegra3-based tablets.

---
v2: extended with Dmitry's patches (replaced v1 patches 3 and 4)
v3: rebased for v5.7-rc1
v4: rebased onto v5.7-rc2+ (current Linus' master)
    update "remove unused axes" and "refactor
      elants_i2c_execute_command()" patches after review
    add David's patch converting DT binding to YAML
v5: rebased onto dtor/input/for-linus
v6: rebased onto newer dtor/input/for-linus
    remove yet unused constants from patch 1
    added a new drive-by cleanup (last patch)
v7: rebased onto current dtor/input/for-next
---

Dmitry Osipenko (1):
  input: elants: support 0x66 reply opcode for reporting touches

Michał Mirosław (3):
  input: elants: document some registers and values
  input: elants: support old touch report format
  input: elants: read touchscreen size for EKTF3624

 drivers/input/touchscreen/elants_i2c.c | 149 +++++++++++++++++++++----
 1 file changed, 127 insertions(+), 22 deletions(-)

-- 
2.20.1

