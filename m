Return-Path: <SRS0=RQR1=2U=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF5EC2D0C0
	for <linux-input@archiver.kernel.org>; Mon, 30 Dec 2019 01:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44E02075D
	for <linux-input@archiver.kernel.org>; Mon, 30 Dec 2019 01:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8b1/vz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfL3B1j (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 29 Dec 2019 20:27:39 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37446 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfL3B1j (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 29 Dec 2019 20:27:39 -0500
Received: by mail-yw1-f68.google.com with SMTP id z7so13582313ywd.4
        for <linux-input@vger.kernel.org>; Sun, 29 Dec 2019 17:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+1YaSbA2WuTk6h8tfXdKOEvqNgq48IAaneiPsbWPflQ=;
        b=n8b1/vz4wqJZ4uq2r6YlqOVhRMLbGGHaFKXyUjXqIx1+J2yLB+mBWKxLr8IqhqkRVs
         tz/+J8vHsySCxmCrDrWut9R5XJYLjMlBsBbVzH13fI8mQFYbZzk9lNUdMoNtjwhWIyBp
         94xxX4C335PMblCbasm/2uHmu6xQM1V92eeCJkEMeLUavq/3ZjO0nb46gXxJuurG6VFv
         5GT/ey89sNI9ij7nm1egJv7oM8Uz5+VlmE+7ullMq6CQghcjFnlYLOyLcJ3qACs1i/YX
         KqHG/Tf5LpyuE2h0mM/REvVqwVz/5x0Pns4SqoQ3BTY5XnEEMwPjOOpVS8b6A8wlSL8x
         eL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+1YaSbA2WuTk6h8tfXdKOEvqNgq48IAaneiPsbWPflQ=;
        b=V+mSKoXz0TAYqtval50+iL2hnSMvF4WalynZmIip1elA98FyoSm9JUtF0TFGECFjiS
         2tWe0xwd/uyGELxgaZy0h7byggOCAc5sHFUOO7Ai0iAX0YjuXVt7B6lk2sm3lnhTw0BH
         HUKFZSjyXQ/k2RDWauAVjUA8N5lfV4EBLdlO8A/VYj2z2Hvq1mwc+0IHeWiACCrNUPc4
         f7IcC+vIDygSvv901gJLS7cbphCaEeTz3mEhLfvKwKQWQ4P4R4Ef8H6rxL5stK8ErdKM
         2jMJp0DsTD294F1qW+uq+pYO/MfOv29TnuSTiq9C7/ZeO7rsw2TF55EYGQRSlyMh3HnI
         LglQ==
X-Gm-Message-State: APjAAAVaTH/Yzsyf5AbPG3hTDOFJdzbKQ2kxIb8KAtrJLWfkvK8hemCG
        kUuXMlpWKv/gzziFK1EF4FgUFqq2qEU=
X-Google-Smtp-Source: APXvYqy1P2VdwnzvrudErXxKoz7A7eBCqLu5gGtKNTWV4FRhyMxRYNUCV7ZQdTqt+671nIX4m1D6iw==
X-Received: by 2002:a81:38c3:: with SMTP id f186mr45220187ywa.463.1577669258143;
        Sun, 29 Dec 2019 17:27:38 -0800 (PST)
Received: from Arrakis.djogorchock.com ([136.33.205.58])
        by smtp.gmail.com with ESMTPSA id g11sm17175584ywe.14.2019.12.29.17.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 17:27:37 -0800 (PST)
From:   "Daniel J. Ogorchock" <djogorchock@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     thunderbird2k@gmail.com, blaws05@gmail.com,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        Roderick.Colenbrander@sony.com, svv@google.com, s.jegen@gmail.com,
        carmueller@gmail.com, "Daniel J. Ogorchock" <djogorchock@gmail.com>
Subject: [PATCH v10 09/12] HID: nintendo: patch hw version for userspace HID mappings
Date:   Sun, 29 Dec 2019 19:27:17 -0600
Message-Id: <20191230012720.2368987-10-djogorchock@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230012720.2368987-1-djogorchock@gmail.com>
References: <20191230012720.2368987-1-djogorchock@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patch sets the most significant bit of the hid hw version to allow
userspace to distinguish between this driver's input mappings vs. the
default hid mappings. This prevents breaking userspace applications that
use SDL2 for gamepad input, allowing them to distinguish the mappings
based on the version.

Signed-off-by: Daniel J. Ogorchock <djogorchock@gmail.com>
---
 drivers/hid/hid-nintendo.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 4653a0a10782..b11c27a8e381 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1373,6 +1373,15 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 		goto err_wq;
 	}
 
+	/*
+	 * Patch the hw version of pro controller/joycons, so applications can
+	 * distinguish between the default HID mappings and the mappings defined
+	 * by the Linux game controller spec. This is important for the SDL2
+	 * library, which has a game controller database, which uses device ids
+	 * in combination with version as a key.
+	 */
+	hdev->version |= 0x8000;
+
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret) {
 		hid_err(hdev, "HW start failed\n");
-- 
2.24.1

