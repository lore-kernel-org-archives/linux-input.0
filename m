Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E36BC352A6
	for <linux-input@archiver.kernel.org>; Sun, 20 Dec 2020 03:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CBA923A5E
	for <linux-input@archiver.kernel.org>; Sun, 20 Dec 2020 03:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgLTDh5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 19 Dec 2020 22:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgLTDga (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 19 Dec 2020 22:36:30 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/3] Input: cros_ec_keyb - send 'scancodes' in addition to key events
Date:   Sat, 19 Dec 2020 22:35:30 -0500
Message-Id: <20201220033531.2728916-2-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201220033531.2728916-1-sashal@kernel.org>
References: <20201220033531.2728916-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 80db2a087f425b63f0163bc95217abd01c637cb5 ]

To let userspace know what 'scancodes' should be used in EVIOCGKEYCODE
and EVIOCSKEYCODE ioctls, we should send EV_MSC/MSC_SCAN events in
addition to EV_KEY/KEY_* events. The driver already declared MSC_SCAN
capability, so it is only matter of actually sending the events.

Link: https://lore.kernel.org/r/X87aOaSptPTvZ3nZ@google.com
Acked-by: Rajat Jain <rajatja@google.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/cros_ec_keyb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index b01966dc7eb3d..44a5a5496cfd0 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -137,6 +137,7 @@ static void cros_ec_keyb_process(struct cros_ec_keyb *ckdev,
 					"changed: [r%d c%d]: byte %02x\n",
 					row, col, new_state);
 
+				input_event(idev, EV_MSC, MSC_SCAN, pos);
 				input_report_key(idev, keycodes[pos],
 						 new_state);
 			}
-- 
2.27.0

