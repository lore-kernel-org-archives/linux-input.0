Return-Path: <SRS0=zzu2=B7=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B65C433DF
	for <linux-input@archiver.kernel.org>; Fri, 21 Aug 2020 16:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009AB20702
	for <linux-input@archiver.kernel.org>; Fri, 21 Aug 2020 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598029006;
	bh=Bzvll3pCe1AMYSUjL6S0uyx9RSHYFXoynJQi99sQQyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bD5/c0cHzuN38Ld1AOJhRqlM70tWJA67xERIoHrNIEZ2xQihjxvnhQfw2vaqx0iN/
	 cERkzwu+Tk2S9sMfGn23b6SXbmKvOUnHnUTpFElxes0fIQkXajO3NQ3eaQ+K9ulHXa
	 4acbvCc+RU26O239lILKIGncZml++kkiKHW0jwac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgHUQ4j (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:56:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgHUQTb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Aug 2020 12:19:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3918F22D0B;
        Fri, 21 Aug 2020 16:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026723;
        bh=Bzvll3pCe1AMYSUjL6S0uyx9RSHYFXoynJQi99sQQyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtT9/L3A9WXmC+eFn9UiBCuWzAaeyaOtKrjmAY0pbcXf+Bnf3acMgcstkbSwNeYEU
         5GE/72pqaJPgLbuniZpA/DWhPn6v49+wJK/lih60xnwtiT24zmgn82oaiwy4gV0fhc
         VkLhDmHv4o7h5XBnBITDc2GXgfeqiSIr04Z7C3Y8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ikjoon Jang <ikjn@chromium.org>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 28/38] HID: quirks: add NOGET quirk for Logitech GROUP
Date:   Fri, 21 Aug 2020 12:17:57 -0400
Message-Id: <20200821161807.348600-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161807.348600-1-sashal@kernel.org>
References: <20200821161807.348600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Ikjoon Jang <ikjn@chromium.org>

[ Upstream commit 68f775ddd2a6f513e225f9a565b054ab48fef142 ]

Add HID_QUIRK_NOGET for Logitech GROUP device.

Logitech GROUP is a compound with camera and audio.
When the HID interface in an audio device is requested to get
specific report id, all following control transfers are stalled
and never be restored back.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=203419
Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 20530d8adfbb8..2c100b73d3fc1 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -756,6 +756,7 @@
 #define USB_DEVICE_ID_LOGITECH_G27_WHEEL	0xc29b
 #define USB_DEVICE_ID_LOGITECH_WII_WHEEL	0xc29c
 #define USB_DEVICE_ID_LOGITECH_ELITE_KBD	0xc30a
+#define USB_DEVICE_ID_LOGITECH_GROUP_AUDIO	0x0882
 #define USB_DEVICE_ID_S510_RECEIVER	0xc50c
 #define USB_DEVICE_ID_S510_RECEIVER_2	0xc517
 #define USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500	0xc512
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index bdde16395b2ce..62f87f8bd9720 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -179,6 +179,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS), HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD), HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_XIN_MO, USB_DEVICE_ID_XIN_MO_DUAL_ARCADE), HID_QUIRK_MULTI_INPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_GROUP_AUDIO), HID_QUIRK_NOGET },
 
 	{ 0 }
 };
-- 
2.25.1

