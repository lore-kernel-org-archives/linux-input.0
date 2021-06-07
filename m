Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5114CC47094
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4D661430
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbhFGQTs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:19:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232708AbhFGQRr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Jun 2021 12:17:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B59F61574;
        Mon,  7 Jun 2021 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082459;
        bh=Q3E8xfbjM05RzuhyWwvnswFZjcREW9jah/3PPBFnvEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4cVuNjHQpgb3isAHAh8iwjYog+s4qNGsHLbBPaYx3krGsTwKpuAeR8bQBEMtM21w
         FJDB8U6WHbOfNYQmeJM49cB0V2oZUfVqd2NPBODuzAhKb1rd5BnJJlJP9X9R2x9dfV
         X3fVi8uu8JM/S8Hyl/1hWMN5pATSkckjndRXDkUYXG2nn3BFgsRp5Kkwl39JHLwaF6
         bEDyt7hcGv/gMPWl4wMjxaC1PSHSwDcRZWogspD38+RBQ4pWrnyHpjJiWMtSwqXEUq
         CogHmXK6UkeGT9KOTaiOr/8QE8pyHwY7hPG4RUkRaKL1bb325HP5kdJ0j88nE8Ejnb
         312AOBOcQDVmw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mark Bolhuis <mark@bolhuis.dev>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/29] HID: Add BUS_VIRTUAL to hid_connect logging
Date:   Mon,  7 Jun 2021 12:13:48 -0400
Message-Id: <20210607161410.3584036-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161410.3584036-1-sashal@kernel.org>
References: <20210607161410.3584036-1-sashal@kernel.org>
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
index 8d202011b2db..550fff6e41ec 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1998,6 +1998,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
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

