Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B383C47094
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29E2613C8
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhFGQ2C (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233727AbhFGQYX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Jun 2021 12:24:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B29DD61467;
        Mon,  7 Jun 2021 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082548;
        bh=uiI51N416hgyuMaff2alU9ZbZwuhNR44gZ6RjN+11hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzczQcqGmNmMoHYG1cp99FfgdHZSX6t6gFPcjta5ikCK368Ckuy4h1Nx4zFEMN0Q5
         DcqLq7uJyvCzmRfBAydax0BdslTumvLrpcB//DeNvKdugH6IyM6RC7a6aVLmgKvgFR
         txex32cPKWswRgzaG561+3vrAztBN/2J+AOyL4llSgD2FBgfOqde2G01v6wv0PeCz4
         8ToocuyDHTd7n7iO4VK1LKK4nbbHlQJuUSrkGDyZYHff7Nc43MrWY6qYzL5h3/37xS
         uhVCkq0NBrZGbLoF4egV6zV0eZj9zJNsAoE0RUu7E0Uz7L+HXtyhmr6xHJyWRAyQWH
         iVq3UDed9vkYw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Bolhuis <mark@bolhuis.dev>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 03/15] HID: Add BUS_VIRTUAL to hid_connect logging
Date:   Mon,  7 Jun 2021 12:15:31 -0400
Message-Id: <20210607161543.3584778-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161543.3584778-1-sashal@kernel.org>
References: <20210607161543.3584778-1-sashal@kernel.org>
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
index 40b36e59a867..a056850328ef 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1804,6 +1804,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
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

