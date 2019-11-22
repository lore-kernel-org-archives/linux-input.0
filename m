Return-Path: <SRS0=Zkgr=ZO=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEAFC432C0
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB8420708
	for <linux-input@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574400642;
	bh=lYgW7XNs/bbUDwrVycp3txPbcFxD4o6rSDmCKbDXXEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pFA6q60z1GiTpij5ee9fQszP3eROPk+gRwfmQx88H81e2FSNNjvk4PCH+v6GrIKvC
	 SJSgvFH6a/6Qj/FEuw+l3fruFs5Ptfh6wjGANBvD+jojb8bPK8+ng7Wal8i3uTBSu2
	 LaczKO6qPgpQi54qTTxdHW+DRMEOhfvw9mPNfqlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfKVFaf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:30:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfKVFaX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Nov 2019 00:30:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A500920718;
        Fri, 22 Nov 2019 05:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400623;
        bh=lYgW7XNs/bbUDwrVycp3txPbcFxD4o6rSDmCKbDXXEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSPdlMAvEHKIRhIficCSyYErNuz6msqkIeq8LPWyFw2PsJ/NEtoGBudmZwsH6krEp
         EA+ElGsuHnHEG98aROevsKgnpuJRpbspwUoOrA2svB/me72yvlDOjWcTaped68gjfD
         kf2p/YPhT8Ye/wHMa58WBZnAW10C22CzhmR/acFQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        linux-parisc@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 022/219] parisc: Fix serio address output
Date:   Fri, 22 Nov 2019 00:26:44 -0500
Message-Id: <20191122053001.752-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122053001.752-1-sashal@kernel.org>
References: <20191122053001.752-1-sashal@kernel.org>
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
index 49d8d53e50b7b..96f9b5397367f 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -381,9 +381,9 @@ static int __init gscps2_probe(struct parisc_device *dev)
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

