Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871D4C433E0
	for <linux-input@archiver.kernel.org>; Wed, 20 Jan 2021 03:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4076623119
	for <linux-input@archiver.kernel.org>; Wed, 20 Jan 2021 03:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731244AbhATC2y (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 19 Jan 2021 21:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbhATB0t (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Jan 2021 20:26:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 582C123132;
        Wed, 20 Jan 2021 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611105969;
        bh=QYbcRn/BnzG2H2nzpKhuqui5hnSozgbRMaT/E0YsHbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRdjO3TwMi8mwXh/Pkv4PAwhmsgQ1HLUNEDa/QPzm8zoK9mpL18rOa2eQiEEVl5aw
         v4PEKI2JNzjVNFrnfyTLa5r3y7RWLId6M7oaAKtmjQBaS4xYGHlXPAjrAAy4YA85/s
         GreGV8nHhWKp/dgqBdnneJIZv2EvxhMLPvA7R4UjjWl3kXg/pgJx1EH436xU8/rcDh
         2lNc5KPc1UKWyLa+jM4VduylzL1pHlKYWEOOZz1YZ/0BINXtD324ukpmGohq54ovZI
         AOfE15lj0sQ51yTtV5p+06BYsMtGyjLTvrTkBd8EszEkrwKNYW46LkbFQXZzr16PP8
         lhVtf+GKmclSQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 05/45] HID: multitouch: Enable multi-input for Synaptics pointstick/touchpad device
Date:   Tue, 19 Jan 2021 20:25:22 -0500
Message-Id: <20210120012602.769683-5-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210120012602.769683-1-sashal@kernel.org>
References: <20210120012602.769683-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit c3d6eb6e54373f297313b65c1f2319d36914d579 ]

Pointstick and its left/right buttons on HP EliteBook 850 G7 need
multi-input quirk to work correctly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index d670bcd57bdef..0743ef51d3b24 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2054,6 +2054,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_SYNAPTICS, 0xce08) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_SYNAPTICS, 0xce09) },
+
 	/* TopSeed panels */
 	{ .driver_data = MT_CLS_TOPSEED,
 		MT_USB_DEVICE(USB_VENDOR_ID_TOPSEED2,
-- 
2.27.0

