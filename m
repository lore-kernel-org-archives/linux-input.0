Return-Path: <SRS0=Maqc=YL=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84BDCA9EAC
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 22:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730A2222C3
	for <linux-input@archiver.kernel.org>; Fri, 18 Oct 2019 22:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437009;
	bh=A+nXIhWOh/hn+hSxK3tP54icEmodpvMjam53PuBkrA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnuQRHBxT4JtIEPFmz0gnVYsmzbTAl/YlcDc40BNpm/K1rOIurHNDUJhDnTU8RUvP
	 lxYmjZ0HtzPNQcFtXSQYu5jiT5MIe6pQWDj0fYbOTFxPENvV09jcjuFLiXOqQNfKZ+
	 PizMscj27y2hph7ot2ChXUCl+ir05+o1WwUrmAl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393073AbfJRWQs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387573AbfJRWIN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 18 Oct 2019 18:08:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0B9C205F4;
        Fri, 18 Oct 2019 22:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436492;
        bh=A+nXIhWOh/hn+hSxK3tP54icEmodpvMjam53PuBkrA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+GY4ve+cxg/FfK6+A3JkjrkYZBuFcnNmG64XnL+67H6m4HAQ+9Rc0aBZ6MpC867m
         7T+XSkxuKM4c5eCXGKsPdQSMAzmJmZuidFzeh24tL1vH4Skj464xrLH1kY94jTBZ4L
         i/vuxczcb7NqXtZiKiT0i24ZeEyhW7j3qgYTm0mc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Rene Wagner <redhatbugzilla@callerid.de>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 07/56] HID: i2c-hid: Add Odys Winbook 13 to descriptor override
Date:   Fri, 18 Oct 2019 18:07:04 -0400
Message-Id: <20191018220753.10002-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220753.10002-1-sashal@kernel.org>
References: <20191018220753.10002-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit f8f807441eefddc3c6d8a378421f0ede6361d565 ]

The Odys Winbook 13 uses a SIPODEV SP1064 touchpad, which does not
supply descriptors, add this to the DMI descriptor override list, fixing
the touchpad not working.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1526312
Reported-by: Rene Wagner <redhatbugzilla@callerid.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
index 89f2976f9c534..fd1b6eea6d2fd 100644
--- a/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
+++ b/drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c
@@ -346,6 +346,14 @@ static const struct dmi_system_id i2c_hid_dmi_desc_override_table[] = {
 		},
 		.driver_data = (void *)&sipodev_desc
 	},
+	{
+		.ident = "Odys Winbook 13",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "AXDIA International GmbH"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "WINBOOK 13"),
+		},
+		.driver_data = (void *)&sipodev_desc
+	},
 	{ }	/* Terminate list */
 };
 
-- 
2.20.1

