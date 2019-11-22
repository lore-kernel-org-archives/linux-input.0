Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12025C432C3
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5192053B
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404230;
	bh=7xewnJeJ8wvHZnKDS85LFPSw2Dl2V6Zdfz+YH65mXK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWj7fX1EiV+wQk0bKlZsSIIUQLOG+T9ayhKUyhov2+JkRXL+BuOnFmsmBBkf617K8
	 MNva3Tq4Rrd0Ttr55HvxVPxzMCRp6PlUrd+5zTW2vE/3UXHCDEFdCA3Uf5LbaRFpqs
	 wBwbTCwReAPgTNbVtAY0GIA2eJH3/l8nq3uE/nEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfKVGa3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfKVFte (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20A220708;
        Fri, 22 Nov 2019 05:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401773;
        bh=7xewnJeJ8wvHZnKDS85LFPSw2Dl2V6Zdfz+YH65mXK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhQlhJCDql3kJuJorBSacp+c0FWqATX77QZg0r9Qrg9HBCTesjn5PgFHrdZhbMfD3
         Kr80N+G0GPF3c04xnxd7gx7an5nfuhfS9Ulj6jTidl3ZrSFgEANu0sivWK/SElmqXf
         AuW4eZfp7iUaYrUpYvUuej3FFH+X89NqTLjTWYeY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        linux-parisc@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 023/219] parisc: Fix HP SDC hpa address output
Date:   Fri, 22 Nov 2019 00:45:55 -0500
Message-Id: <20191122054911.1750-16-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit c4bff35ca1bfba886da6223c9fed76a2b1382b8e ]

Show the hpa address of the HP SDC instead of a hashed value, e.g.:
HP SDC: HP SDC at 0xf0201000, IRQ 23 (NMI IRQ 24)

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/hp_sdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 0b8a25c58d02e..654252361653d 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -884,8 +884,8 @@ static int __init hp_sdc_init(void)
 			"HP SDC NMI", &hp_sdc))
 		goto err2;
 
-	printk(KERN_INFO PREFIX "HP SDC at 0x%p, IRQ %d (NMI IRQ %d)\n",
-	       (void *)hp_sdc.base_io, hp_sdc.irq, hp_sdc.nmi);
+	pr_info(PREFIX "HP SDC at 0x%08lx, IRQ %d (NMI IRQ %d)\n",
+	       hp_sdc.base_io, hp_sdc.irq, hp_sdc.nmi);
 
 	hp_sdc_status_in8();
 	hp_sdc_data_in8();
-- 
2.20.1

