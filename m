Return-Path: <SRS0=y+wa=ZG=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22ABC432C3
	for <linux-input@archiver.kernel.org>; Thu, 14 Nov 2019 11:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99680206EF
	for <linux-input@archiver.kernel.org>; Thu, 14 Nov 2019 11:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfKNLXl (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:23:41 -0500
Received: from inva021.nxp.com ([92.121.34.21]:40882 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfKNLXk (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 Nov 2019 06:23:40 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DE89D20001C;
        Thu, 14 Nov 2019 12:23:34 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6079D200428;
        Thu, 14 Nov 2019 12:23:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 73723402DE;
        Thu, 14 Nov 2019 19:23:24 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     dmitry.torokhov@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        robh@kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] Input: keyboard - imx_sc: Correct SCU message structure to avoid stack corruption
Date:   Thu, 14 Nov 2019 19:21:39 +0800
Message-Id: <1573730499-2224-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The SCU message's data field used for receiving response data
from SCU should be 32-bit width, as SCU will send back 32-bit
width data, correct it to avoid kernel panic of stack protection
when CONFIG_CC_HAVE_STACKPROTECTOR_SYSREG is enabled.

[    1.950768] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted
[    1.980607] Workqueue: events imx_sc_check_for_events
[    1.985657] Call trace:
[    1.988104]  dump_backtrace+0x0/0x140
[    1.991768]  show_stack+0x14/0x20
[    1.995090]  dump_stack+0xb4/0xf8
[    1.998407]  panic+0x158/0x324
[    2.001463]  print_tainted+0x0/0xa8
[    2.004950]  imx_sc_check_for_events+0x18c/0x190
[    2.009569]  process_one_work+0x198/0x320
[    2.013579]  worker_thread+0x48/0x420
[    2.017252]  kthread+0xf0/0x120
[    2.020394]  ret_from_fork+0x10/0x18
[    2.023977] SMP: stopping secondary CPUs
[    2.027901] Kernel Offset: disabled
[    2.031391] CPU features: 0x0002,2100600c
[    2.035401] Memory Limit: none

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/input/keyboard/imx_sc_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_sc_key.c b/drivers/input/keyboard/imx_sc_key.c
index dd57daa..5379952 100644
--- a/drivers/input/keyboard/imx_sc_key.c
+++ b/drivers/input/keyboard/imx_sc_key.c
@@ -35,7 +35,7 @@ struct imx_key_drv_data {
 
 struct imx_sc_msg_key {
 	struct imx_sc_rpc_msg hdr;
-	u8 state;
+	u32 state;
 };
 
 static int imx_sc_key_notify(struct notifier_block *nb,
-- 
2.7.4

