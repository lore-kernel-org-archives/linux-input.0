Return-Path: <SRS0=Jdnn=A7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6CC388F8
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 21:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A05D22C7B
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 21:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281334;
	bh=cG/2WH/UY49/aXW0Api1LLFDIEPIklWAnsPDhfemt+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQxAOqVocGo/1C/ONS7UkvEvudIkICBvhDSs+r/3RmoDobWZ1/LuTuPDg2tTROSit
	 KttnOz/EQudNPmiJfcoYdQ7myCBjRPLCV1/9ItWQgpG544Wegc+KU+z2RQWNq0vIM9
	 vvo7xgqA48XKhQWYEDihbEopvjbY6m0mPbizRDCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGTVmN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgGTVjF (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A0C20717;
        Mon, 20 Jul 2020 21:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281145;
        bh=cG/2WH/UY49/aXW0Api1LLFDIEPIklWAnsPDhfemt+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rKq3GwgXoIuQEgjtAKU4BnEtF8QWR+FWHCFXndVzvg0qGcWDsfpMECVRpNw0Vub3m
         u6QJQPQKdDk521bO5YbQBdfC1xoGs++hFINx61c3d/YCwDNeq42N1C7sNNSPVOx8Q2
         cPFTVweBFFeVNrJ11V8jexRoUKRQEfqneZvIpOek=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ilya Katsnelson <me@0upti.me>, Lyude Paul <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/19] Input: synaptics - enable InterTouch for ThinkPad X1E 1st gen
Date:   Mon, 20 Jul 2020 17:38:42 -0400
Message-Id: <20200720213851.407715-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213851.407715-1-sashal@kernel.org>
References: <20200720213851.407715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Ilya Katsnelson <me@0upti.me>

[ Upstream commit dcb00fc799dc03fd320e123e4c81b3278c763ea5 ]

Tested on my own laptop, touchpad feels slightly more responsive with
this on, though it might just be placebo.

Signed-off-by: Ilya Katsnelson <me@0upti.me>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://lore.kernel.org/r/20200703143457.132373-1-me@0upti.me
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 671e018eb363a..c6d393114502d 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -182,6 +182,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN0093", /* T480 */
 	"LEN0096", /* X280 */
 	"LEN0097", /* X280 -> ALPS trackpoint */
+	"LEN0099", /* X1 Extreme 1st */
 	"LEN009b", /* T580 */
 	"LEN200f", /* T450s */
 	"LEN2044", /* L470  */
-- 
2.25.1

