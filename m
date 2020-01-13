Return-Path: <SRS0=zvy9=3C=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCECC33CA9
	for <linux-input@archiver.kernel.org>; Mon, 13 Jan 2020 19:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772520CC7
	for <linux-input@archiver.kernel.org>; Mon, 13 Jan 2020 19:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgAMTXM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:23:12 -0500
Received: from orion.archlinux.org ([88.198.91.70]:51316 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMTXM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Jan 2020 14:23:12 -0500
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 7CCB51818448AC;
        Mon, 13 Jan 2020 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [IPv6:2001:8a0:f254:2300:dad6:8c60:8394:88da])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Mon, 13 Jan 2020 19:23:08 +0000 (UTC)
From:   =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH] HID: logitech-dj: add debug msg when exporting a HID++ report descriptors
Date:   Mon, 13 Jan 2020 19:23:00 +0000
Message-Id: <20200113192300.2482096-1-lains@archlinux.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

When exporting all other types of report descriptors we print a debug
message. Not doing so for HID++ descriptors makes unaware users think
that no HID++ descriptor was exported.

Signed-off-by: Filipe Laíns <lains@archlinux.org>
---
 drivers/hid/hid-logitech-dj.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index cc7fc71d8b05..8f17a29b5a94 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1368,6 +1368,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	}
 
 	if (djdev->reports_supported & HIDPP) {
+		dbg_hid("%s: sending a HID++ descriptor, reports_supported: %llx\n",
+			__func__, djdev->reports_supported);
 		rdcat(rdesc, &rsize, hidpp_descriptor,
 		      sizeof(hidpp_descriptor));
 	}
-- 
2.24.1
