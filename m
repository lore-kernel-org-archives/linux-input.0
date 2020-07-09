Return-Path: <SRS0=Nro0=AU=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064FC433E0
	for <linux-input@archiver.kernel.org>; Thu,  9 Jul 2020 08:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8995120767
	for <linux-input@archiver.kernel.org>; Thu,  9 Jul 2020 08:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgGIICW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:02:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55003 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgGIICU (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2020 04:02:20 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jtRVQ-0003Hx-4b; Thu, 09 Jul 2020 08:02:08 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     hdegoede@redhat.com, anthony.wong@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        Pavel Balan <admin@kryma.net>,
        Aaron Ma <aaron.ma@canonical.com>,
        HungNien Chen <hn.chen@weidahitech.com>,
        Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] HID: i2c-hid: Enable wakeup capability from Suspend-to-Idle
Date:   Thu,  9 Jul 2020 15:57:29 +0800
Message-Id: <20200709075731.5046-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Many laptops can be woken up from Suspend-to-Idle by touchpad. This is
also the default behavior on other OSes.

However, if touchpad and touchscreen contact to each other when lid is
closed, wakeup events can be triggered inadventertly.

So let's disable the wakeup by default, but enable the wakeup capability
so users can enable it at their own discretion.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Enable the capability, but disable the wakeup default.

v3:
 - Use device_init_wakeup().
 - Wording change.

v2:
 - Fix compile error when ACPI is not enabled.

 drivers/hid/i2c-hid/i2c-hid-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 294c84e136d7..c18ca6a6cb3d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -931,6 +931,14 @@ static void i2c_hid_acpi_fix_up_power(struct device *dev)
 		acpi_device_fix_up_power(adev);
 }
 
+static void i2c_hid_acpi_enable_wakeup(struct device *dev)
+{
+	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
+		device_set_wakeup_capable(dev, true);
+		device_set_wakeup_enable(dev, false);
+	}
+}
+
 static const struct acpi_device_id i2c_hid_acpi_match[] = {
 	{"ACPI0C50", 0 },
 	{"PNP0C50", 0 },
@@ -945,6 +953,8 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
 }
 
 static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
+
+static inline void i2c_hid_acpi_enable_wakeup(struct device *dev) {}
 #endif
 
 #ifdef CONFIG_OF
@@ -1072,6 +1082,8 @@ static int i2c_hid_probe(struct i2c_client *client,
 
 	i2c_hid_acpi_fix_up_power(&client->dev);
 
+	i2c_hid_acpi_enable_wakeup(&client->dev);
+
 	device_enable_async_suspend(&client->dev);
 
 	/* Make sure there is something at this address */
-- 
2.17.1

