Return-Path: <SRS0=Khrf=ZM=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA314C432C0
	for <linux-input@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B2E2252D
	for <linux-input@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257327;
	bh=mFUdhDkuaiarzva5KnRvrKWe2AuEKsDcucpMmF0l1mM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ECqTkz/qW3zSNXA49+zhFQy4dRZPlOjhcTISTyTvZ7Td+E9uicTSIskgnouwRi51J
	 VNRIvK7gQJYaVuUFc8YaIG/CuocVpv7kdVFkvY9E+t1Fh7RSbdkMcIUsOAnEBn2Gtw
	 RnyBOD8TWhZAPpoJmepk1rLl6Jl8iDO1Bt37AiX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfKTNmC (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbfKTNmB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:01 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04BF72252D;
        Wed, 20 Nov 2019 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257321;
        bh=mFUdhDkuaiarzva5KnRvrKWe2AuEKsDcucpMmF0l1mM=;
        h=From:To:Cc:Subject:Date:From;
        b=PUoZ+BW6RFgt71q1X/DA6Xkz8FHU5iYqH5b69J09/WxxJ3yAaOxHgi5cHZdm+/08A
         YsgIC49dA//F/ZBpb45M4RNqwsojveREIbW8KPAttWLOdpjvPcy4jIcYFiU4pXmndO
         nVYrHPE+P9cTBXimxUfS9Zyw8K790M3YPLA+8xwA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] hid: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:57 +0800
Message-Id: <20191120134157.15474-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/hid/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 494a39e74939..7d4f3b949f9b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -107,7 +107,7 @@ config HID_ACCUTOUCH
 
 	  The driver works around a problem in the reported device capabilities
 	  which causes userspace to detect the device as a mouse rather than
-          a touchscreen.
+	  a touchscreen.
 
 	  Say Y here if you have a Accutouch 2216 touch controller.
 
-- 
2.17.1

