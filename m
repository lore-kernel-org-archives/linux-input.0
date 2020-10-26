Return-Path: <SRS0=b+LQ=EB=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64306C4363A
	for <linux-input@archiver.kernel.org>; Mon, 26 Oct 2020 16:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1768722400
	for <linux-input@archiver.kernel.org>; Mon, 26 Oct 2020 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603728820;
	bh=iknh9cCGY2ML3A0qcOQYSH5oxCx3Y8L3MKiYB+6/K5U=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Wm1dvZkyl88oCTxObPHtjhctr+nRheFuUVmpAx0fuqvoeBVWzrO1gqFVF9SKS6omn
	 Wx2kk2bdiC0jG5S4eCI/+fbqdL3kIRyOXka0UsSLk8EPaJnNyH/oXMJRflYpKPmGVk
	 g0xbMhF0+AXrQmfalK3Hyd6gMbXodnh4gvLckKDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773772AbgJZQNj (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 26 Oct 2020 12:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772859AbgJZQNj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 26 Oct 2020 12:13:39 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B22E2085B;
        Mon, 26 Oct 2020 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728819;
        bh=iknh9cCGY2ML3A0qcOQYSH5oxCx3Y8L3MKiYB+6/K5U=;
        h=From:To:Cc:Subject:Date:From;
        b=YqfIDtsh39FJdst7Z3w2y03TKBIHMlVkUyByJ2gfOVtnuCwU47TeU8Hpv4r02UKlQ
         0T+GyYmOhx3m9MFH/V9zSV2pc/owbJOKo374ex8cCo2FCG1rvAyA1oXFOu4KSgzRo8
         lo3itV20+3cbKQmOAihvpbzggsTaK0ybE0E1VtLA=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dudley Du <dudl@cypress.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: cyapa_gen6: fix out-of-bounds stack access
Date:   Mon, 26 Oct 2020 17:13:29 +0100
Message-Id: <20201026161332.3708389-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Warray-bounds warns about a serious bug in
cyapa_pip_retrieve_data_structure:

drivers/input/mouse/cyapa_gen6.c: In function 'cyapa_pip_retrieve_data_structure.constprop':
include/linux/unaligned/access_ok.h:40:17: warning: array subscript -1 is outside array bounds of 'struct retrieve_data_struct_cmd[1]' [-Warray-bounds]
   40 |  *((__le16 *)p) = cpu_to_le16(val);
drivers/input/mouse/cyapa_gen6.c:569:13: note: while referencing 'cmd'
  569 |  } __packed cmd;
      |             ^~~

Apparently the '-2' was added to the pointer instead of the value,
writing garbage into the stack next to this variable.

Fixes: c2c06c41f700 ("Input: cyapa - add gen6 device module support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/mouse/cyapa_gen6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/cyapa_gen6.c b/drivers/input/mouse/cyapa_gen6.c
index 7eba66fbef58..812edfced86e 100644
--- a/drivers/input/mouse/cyapa_gen6.c
+++ b/drivers/input/mouse/cyapa_gen6.c
@@ -573,7 +573,7 @@ static int cyapa_pip_retrieve_data_structure(struct cyapa *cyapa,
 
 	memset(&cmd, 0, sizeof(cmd));
 	put_unaligned_le16(PIP_OUTPUT_REPORT_ADDR, &cmd.head.addr);
-	put_unaligned_le16(sizeof(cmd), &cmd.head.length - 2);
+	put_unaligned_le16(sizeof(cmd) - 2, &cmd.head.length);
 	cmd.head.report_id = PIP_APP_CMD_REPORT_ID;
 	cmd.head.cmd_code = PIP_RETRIEVE_DATA_STRUCTURE;
 	put_unaligned_le16(read_offset, &cmd.read_offset);
-- 
2.27.0

