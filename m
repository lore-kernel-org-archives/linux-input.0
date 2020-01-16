Return-Path: <SRS0=ykIa=3F=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED4C33CB3
	for <linux-input@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4282467A
	for <linux-input@archiver.kernel.org>; Thu, 16 Jan 2020 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195210;
	bh=nmFAhrHtoLLCzhzFImZuzpAFjoAw2xKjA7eVQFApg7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zyeg+hAFUVfyyXygCq3D0j1S/o4uao34TPTqOgyg7sH4PKkRK+tS2TwovWyUOGn/c
	 zp1i25aKhvB4EYgxNPVIYROhMxjr6mTq812xNCS83qWfouvGTBUmTh/YyxX8p3e7mm
	 iq2A8lnKHASbsWHPDwBoRdKWT+E3B6FoIu1oaIYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391025AbgAPRSJ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391323AbgAPRSI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Jan 2020 12:18:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D43F2246B1;
        Thu, 16 Jan 2020 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195087;
        bh=nmFAhrHtoLLCzhzFImZuzpAFjoAw2xKjA7eVQFApg7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaH0vZrlXiaROd6SXyJQGFOtKvvQLDJOJmFyUvcf2XD87mNLHnuuBcJhqmx0S3SiS
         DTOWz6h9n2uLgoDVYuD+hk7/B08utiwrUfFmEcDxqRycpHZbunOlKE3foT4BWprv2p
         BIuaoF3oxKo/d9MtcNNFzx/S5UPpHbEOs+6roaIA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 035/371] Input: nomadik-ske-keypad - fix a loop timeout test
Date:   Thu, 16 Jan 2020 12:11:43 -0500
Message-Id: <20200116171719.16965-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116171719.16965-1-sashal@kernel.org>
References: <20200116171719.16965-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4d8f727b83bcd6702c2d210330872c9122d2d360 ]

The loop exits with "timeout" set to -1 not to 0.

Fixes: 1158f0f16224 ("Input: add support for Nomadik SKE keypad controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/nomadik-ske-keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index 8567ee47761e..ae3b04557074 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -100,7 +100,7 @@ static int __init ske_keypad_chip_init(struct ske_keypad *keypad)
 	while ((readl(keypad->reg_base + SKE_RIS) != 0x00000000) && timeout--)
 		cpu_relax();
 
-	if (!timeout)
+	if (timeout == -1)
 		return -EINVAL;
 
 	/*
-- 
2.20.1

