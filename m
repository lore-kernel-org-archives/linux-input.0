Return-Path: <SRS0=OZNg=6Z=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077E5C54E4A
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 13:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF49207FF
	for <linux-input@archiver.kernel.org>; Mon, 11 May 2020 13:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgEKN70 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 11 May 2020 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKN70 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 May 2020 09:59:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2A7C061A0C;
        Mon, 11 May 2020 06:59:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 7128C2A094C
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, andrzej.p@collabora.com,
        kernel@collabora.com
Subject: [PATCH 1/6] tty/sysrq: Remove linux,sysrq-reset-seq
Date:   Mon, 11 May 2020 15:59:13 +0200
Message-Id: <20200511135918.8203-2-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511135918.8203-1-andrzej.p@collabora.com>
References: <20200511135918.8203-1-andrzej.p@collabora.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Nobody in the tree uses linux,sysrq-reset-seq in Device Tree source files.
Remove the corresponding code.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
---
 drivers/tty/sysrq.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 0dc3878794fd..93202fc24308 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -720,41 +720,6 @@ static void sysrq_detect_reset_sequence(struct sysrq_state *state,
 	}
 }
 
-#ifdef CONFIG_OF
-static void sysrq_of_get_keyreset_config(void)
-{
-	u32 key;
-	struct device_node *np;
-	struct property *prop;
-	const __be32 *p;
-
-	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
-	if (!np) {
-		pr_debug("No sysrq node found");
-		return;
-	}
-
-	/* Reset in case a __weak definition was present */
-	sysrq_reset_seq_len = 0;
-
-	of_property_for_each_u32(np, "keyset", prop, p, key) {
-		if (key == KEY_RESERVED || key > KEY_MAX ||
-		    sysrq_reset_seq_len == SYSRQ_KEY_RESET_MAX)
-			break;
-
-		sysrq_reset_seq[sysrq_reset_seq_len++] = (unsigned short)key;
-	}
-
-	/* Get reset timeout if any. */
-	of_property_read_u32(np, "timeout-ms", &sysrq_reset_downtime_ms);
-
-	of_node_put(np);
-}
-#else
-static void sysrq_of_get_keyreset_config(void)
-{
-}
-#endif
 
 static void sysrq_reinject_alt_sysrq(struct work_struct *work)
 {
@@ -984,8 +949,6 @@ static inline void sysrq_register_handler(void)
 {
 	int error;
 
-	sysrq_of_get_keyreset_config();
-
 	error = input_register_handler(&sysrq_handler);
 	if (error)
 		pr_err("Failed to register input handler, error %d", error);
-- 
2.17.1

