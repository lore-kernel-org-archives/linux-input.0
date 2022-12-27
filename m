Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67640C4708E
	for <linux-input@archiver.kernel.org>; Tue, 27 Dec 2022 20:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiL0Ujl (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 27 Dec 2022 15:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiL0UjD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2022 15:39:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23FFF020;
        Tue, 27 Dec 2022 12:35:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE94DB81213;
        Tue, 27 Dec 2022 20:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E8C4339E;
        Tue, 27 Dec 2022 20:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672173308;
        bh=kFlvvN/F4Q4jjg+FlXi2/15AXOZOcS12kKDfV8xHyTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tes5SasdpLYTrsBOiWQJyqyVF8n2SJ4ZfxEyPosu8QYAip3xj+ibPY40IlWQVG3qB
         EZ7Wj95gvJYRgE648LjQIWZB21JG8ObuBgM7D5+ktlSuaRwQkgpQXbbdGgXJdFJpwo
         nBIAnzIYADlVd8hhgMjVkJQ3ISDF+9a1cw5BQDAURSnLvI60RRQLT/msDU2vzvVvX2
         H+JKfANz17hVivZaLlMH9T3M4zIFZOGmppvVjDyo6g0nb9BU6rHD7oPcB6vqSHLNXn
         9YQc0mY5W0KqLuRfY3HVkAkHWnUDlY12szu0BPBrfvZL5NgkjbUXX8+3vBxHPtSyMC
         ofP83KS4S8tKg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Akito <the@akito.ooo>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 21/22] HID: multitouch: fix Asus ExpertBook P2 P2451FA trackpoint
Date:   Tue, 27 Dec 2022 15:34:31 -0500
Message-Id: <20221227203433.1214255-21-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221227203433.1214255-1-sashal@kernel.org>
References: <20221227203433.1214255-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: José Expósito <jose.exposito89@gmail.com>

[ Upstream commit 4eab1c2fe06c98a4dff258dd64800b6986c101e9 ]

The HID descriptor of this device contains two mouse collections, one
for mouse emulation and the other for the trackpoint.

Both collections get merged and, because the first one defines X and Y,
the movemenent events reported by the trackpoint collection are
ignored.

Set the MT_CLS_WIN_8_FORCE_MULTI_INPUT class for this device to be able
to receive its reports.

This fix is similar to/based on commit 40d5bb87377a ("HID: multitouch:
enable multi-input as a quirk for some devices").

Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/825
Reported-by: Akito <the@akito.ooo>
Tested-by: Akito <the@akito.ooo>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 08462ac72b89..6b86d368d5e7 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1965,6 +1965,10 @@ static const struct hid_device_id mt_devices[] = {
 		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
 			USB_VENDOR_ID_ELAN, 0x313a) },
 
+	{ .driver_data = MT_CLS_WIN_8_FORCE_MULTI_INPUT,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			USB_VENDOR_ID_ELAN, 0x3148) },
+
 	/* Elitegroup panel */
 	{ .driver_data = MT_CLS_SERIAL,
 		MT_USB_DEVICE(USB_VENDOR_ID_ELITEGROUP,
-- 
2.35.1

