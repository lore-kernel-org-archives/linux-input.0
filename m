Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA9BC43461
	for <linux-input@archiver.kernel.org>; Mon, 19 Apr 2021 20:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CC4613B4
	for <linux-input@archiver.kernel.org>; Mon, 19 Apr 2021 20:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhDSUpX (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 19 Apr 2021 16:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242593AbhDSUoy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Apr 2021 16:44:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BCB1613C6;
        Mon, 19 Apr 2021 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618865064;
        bh=1H3mngB1wziDnZrSCLkVf32m5DqRuWUfzlvhLfR7xXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnKxje98OgjIBpS7pkh8bvQCPrvcXrDL1rRAfwSWL8EZmPtf5vMRSrnstT8qWgV8j
         0jqKWSnixDEN6FX0ggOEfEU+ymanh5GkY24TcUTo/OGpnuc5Fl7MMqDup4QWa59f+3
         YKvOHFsroLRA+30mVS7DoKpxXlUCdioXC2E/rVPRAT+CjCgWhEnPqM9sNk8y7/pbr1
         XJzx2mfqecAZXVpzZne/g0umkX9HjaRtBrLZmhcuc2ztNGPfVl5YcjQJmqZlvbMKNj
         ABNFe+fK/kcW1xkBC7HEdJA7bKjCHfDjy2ZWgHai3rQJ1Ow/705WUzOEuGary5iE8T
         ifI1wxgu15Nqw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        TOTE Robot <oslab@tsinghua.edu.cn>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 02/21] HID: alps: fix error return code in alps_input_configured()
Date:   Mon, 19 Apr 2021 16:44:00 -0400
Message-Id: <20210419204420.6375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419204420.6375-1-sashal@kernel.org>
References: <20210419204420.6375-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit fa8ba6e5dc0e78e409e503ddcfceef5dd96527f4 ]

When input_register_device() fails, no error return code is assigned.
To fix this bug, ret is assigned with -ENOENT as error return code.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 3feaece13ade..6b665931147d 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -761,6 +761,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 		if (input_register_device(data->input2)) {
 			input_free_device(input2);
+			ret = -ENOENT;
 			goto exit;
 		}
 	}
-- 
2.30.2

