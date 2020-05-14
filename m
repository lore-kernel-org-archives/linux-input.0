Return-Path: <SRS0=onHS=64=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA694C433E3
	for <linux-input@archiver.kernel.org>; Thu, 14 May 2020 19:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA08320675
	for <linux-input@archiver.kernel.org>; Thu, 14 May 2020 19:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483192;
	bh=luYS6nZhnYfPoPuRBeriezK2WomVKbkolapMTsl/qas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jyaD/r3mhlyAOp8Lrs0OSMp1myMB6Rwzd0oW+tT4MlOu0MMFdX9GJEJKAhqI1knwq
	 G1Jb7LvvExPw2IB2VHeD1+c+NadGyIk4GihS3ZscSN6BrL06AweZUBQPqm3wuRctvM
	 SqawX9hWSvB3KgCP+jzbKERflJnvQJMVQ2hhBFlg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgENTGb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 14 May 2020 15:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728840AbgENSxt (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 May 2020 14:53:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12A7207D8;
        Thu, 14 May 2020 18:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482428;
        bh=luYS6nZhnYfPoPuRBeriezK2WomVKbkolapMTsl/qas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JooYJbpa2TyUhzzTsMOMAYPwYDo329IsoZStk9c8pBWLpZ0MFVbOOOiWstnPJV3aK
         CXhGUE7fOhqzX5G/UZ7qpqzWtyArT9tVoGy+zSPBQyj4bLy+r4IcZXio2EGKsuBITk
         Olb1h+iFTixkqfzK0CDWF9m8PiAouQT86nAuQFMI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 30/49] HID: quirks: Add HID_QUIRK_NO_INIT_REPORTS quirk for Dell K12A keyboard-dock
Date:   Thu, 14 May 2020 14:52:51 -0400
Message-Id: <20200514185311.20294-30-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185311.20294-1-sashal@kernel.org>
References: <20200514185311.20294-1-sashal@kernel.org>
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
index 3341133df3a8d..13b7222ef2c91 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1106,6 +1106,7 @@
 #define USB_DEVICE_ID_SYNAPTICS_LTS2	0x1d10
 #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
 #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
+#define USB_DEVICE_ID_SYNAPTICS_DELL_K12A	0x2819
 #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5_012	0x2968
 #define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
 #define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5	0x81a7
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index ae64a286a68f4..90ec2390ef688 100644
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

