Return-Path: <SRS0=Ma1V=4W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A49C3F2D1
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9651E207FD
	for <linux-input@archiver.kernel.org>; Thu,  5 Mar 2020 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583428730;
	bh=cue1eCJ0wInCnFV70PO9/SPNCKFJ39ETDvd2nz8Ro5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fyNrh1RCzea+dHSWPyudEBzbWtGCLSgBRjiVP3Up53qr3YLIH8wvZKsW11ZbP06B0
	 q2Srf3n/zf+tpgIcjFU3sJu51LntPWbi0eyxqnBhyqnnf7m/2Yb0kBgmI0ur0ofSLH
	 Aat3bi+815LhqhytsmGmdevgA1prn1nz+FIYzE70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgCERPZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbgCERPY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Mar 2020 12:15:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF7420870;
        Thu,  5 Mar 2020 17:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428524;
        bh=cue1eCJ0wInCnFV70PO9/SPNCKFJ39ETDvd2nz8Ro5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjMsk2N8IRIYDS28g93e3e085CPklRf6TgHP+3HTUiZ5NaexfNEJM1Pm79NH+xLCq
         jwoM5ar5WsABJmVLl+vO+TfofarL31SFqnEUoDUEhB7/oFqhajUJMorxStPyQkNgLx
         lGghebMCtmy/BQUYWOPxe6qaPRE2LBJuAduNcLLw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 06/31] HID: alps: Fix an error handling path in 'alps_input_configured()'
Date:   Thu,  5 Mar 2020 12:14:50 -0500
Message-Id: <20200305171516.30028-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171516.30028-1-sashal@kernel.org>
References: <20200305171516.30028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 8d2e77b39b8fecb794e19cd006a12f90b14dd077 ]

They are issues:
   - if 'input_allocate_device()' fails and return NULL, there is no need
     to free anything and 'input_free_device()' call is a no-op. It can
     be axed.
   - 'ret' is known to be 0 at this point, so we must set it to a
     meaningful value before returning

Fixes: 2562756dde55 ("HID: add Alps I2C HID Touchpad-Stick support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 3cd7229b6e546..895f49b565ee1 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -734,7 +734,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (data->has_sp) {
 		input2 = input_allocate_device();
 		if (!input2) {
-			input_free_device(input2);
+			ret = -ENOMEM;
 			goto exit;
 		}
 
-- 
2.20.1

