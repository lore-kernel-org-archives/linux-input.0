Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A406C433B4
	for <linux-input@archiver.kernel.org>; Thu, 29 Apr 2021 00:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD4361448
	for <linux-input@archiver.kernel.org>; Thu, 29 Apr 2021 00:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhD2AGr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:06:47 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:39596 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhD2AGr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Apr 2021 20:06:47 -0400
Received: from MTA-14-4.privateemail.com (mta-14.privateemail.com [198.54.118.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id 892A6800E4;
        Wed, 28 Apr 2021 20:06:00 -0400 (EDT)
Received: from mta-14.privateemail.com (localhost [127.0.0.1])
        by mta-14.privateemail.com (Postfix) with ESMTP id 9E89180064;
        Wed, 28 Apr 2021 20:05:58 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.226])
        by mta-14.privateemail.com (Postfix) with ESMTPA id D33FE80061;
        Wed, 28 Apr 2021 20:05:57 -0400 (EDT)
From:   Hamza Mahfooz <someguy@effective-light.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: [PATCH] hid: remove the unnecessary redefinition of a macro
Date:   Wed, 28 Apr 2021 20:05:14 -0400
Message-Id: <20210429000514.11650-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

USB_VENDOR_ID_CORSAIR is defined twice in the same file with the same
value.

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 drivers/hid/hid-ids.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 67fd8a2f5aba..ce8b3c0ef45c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -298,8 +298,6 @@
 
 #define USB_VENDOR_ID_CORSAIR		0x1b1c
 #define USB_DEVICE_ID_CORSAIR_K90	0x1b02
-
-#define USB_VENDOR_ID_CORSAIR           0x1b1c
 #define USB_DEVICE_ID_CORSAIR_K70R      0x1b09
 #define USB_DEVICE_ID_CORSAIR_K95RGB    0x1b11
 #define USB_DEVICE_ID_CORSAIR_M65RGB    0x1b12
-- 
2.31.1

