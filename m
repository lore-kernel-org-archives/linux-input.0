Return-Path: <SRS0=onHS=64=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA9C433E1
	for <linux-input@archiver.kernel.org>; Thu, 14 May 2020 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD5DA2078C
	for <linux-input@archiver.kernel.org>; Thu, 14 May 2020 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483022;
	bh=7BopdSLcp8J4FWItB9qb1y6DyvBGvmyL2nsMbg4ACkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5pirT1cCiOm3Htj/VQD8ngUGJwQ5yVZl4zSl6W1uJiYnOIA8x3BT/Ra0Pel8VFXn
	 X62siv5/2MaX5ieVdzYtp/IhpWBFSlhgqbwEA5FD45s/6UKRZ/BgKqBYUXnK07LNkA
	 rtbzg/7Dy4f4kR3bJaP0oLWW4fi4FFC9He9PC8YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgENTDi (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 14 May 2020 15:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729179AbgENSyo (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 May 2020 14:54:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C022074A;
        Thu, 14 May 2020 18:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482483;
        bh=7BopdSLcp8J4FWItB9qb1y6DyvBGvmyL2nsMbg4ACkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmxFlHNpLZakuhVz8IKyZ75fNtJpROo3i8IdN8fve36KVCUpul/TVOUMfnZ7cAn4q
         lfTqRa/lb+N36nx/7En9qTsfNLf7XW0ZbIDJ3MYGVAh7jHGSR7/1MO+5jM7av3HyVK
         e1SSLvEsCsftN8BuZ9ynZ2Rw2AKO/WWPCC+VqSiw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/31] HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K12A keyboard-dock
Date:   Thu, 14 May 2020 14:54:05 -0400
Message-Id: <20200514185413.20755-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185413.20755-1-sashal@kernel.org>
References: <20200514185413.20755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 1e189f267015a098bdcb82cc652d13fbf2203fa0 ]

Add a HID_QUIRK_NO_INIT_REPORTS quirk for the Dell K12A keyboard-dock,
which can be used with various Dell Venue 11 models.

Without this quirk the keyboard/touchpad combo works fine when connected
at boot, but when hotplugged 9 out of 10 times it will not work properly.
Adding the quirk fixes this.

Cc: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e071fd3c6b2b0..c1fed1aaecdf8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1081,6 +1081,7 @@
 #define USB_DEVICE_ID_SYNAPTICS_LTS2	0x1d10
 #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
 #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
+#define USB_DEVICE_ID_SYNAPTICS_DELL_K12A	0x2819
 #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5_012	0x2968
 #define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index b9529bed4d763..e5beee3e8582a 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -163,6 +163,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_LTS2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_QUAD_HD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_TP_V103), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DELL_K12A), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPMAX, USB_DEVICE_ID_TOPMAX_COBRAPAD), HID_QUIRK_BADPAD },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS), HID_QUIRK_MULTI_INPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8882), HID_QUIRK_NOGET },
-- 
2.20.1

