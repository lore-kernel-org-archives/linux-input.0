Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130C1C47094
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04EAB61447
	for <linux-input@archiver.kernel.org>; Mon,  7 Jun 2021 16:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhFGQWb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233118AbhFGQU0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Jun 2021 12:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1654161494;
        Mon,  7 Jun 2021 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082491;
        bh=2vHZzaCr2cTsRb/gNLyfv5enlIiCAWNKmoLejdTAoCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAz7nlCNxto3xc2p6I9JXqCfi3hlnD9kg6fRosSEO4NhbFfHDpmNErgbDVrfzKIeX
         74CnxS/YjnsuNwfvESKz6lQFEvrTqEzjhd4SAycR9D3CQ7VsNpHTYRheklpt2fxDM+
         qjCB598nudEYXlF4iP/fVIwS1uzbpCBg6Xme7u3+qvNh30GdNqaJJ1wCxrD+HRQ0pJ
         zVZbgdc+iHBL89RuiZejAt5CdnIuIGFQAbr7rBjuY7cVYNhAwbEDlVRciz3RuWCWul
         IL4O6pwgSRhkdWdjoyyrMoV9tjGS5xWQL4WVyJOii5uEHjVdCihXzkoSX26BJDjcBD
         wcxLjJx3Qnguw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nirenjan Krishnan <nirenjan@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/21] HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for Saitek X65
Date:   Mon,  7 Jun 2021 12:14:29 -0400
Message-Id: <20210607161448.3584332-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161448.3584332-1-sashal@kernel.org>
References: <20210607161448.3584332-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Nirenjan Krishnan <nirenjan@gmail.com>

[ Upstream commit 25bdbfbb2d8331a67824dd03d0087e9c98835f3a ]

The Saitek X65 joystick has a pair of axes that were used as mouse
pointer controls by the Windows driver. The corresponding usage page is
the Game Controls page, which is not recognized by the generic HID
driver, and therefore, both axes get mapped to ABS_MISC. The quirk makes
the second axis get mapped to ABS_MISC+1, and therefore made available
separately.

Signed-off-by: Nirenjan Krishnan <nirenjan@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 75342f3dfb86..ee5dce862a21 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -999,6 +999,7 @@
 #define USB_DEVICE_ID_SAITEK_X52	0x075c
 #define USB_DEVICE_ID_SAITEK_X52_2	0x0255
 #define USB_DEVICE_ID_SAITEK_X52_PRO	0x0762
+#define USB_DEVICE_ID_SAITEK_X65	0x0b6a
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 8fbe7b9cd84a..48e9761d4ace 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -155,6 +155,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_PRO), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X65), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
-- 
2.30.2

