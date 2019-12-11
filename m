Return-Path: <SRS0=YbS0=2B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4573DC2D0C6
	for <linux-input@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129A72073D
	for <linux-input@archiver.kernel.org>; Wed, 11 Dec 2019 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080136;
	bh=ViHz5u/uWxAOrJktt1S26vphXYtLoGqBe2iwBCprXmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xy//wLS1sqlCAGooTKta3h8GZX1MAVQg9DKFBOCi6XXKEjVhfJkWOEP3W2CMewuf9
	 q6cvL5kF3TIMt+Lz4Wt4rpcbO5iwHPXptgXc0EwK7eouQWjiLmBJT66X4SUxsUVxkg
	 esXL8Kbj8M7Rl3wk6iDISb1frNThF7yucixYs8AE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbfLKQCK (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbfLKPNP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Dec 2019 10:13:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B98DD208C3;
        Wed, 11 Dec 2019 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077195;
        bh=ViHz5u/uWxAOrJktt1S26vphXYtLoGqBe2iwBCprXmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMmUr6uuHX81ebmL47D4A0pqfLMTDzLNF164li1pay9osVOK+CO4DIIucfrji0ah0
         jBsWH/JTPxScloN/WJZTCIrCmuc+6A4oz251/FzuZLxrSkzIAnXmKjTvGTdgPzacUd
         9T1eB6SXBx9C9hQYBZ9rHRsuWU8Qs7vOyEKhCSnY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 078/134] HID: logitech-hidpp: Silence intermittent get_battery_capacity errors
Date:   Wed, 11 Dec 2019 10:10:54 -0500
Message-Id: <20191211151150.19073-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 61005d65b6c7dcf61c19516e6ebe5acc02d2cdda ]

My Logitech M185 (PID:4038) 2.4 GHz wireless HID++ mouse is causing
intermittent errors like these in the log:

[11091.034857] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
[12388.031260] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
[16613.718543] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09
[23529.938728] logitech-hidpp-device 0003:046D:4038.0006: hidpp20_batterylevel_get_battery_capacity: received protocol error 0x09

We are already silencing error-code 0x09 (HIDPP_ERROR_RESOURCE_ERROR)
errors in other places, lets do the same in
hidpp20_batterylevel_get_battery_capacity to remove these harmless,
but scary looking errors from the dmesg output.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 8e91e2f06cb4f..cd9193078525b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1102,6 +1102,9 @@ static int hidpp20_batterylevel_get_battery_capacity(struct hidpp_device *hidpp,
 	ret = hidpp_send_fap_command_sync(hidpp, feature_index,
 					  CMD_BATTERY_LEVEL_STATUS_GET_BATTERY_LEVEL_STATUS,
 					  NULL, 0, &response);
+	/* Ignore these intermittent errors */
+	if (ret == HIDPP_ERROR_RESOURCE_ERROR)
+		return -EIO;
 	if (ret > 0) {
 		hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
 			__func__, ret);
-- 
2.20.1

