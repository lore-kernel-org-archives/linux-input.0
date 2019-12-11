Return-Path: <SRS0=YbS0=2B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03375C2D0C6
	for <linux-input@archiver.kernel.org>; Wed, 11 Dec 2019 15:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33E924654
	for <linux-input@archiver.kernel.org>; Wed, 11 Dec 2019 15:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078898;
	bh=qmbYQIA69e1e8/KqodMHdFAL6GQBeBbTtVfmcEMkdpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AwW+MfxuPLV3nRR39qIy6IuxVbtdarvFG+F+vr/ypp+hQebt0ClJan9VJW70lG8FT
	 murPU+jTt9hbDpg1LPfQ7VE+5Z7dwpk5CMz3W+4vT+cjPHg/tCI+uavVV1/+ZekdJj
	 shqBASFabGiSZSqOkjnbNlmvjpYPVYl4Ge9pqAO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbfLKPlc (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbfLKPfO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Dec 2019 10:35:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C62B24656;
        Wed, 11 Dec 2019 15:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078514;
        bh=qmbYQIA69e1e8/KqodMHdFAL6GQBeBbTtVfmcEMkdpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g3YY/Tog2ZHAqn+qh97xNisb9CtbdVG0Tgn7qr8Y/aEK4CtT4OOaUHaaiWplKOiB0
         fDDK4s9gSIuDwZ/EdaHBkEJwEPzxrc8gCe21zzuTnH1TFh858ZiYQOBWrBHnyqVzhI
         tqmMy5CRwltJ83lUcj0zrSwpmnifdaSx6CTelNfw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 03/42] Input: atmel_mxt_ts - disable IRQ across suspend
Date:   Wed, 11 Dec 2019 10:34:31 -0500
Message-Id: <20191211153510.23861-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211153510.23861-1-sashal@kernel.org>
References: <20191211153510.23861-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

[ Upstream commit 463fa44eec2fef50d111ed0199cf593235065c04 ]

Across suspend and resume, we are seeing error messages like the following:

atmel_mxt_ts i2c-PRP0001:00: __mxt_read_reg: i2c transfer failed (-121)
atmel_mxt_ts i2c-PRP0001:00: Failed to read T44 and T5 (-121)

This occurs because the driver leaves its IRQ enabled. Upon resume, there
is an IRQ pending, but the interrupt is serviced before both the driver and
the underlying I2C bus have been resumed. This causes EREMOTEIO errors.

Disable the IRQ in suspend, and re-enable it on resume. If there are cases
where the driver enters suspend with interrupts disabled, that's a bug we
should fix separately.

Signed-off-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index c2fb0236a47cc..8d871fcb7912a 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3206,6 +3206,8 @@ static int __maybe_unused mxt_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
+	disable_irq(data->irq);
+
 	return 0;
 }
 
@@ -3218,6 +3220,8 @@ static int __maybe_unused mxt_resume(struct device *dev)
 	if (!input_dev)
 		return 0;
 
+	enable_irq(data->irq);
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-- 
2.20.1

