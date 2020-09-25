Return-Path: <SRS0=XHg4=DC=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149FEC4727E
	for <linux-input@archiver.kernel.org>; Fri, 25 Sep 2020 21:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA1320637
	for <linux-input@archiver.kernel.org>; Fri, 25 Sep 2020 21:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601069934;
	bh=FyKBAoQFGudp/myg2vZj+c/OVN2nCyAVsiWapu9YpX8=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=J9nuSMyzyARI/W14SvC62LEL1qwv/ZRXdyerGdCDARzBt1MakDzyQGDcKDWQIJOwX
	 nE4bEQ0qn1owUGyw/h9qqWuPD02SewOUpUm4NufHNEXKE4Pl5NfnuB8+XuDfxv9+bn
	 MrnLyn54RzIP5jGNFKp9R5RWka7FTpWpBGPJmEH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgIYViy (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 25 Sep 2020 17:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgIYViy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Sep 2020 17:38:54 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDB18204FD;
        Fri, 25 Sep 2020 21:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601069933;
        bh=FyKBAoQFGudp/myg2vZj+c/OVN2nCyAVsiWapu9YpX8=;
        h=Date:From:To:cc:Subject:From;
        b=IoXuvK1QW5bZFmtkZL7B4CLSO0j8Hk/5++70qogHWOyqWiBolIhJGmnFucVmF3ClB
         wqCm2IPuQMVyGiKYWEt9R38E5f1V7lYe674P8BzjmOFB+Rw99ovGLHd8Yena1bC2Vp
         p/ie4DLiMTn3ngnzlMSL+F3n+XaC6e+4FKsAiaPw=
Date:   Fri, 25 Sep 2020 23:38:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Andr=E9s_Barrantes_Silman?= 
        <andresbs2000@protonmail.com>
Subject: [PATCH] Input: Add nopnp quirk for Acer Aspire 5 A515
Message-ID: <nycvar.YFH.7.76.2009252337340.3336@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

Touchpad on this laptop is not detected properly during boot, as PNP 
enumerates (wrongly) AUX port as disabled on this machine.

Fix that by adding this board (with admittedly quite funny DMI 
identifiers) to nopnp quirk list.

Reported-by: Andrés Barrantes Silman <andresbs2000@protonmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 7d7f73702726..2527e19c95b4 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -705,6 +705,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nopnp_table[] = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
 		},
 	},
+	{
+		/* Acer Aspire 5 A515 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
+		},
+	},
 	{ }
 };
 
-- 
Jiri Kosina
SUSE Labs
