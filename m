Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9586C432C0
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FEC2068F
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402939;
	bh=pBD8D54Jh+aAZ584Gec2gIdMiQfp2n7SefwZdXpySxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ro1okB4RWfU/1AGX0ZfzFbM05e6yGTHuNKpXASQaabeoEAecmU1Oihb+Khq2HCrfi
	 x6w6//R3vnHsfnXVMJAycpY4tsNfWHqBOO2dJYDJf15FHwHAOmBnxibVC3bWFA4UqQ
	 LSWqOezsl37NzdImtITRi/fDkgR4nPDTXP90ijuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfKVGBe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:01:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfKVGBe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44612070A;
        Fri, 22 Nov 2019 06:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402493;
        bh=pBD8D54Jh+aAZ584Gec2gIdMiQfp2n7SefwZdXpySxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gs9+VEyi7nfmonYyAFtJgDkzTAJb/i0+KJtvU6MfiTE5NwqoOQEspmt5nfGvXxEho
         /uzQg2OSo+MKjdFgoBa47xZHmXKTqLY6+URmHGi2JNm17WViPAZ51adaaqCjVst7kW
         URVULmlwDbBNo/85mcImZHrJbe+8dxEdengYzvv0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        linux-parisc@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 04/91] parisc: Fix serio address output
Date:   Fri, 22 Nov 2019 01:00:02 -0500
Message-Id: <20191122060129.4239-3-sashal@kernel.org>
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

[ Upstream commit 785145171d17af2554128becd6a7c8f89e101141 ]

We want the hpa addresses printed in the serio modules, not some
virtual ioremap()ed address, e.g.:

 serio: gsc-ps2-keyboard port at 0xf0108000 irq 22 @ 2:0:11
 serio: gsc-ps2-mouse port at 0xf0108100 irq 22 @ 2:0:12

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/gscps2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index ecba666afadb7..cca26e6f38b36 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -382,9 +382,9 @@ static int gscps2_probe(struct parisc_device *dev)
 		goto fail;
 #endif
 
-	printk(KERN_INFO "serio: %s port at 0x%p irq %d @ %s\n",
+	pr_info("serio: %s port at 0x%08lx irq %d @ %s\n",
 		ps2port->port->name,
-		ps2port->addr,
+		hpa,
 		ps2port->padev->irq,
 		ps2port->port->phys);
 
-- 
2.20.1

