Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA6C433F5
	for <linux-input@archiver.kernel.org>; Mon, 14 Mar 2022 16:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbiCNQRL (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiCNQRK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Mar 2022 12:17:10 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B62403EB;
        Mon, 14 Mar 2022 09:15:59 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id d64so17661242vsd.12;
        Mon, 14 Mar 2022 09:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NnlFNsg5jkf0JsAgMwSQZVO9GjEPit61Z1QWDLThAzE=;
        b=fYUqM6CJFAFX9w4Y37xWWlbZmfgm5Cf8oDC9yL03HZ7+KyyOSvcLRhwlU+kxxqxud+
         K5LMZZerXToo7xsqX96ED9VOoIZcZTFQ2ZnHc9ko/bTLxG6lU2BXCf3LLvG6JSj5FlVh
         4k0K/iJn3cpnPfF/+Yx0z3yRkKKOBSdsNHgFEOyNRsA+JNuaP/ijAqNB0OlEI5YxP5pE
         YdIJYT01DTdoFSf5anRuPZU9/LsM4kT6m3+6aSSiZe5TRNLyAxBCBTBtT1/W9iFJ/KKt
         6hoj1FvkJEbUcr+Nmic/CtpS/5/ZvuO6NAoTXxq+CZqbjkQMs9vP2aZdYNxMydsZchX4
         MWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NnlFNsg5jkf0JsAgMwSQZVO9GjEPit61Z1QWDLThAzE=;
        b=C6jvKi+MCRLg8Vjf5EdUcFa7teoppRUkztmSMT9AiVW9hz3QceXYuJIxnqkmQtHcCG
         Gb0yePrywKpQZKTYGGcrbblfbNTnCq/+znLsi/se8eaVPlrvM2EoQSFny3Mpwkj8wv2o
         /I7mnsMmVEnIiwBy1HBV4wdME5fNln1a9+bN6PL7sjM5+tzNx9QIpfnZvCu6tMtA2kSL
         ACGQrcs//aPPU4K8we0NqWGQZPVaBssb0XqxnGzwwtJuxtAOT6DybsES5F6TUOatHRXS
         6A4xL6Lr5ML+qSQFoK8oNS6JfD9ndFUryiJt6KBWgAoO8dahopOg/gKvaeBXOjcAzlR6
         CZiQ==
X-Gm-Message-State: AOAM530N2ElZET+HWzREgtFGk01tGaNFivBuR4qEva+k4vBNgWYh9hZr
        KGQEiTRPqvYNKSy5oLJUaXCTBk7IckVUL2XEmq9dQ621tWOJ2A==
X-Google-Smtp-Source: ABdhPJx5dR5maKv5Y7f7HYvW0S7Q6Haci5XRR1MFB0RImjjyyVNbm/mYU5lzuU1mooDqnSR4gHW+88EL1EASyTx/Kv4=
X-Received: by 2002:a05:6102:32c8:b0:322:b329:bda9 with SMTP id
 o8-20020a05610232c800b00322b329bda9mr8270400vss.83.1647274558487; Mon, 14 Mar
 2022 09:15:58 -0700 (PDT)
MIME-Version: 1.0
From:   Josh Kilmer <srjek2@gmail.com>
Date:   Mon, 14 Mar 2022 11:15:50 -0500
Message-ID: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
Subject: [PATCH] hid: asus: ROG NKey: Ignore portion of 0x5a report
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Josh Kilmer <srjek2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On an Asus G513QY, of the 5 bytes in a 0x5a report, only the first byte
is a meaningful keycode. The other bytes are zeroed out or hold garbage
from the last packet sent to the keyboard.

This patch fixes up the report descriptor for this event so that the
general hid code will only process 1 byte for keycodes, avoiding
spurious key events and unmapped Asus vendor usagepage code warnings.

Signed-off-by: Josh Kilmer <srjek2@gmail.com>
---
 drivers/hid/hid-asus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 08c9a9a60ae4..73fb9fc0701c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1212,6 +1212,14 @@ static __u8 *asus_report_fixup(struct
hid_device *hdev, __u8 *rdesc,
        rdesc = new_rdesc;
    }

+   if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
+           *rsize == 331 && rdesc[190] == 0x85 && rdesc[191] == 0x5a &&
+           rdesc[204] == 0x95 && rdesc[205] == 0x05) {
+       hid_info(hdev, "Fixing up Asus N-KEY keyb report descriptor\n");
+       // On the 0x5A input report, change count from 5 to 1
+       rdesc[205] = 0x01;
+   }
+
    return rdesc;
 }

-- 
2.35.1
