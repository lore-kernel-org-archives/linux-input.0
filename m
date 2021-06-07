Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51482C47094
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4005661452
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbhFGQ1y (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231931AbhFGQWj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Jun 2021 12:22:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EC356191E;
        Mon,  7 Jun 2021 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082522;
        bh=F3FKcxUS0Hhd5UVimsvK+206F0Fylqh+F03odRcT37k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=txnQUOrW8sN0O24SRmmYKsEydh/RBC/53Z9Zud3se0aLVKdSJj5UszAkxszZU5SZc
         DOsCe8v5J7IKGqoX5PlMn1gaG6kNGqinwxfWHSilBRAsDGwV4q6eddUZzvQ7CNJqVV
         4Wm1xYs21F1pSBuwIU2ps8BLjLjulasUuZr8CPCnOGuEeA6asP2BH0JfooMNljTIuw
         yBzMU/8FynJ+LkZrn0jeOL7ntTBcWKkY1pCiIEG71mVQ1a2MoC++Q0+y/qMwq+sf5F
         6/EobtVEJzM2o8B2aioQuijVJMFPKo2TJyjBsJzO2vQGk3FYMBRcOIyEIP6Gj2TbWD
         bc/MuBNkbwwzw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Bolhuis <mark@bolhuis.dev>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/18] HID: Add BUS_VIRTUAL to hid_connect logging
Date:   Mon,  7 Jun 2021 12:15:01 -0400
Message-Id: <20210607161517.3584577-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161517.3584577-1-sashal@kernel.org>
References: <20210607161517.3584577-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Mark Bolhuis <mark@bolhuis.dev>

[ Upstream commit 48e33befe61a7d407753c53d1a06fc8d6b5dab80 ]

Add BUS_VIRTUAL to hid_connect logging since it's a valid hid bus type and it
should not print <UNKNOWN>

Signed-off-by: Mark Bolhuis <mark@bolhuis.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 71ee1267d2ef..381ab96c1e38 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1824,6 +1824,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_VIRTUAL:
+		bus = "VIRTUAL";
+		break;
 	default:
 		bus = "<UNKNOWN>";
 	}
-- 
2.30.2

