Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66BBECAAD3
	for <linux-input@archiver.kernel.org>; Sat, 10 Sep 2022 21:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIJVVc (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 10 Sep 2022 17:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiIJVUd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Sep 2022 17:20:33 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6E4C635;
        Sat, 10 Sep 2022 14:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 917DECE0AE3;
        Sat, 10 Sep 2022 21:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF7C433D7;
        Sat, 10 Sep 2022 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662844675;
        bh=FTyZm82ma7c7kIDojvTdLUTSDMwwa3K7yYhHENatSfA=;
        h=From:To:Cc:Subject:Date:From;
        b=hHRXHHqCJnTtnKw6Q+1RbPq6mb+8Q9cu3LRSWJgQTzNcUdFcTYe5Av77alCgwLR8n
         bThq9GpcVAYh3anj7VsW7fXfgzq7+OGVJSaMGdaz0vzo6Kxz6GFfOfRDx1fAoxR9YC
         FkeIyziBdE854Bn903ojAPgstSUuDEX32sEg9DT0LL79XLviH5z7Bhsiu4z4olZI65
         B1EMrJX6oAoVlVcGF/1thCDLV2PAMOMaCgcjA7Ta3ZWAUoEJ5uFc3k5C+T4hCnK+EB
         CZF1oNCslH16l3fxTF9I+xnvRNeg4fw68h18Ne6+nd4GSjruuAWBLHYrRHFi7xShiX
         H5/uxlqDcZ91w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megi@xff.cz>, Jarrah Gosbell <kernel@undef.tools>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, hadess@hadess.net,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/21] Input: goodix - add support for GT1158
Date:   Sat, 10 Sep 2022 17:17:32 -0400
Message-Id: <20220910211752.70291-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

[ Upstream commit 425fe4709c76e35f93f4c0e50240f0b61b2a2e54 ]

This controller is used by PinePhone and PinePhone Pro. Support for
the PinePhone Pro will be added in a later patch set.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20220809091200.290492-1-kernel@undef.tools
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/goodix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3667f7e51fde4..54ea593897466 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -94,6 +94,7 @@ static const struct goodix_chip_data gt9x_chip_data = {
 
 static const struct goodix_chip_id goodix_chip_ids[] = {
 	{ .id = "1151", .data = &gt1x_chip_data },
+	{ .id = "1158", .data = &gt1x_chip_data },
 	{ .id = "5663", .data = &gt1x_chip_data },
 	{ .id = "5688", .data = &gt1x_chip_data },
 	{ .id = "917S", .data = &gt1x_chip_data },
-- 
2.35.1

