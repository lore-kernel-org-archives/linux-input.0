Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3766CC433DB
	for <linux-input@archiver.kernel.org>; Mon,  8 Feb 2021 08:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D271864E7C
	for <linux-input@archiver.kernel.org>; Mon,  8 Feb 2021 08:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbhBHICy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Feb 2021 03:02:54 -0500
Received: from 176.12.98.74.MAXnet.ru ([176.12.98.74]:41260 "EHLO
        shell.ipa.basealt.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhBHICd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2021 03:02:33 -0500
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Feb 2021 03:02:32 EST
Received: by shell.ipa.basealt.ru (Postfix, from userid 709000081)
        id 85E4423FE7; Mon,  8 Feb 2021 10:52:57 +0300 (MSK)
From:   Nikolai Kostrigin <nickel@altlinux.org>
Cc:     nickel@altlinux.org, benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: elantech - add LEN2146 to SMBus blacklist for ThinkPad L13 Gen2
Date:   Mon,  8 Feb 2021 10:52:03 +0300
Message-Id: <20210208075205.3784059-1-nickel@altlinux.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

ThinkPad L13 Gen2 has both touchpad and trackpoint.
PNP: LEN2146 PNP0f13
With the default protocol (elantech-smbus) trackpoint is not operating,
while touchpad does. Changing to elantech renders both operational.

Signed-off-by: Nikolai Kostrigin <nickel@altlinux.org>
---
 drivers/input/mouse/elantech.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 90f8765f9efc..c4c3fa5828d8 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1776,6 +1776,7 @@ static const char * const i2c_blacklist_pnp_ids[] = {
 	 * These are known to not be working properly as bits are missing
 	 * in elan_i2c.
 	 */
+	"LEN2146", /* ThinkPad L13 Gen2 */
 	NULL
 };
 
-- 
2.29.2

