Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54ABC33C9A
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58B32071B
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402938;
	bh=7Ry9jrHQuYnZY7uOPI526vZCkCbcI2sx4X8O3i8qnwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SfGY0oAuLzd/AhFVsfqVWycd4+CBvOS+a1F01z1Bjtz/IXVvZHNQciF3kmKb/Okgc
	 BrQ/XdCx0MaFXUw2loaZPKoB754xNN6GqGoXQfNWYNmsAx7vHWtIOQqHW/nSCd69V9
	 LunjHQ6Diqy5TdyAK7VuSR6fhGlXExDWs3I5PQPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKVGBf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728926AbfKVGBe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD51B2068F;
        Fri, 22 Nov 2019 06:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402494;
        bh=7Ry9jrHQuYnZY7uOPI526vZCkCbcI2sx4X8O3i8qnwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJw+dbLq3zC1Bhc+ukxiH219Ofj8vSE4zWbkFsZXOcUW8YUOTsTnvajOClPo8mQ5c
         Iimo6oeRkOTj1SHVAuoOLpKpPjTzRqwNNJ9IQGT+pWSum1fa22rcuTA7Rmfz3LjZeD
         B8+zqTHB5W0VQ9BBQHQFJ/LL6jGIfU93up/CjSw0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        linux-parisc@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/91] parisc: Fix HP SDC hpa address output
Date:   Fri, 22 Nov 2019 01:00:03 -0500
Message-Id: <20191122060129.4239-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
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
index 852858e5d8d08..92f541db98a09 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -887,8 +887,8 @@ static int __init hp_sdc_init(void)
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

