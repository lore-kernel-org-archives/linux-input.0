Return-Path: <SRS0=Jdnn=A7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CBFC388CB
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 21:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75B7206E9
	for <linux-input@archiver.kernel.org>; Mon, 20 Jul 2020 21:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281286;
	bh=qdAfJnBJ7sjyxic7UNz+QaCPtfFw871DnQVRrHY+yCY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=radsDnIQje9U26FV38jemd2Beq08IpT0pMtOgyl+lnCtEn9CJBEMbpb9f74yz1Wxr
	 HSyqcJSBQ0k7lfqrDZA9ESRWRpF2iiD0eHA9TBRCgxRfpVLbRzp+aI8aH1PeCg+RRF
	 pj0RK4CWFalV42hSFZxceIDPC9mpruzZsTPtyR/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGTVlV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgGTVje (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440E222CB2;
        Mon, 20 Jul 2020 21:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281173;
        bh=qdAfJnBJ7sjyxic7UNz+QaCPtfFw871DnQVRrHY+yCY=;
        h=From:To:Cc:Subject:Date:From;
        b=Fwrybm10H4XMelhaiEVj1x6OWsGrSjMOQn41OPy7MPz4Cyd9z0af+8DNcL9pN1/d6
         Xj5b+9067fFLMaohfDVo5056nxObk8AFrSp4t6PEfahqZTNh/cLa32M2IfGsQjHSGy
         M+PdecZV6A4nlPKVqArKiqqgxVgGfKBwkWCB20h4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Federico Ricchiuto <fed.ricchiuto@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 1/9] HID: i2c-hid: add Mediacom FlexBook edge13 to descriptor override
Date:   Mon, 20 Jul 2020 17:39:24 -0400
Message-Id: <20200720213932.408089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Federico Ricchiuto <fed.ricchiuto@gmail.com>

[ Upstream commit 43e666acb79f3d355dd89bf20f4d25d3b15da13e ]

The Mediacom FlexBook edge13 uses the SIPODEV SP1064 touchpad, which does not
supply descriptors, so it has to be added to the override list.

Signed-off-by: Federico Ricchiuto <fed.ricchiuto@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 681ac9bc68b3d..f98c1e1b1dbdc 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -373,6 +373,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Mediacom FlexBook edge 13",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MEDIACOM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "FlexBook_edge13-M-FBE13"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{
 		.ident = "Odys Winbook 13",
 		.matches = {
-- 
2.25.1

