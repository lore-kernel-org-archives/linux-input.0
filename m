Return-Path: <SRS0=Nb3C=7S=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50533C433DF
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265E82070B
	for <linux-input@archiver.kernel.org>; Fri,  5 Jun 2020 12:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591360283;
	bh=FD53rO+fysM1m9xUdrgMsKK/8LhBRRYiQHHK8cczxf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ihpa4QArjqQQ9BQBgoFegabd2KSxj+NcfVrdKmW3Oo8EyfxOfxd9ZG4Dne8p7GpYn
	 TKlUXCGSUo9dKH3QDi1irbBPUymdM9qHFQ2Sk/Aj9qGz6Q+vIxD4pvQa7YHJkDVzds
	 rH+ihUwDgACI+kiKoKmpGT3BjRwC0V0AsbTCETzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgFEMbG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbgFEMZ2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 Jun 2020 08:25:28 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B532075B;
        Fri,  5 Jun 2020 12:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591359927;
        bh=FD53rO+fysM1m9xUdrgMsKK/8LhBRRYiQHHK8cczxf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B70yODDd7wQl2vWN2smv+NosjoHSNkrI+P4EXnF7bIuUVwPGhG7c9GZns4LqPo0Wr
         rGzM93O1GQsP6m93NN6ns7ErEod6I1YG4/h1LQcPO/Kd1hf6rJqjuL2vmIoaVgihgd
         0LN4w7Ic6yRR/XNsghXR1xLAYd4c2+2LQWtGERVo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dennis Kadioglu <denk@eclipso.email>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 08/17] Input: synaptics - add a second working PNP_ID for Lenovo T470s
Date:   Fri,  5 Jun 2020 08:25:07 -0400
Message-Id: <20200605122517.2882338-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200605122517.2882338-1-sashal@kernel.org>
References: <20200605122517.2882338-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dennis Kadioglu <denk@eclipso.email>

[ Upstream commit 642aa86eaf8f1e6fe894f20fd7f12f0db52ee03c ]

The Lenovo Thinkpad T470s I own has a different touchpad with "LEN007a"
instead of the already included PNP ID "LEN006c". However, my touchpad
seems to work well without any problems using RMI. So this patch adds the
other PNP ID.

Signed-off-by: Dennis Kadioglu <denk@eclipso.email>
Link: https://lore.kernel.org/r/ff770543cd53ae818363c0fe86477965@mail.eclipso.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 4d2036209b45..758dae8d6500 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN005b", /* P50 */
 	"LEN005e", /* T560 */
 	"LEN006c", /* T470s */
+	"LEN007a", /* T470s */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */
 	"LEN0073", /* X1 Carbon G5 (Elantech) */
-- 
2.25.1

