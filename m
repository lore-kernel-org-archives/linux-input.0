Return-Path: <SRS0=pnPe=CQ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE613C433E2
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF1D20768
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599498337;
	bh=d4MCGwCqQlcYJhFyTu2YWQpqUFTmOLbIk17fsT39at8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t27NsGj8VIrvPk8ZSCI/bSGJuMPyKC0opJj2sg6OYBzDFD0d/eAtHXEKlDfTy38PN
	 a93bbrARGW8SLgjfyosCsh+obtg0Q3sKQfJ+sJTt8pQOOWH6Cw6cyppot6VzbLJQ+l
	 KoigmQPkgGUkGS1grnZUQv6YQoMdjqsuy78/oGl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgIGRFe (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbgIGQdI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 7 Sep 2020 12:33:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C671F21927;
        Mon,  7 Sep 2020 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599496387;
        bh=d4MCGwCqQlcYJhFyTu2YWQpqUFTmOLbIk17fsT39at8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quiC/+VjjcMIfECPZ9nTCToGFyOaw1B1x5u5gQZXHhhNHjHBIAfP7LPg1q2G0FE5G
         8pRHRZPVFSnmlmyr8Q7CVgllKP7Bhw11Z94F3GEs9nZ/aI7CrQc2VGuk52tLkkYYAz
         VgTAS8e+bmBC2rTEY1Mfb/kvVewPaM/U2OjHErlU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nirenjan Krishnan <nirenjan@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 37/53] HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for all Saitek X52 devices
Date:   Mon,  7 Sep 2020 12:32:03 -0400
Message-Id: <20200907163220.1280412-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163220.1280412-1-sashal@kernel.org>
References: <20200907163220.1280412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Nirenjan Krishnan <nirenjan@gmail.com>

[ Upstream commit 77df710ba633dfb6c65c65cf99ea9e084a1c9933 ]

The Saitek X52 family of joysticks has a pair of axes that were
originally (by the Windows driver) used as mouse pointer controls. The
corresponding usage page is the Game Controls page, which is not
recognized by the generic HID driver, and therefore, both axes get
mapped to ABS_MISC. The quirk makes the second axis get mapped to
ABS_MISC+1, and therefore made available separately.

One Saitek X52 device is already fixed. This patch fixes the other two
known devices with VID/PID 06a3:0255 and 06a3:0762.

Signed-off-by: Nirenjan Krishnan <nirenjan@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 2 ++
 drivers/hid/hid-quirks.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 7cfa9785bfbb0..476cb99bd61b7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1011,6 +1011,8 @@
 #define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa
 #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
 #define USB_DEVICE_ID_SAITEK_X52	0x075c
+#define USB_DEVICE_ID_SAITEK_X52_2	0x0255
+#define USB_DEVICE_ID_SAITEK_X52_PRO	0x0762
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index c242150d35a3a..5247147f5cc7c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -147,6 +147,8 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RETROUSB, USB_DEVICE_ID_RETROUSB_SNES_RETROPORT), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_RUMBLEPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_PRO), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
-- 
2.25.1

