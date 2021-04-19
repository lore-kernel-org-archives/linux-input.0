Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB5BC43470
	for <linux-input@archiver.kernel.org>; Mon, 19 Apr 2021 20:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 768AF613B4
	for <linux-input@archiver.kernel.org>; Mon, 19 Apr 2021 20:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242260AbhDSUoY (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242235AbhDSUoV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Apr 2021 16:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A37D761104;
        Mon, 19 Apr 2021 20:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618865031;
        bh=EMSOErM+XGT3IjjPP6q2ENZMPE6YrPXjfhCkysRZ84s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJo498/pjJeujPfYDcIfF/369FjG0EzkjX9YYZ6MxGJMC5MN65SF4v6PpEfLk+PU6
         gjQn0OCQxmAlFOQ2klanNtvOhZ1ifvuVGBZVCZngT8uGCOyWX7OWR3/ctToFyPMmEY
         CDAHKRglm8gRRlCoxeZDMgkipl8OSwoTOsMM3lH5sud+RHiyhXDIObtpQUoMC7vt9H
         Z2oZFbX53CyidBqDKfIJQ9W9wYmaQs4FW56q4nZvvX2BkVlITbNhGBLaEVOklmpqHz
         7Ftp+8KXjjvDMdMeyOvhMJM7nkdp8Kq04vB/l4e+NyigJst/PBP9s/WbG2tu7z5A8D
         Yk8a9yC/Tj7hA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 05/23] HID: wacom: Assign boolean values to a bool variable
Date:   Mon, 19 Apr 2021 16:43:24 -0400
Message-Id: <20210419204343.6134-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419204343.6134-1-sashal@kernel.org>
References: <20210419204343.6134-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>

[ Upstream commit e29c62ffb008829dc8bcc0a2ec438adc25a8255e ]

Fix the following coccicheck warnings:

./drivers/hid/wacom_wac.c:2536:2-6: WARNING: Assignment of
0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 44d715c12f6a..bdd9ba577150 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2533,7 +2533,7 @@ static void wacom_wac_finger_slot(struct wacom_wac *wacom_wac,
 	    !wacom_wac->shared->is_touch_on) {
 		if (!wacom_wac->shared->touch_down)
 			return;
-		prox = 0;
+		prox = false;
 	}
 
 	wacom_wac->hid_data.num_received++;
-- 
2.30.2

