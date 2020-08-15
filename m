Return-Path: <SRS0=f1vR=BZ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BFBC433DF
	for <linux-input@archiver.kernel.org>; Sat, 15 Aug 2020 22:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AB720657
	for <linux-input@archiver.kernel.org>; Sat, 15 Aug 2020 22:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgHOWZn (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:25:43 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:51756 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgHOWZm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Aug 2020 18:25:42 -0400
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 51BE23AA8F6
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2020 15:36:29 +0000 (UTC)
X-Originating-IP: 71.82.72.227
Received: from localhost.localdomain (071-082-072-227.res.spectrum.com [71.82.72.227])
        (Authenticated sender: phollinsky@holtechnik.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D23B21C000A;
        Sat, 15 Aug 2020 15:36:07 +0000 (UTC)
From:   Paul Hollinsky <phollinsky@holtechnik.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Paul Hollinsky <phollinsky@holtechnik.com>,
        syzbot+6a1bb5a33a0b128085bc@syzkaller.appspotmail.com
Subject: [PATCH] Input: gtco - fix uninitialized stack read
Date:   Sat, 15 Aug 2020 11:34:27 -0400
Message-Id: <20200815153426.435592-1-phollinsky@holtechnik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

If a malformed HID report is sent from the device, a prefix with
TYPE_MAIN may read globtype before it is written with TYPE_GLOBAL.

The oldval array is protected from uninitialized read by the
indent counter.

Reported-by: syzbot+6a1bb5a33a0b128085bc@syzkaller.appspotmail.com
Signed-off-by: Paul Hollinsky <phollinsky@holtechnik.com>
---
 drivers/input/tablet/gtco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index 44bb1f69b4b2..db030cd043d5 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -217,7 +217,7 @@ static void parse_hid_report_descriptor(struct gtco *device, char * report,
 	__u32 usage = 0;
 
 	/* Global Values, indexed by TAG */
-	__u32 globalval[TAG_GLOB_MAX];
+	__u32 globalval[TAG_GLOB_MAX] = { 0 };
 	__u32 oldval[TAG_GLOB_MAX];
 
 	/* Debug stuff */
-- 
2.25.1

