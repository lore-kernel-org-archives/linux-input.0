Return-Path: <SRS0=5q57=7A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35779C433DF
	for <linux-input@archiver.kernel.org>; Mon, 18 May 2020 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A962067D
	for <linux-input@archiver.kernel.org>; Mon, 18 May 2020 09:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgERJf3 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 18 May 2020 05:35:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54498 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJf3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 May 2020 05:35:29 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jacB5-0007lg-5o; Mon, 18 May 2020 09:35:19 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        HungNien Chen <hn.chen@weidahitech.com>,
        Pavel Balan <admin@kryma.net>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: i2c-hid: Enable touchpad wakeup from Suspend-to-Idle
Date:   Mon, 18 May 2020 17:35:10 +0800
Message-Id: <20200518093511.29530-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Many laptops have the ability to be woken up from Suspend-to-Idle by
touchpad. This is also the default behavior on other OSes.

So let's enable the wakeup support if the system defaults to use
Suspend-to-Idle.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 294c84e136d7..cac82971a668 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1072,6 +1072,11 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	i2c_hid_acpi_fix_up_power(&client->dev);
 
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
+		device_set_wakeup_capable(&client->dev, true);
+		device_wakeup_enable(&client->dev);
+	}
+
 	device_enable_async_suspend(&client->dev);
 
 	/* Make sure there is something at this address */
-- 
2.17.1

