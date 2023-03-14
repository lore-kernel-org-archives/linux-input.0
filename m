Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2F9C6FD1D
	for <linux-input@archiver.kernel.org>; Tue, 14 Mar 2023 13:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjCNNqU (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 14 Mar 2023 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjCNNqF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2023 09:46:05 -0400
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E33A648F;
        Tue, 14 Mar 2023 06:42:49 -0700 (PDT)
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 2995E10238F;
        Tue, 14 Mar 2023 15:44:02 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (Postfix) with ESMTP id 25F6C10226F;
        Tue, 14 Mar 2023 15:43:42 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.53.223])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 32EChfKV018729;
        Tue, 14 Mar 2023 15:43:41 +0300
From:   Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] Input: synaptics - remove unreachable code
Date:   Tue, 14 Mar 2023 15:43:36 +0300
Message-Id: <20230314124336.1494716-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.0.152.ga5737674b6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
         bases: 20111107 #2745587, check: 20230314 notchecked
X-AV-Checked: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The synaptics_resolution() function always returnd 0.
And there is no need to check its result.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e839ffab0289 ("Input: synaptics - add support for Intertouch devices")
Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 drivers/input/mouse/synaptics.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index fa021af8506e..4f1182bf9667 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -444,9 +444,7 @@ static int synaptics_query_hardware(struct psmouse *psmouse,
 	if (error)
 		return error;
 
-	error = synaptics_resolution(psmouse, info);
-	if (error)
-		return error;
+	synaptics_resolution(psmouse, info);
 
 	return 0;
 }
-- 
2.30.2

