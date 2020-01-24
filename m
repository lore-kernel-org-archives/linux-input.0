Return-Path: <SRS0=4u0T=3N=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E66EC35242
	for <linux-input@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679AA206A2
	for <linux-input@archiver.kernel.org>; Fri, 24 Jan 2020 01:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828731;
	bh=mwQz/jJ5kefqSlmbAplM0OP5U5yjCh5kFbvMim84M+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vZe4fJ+ddIIWUTTkwk9gSbepOIE22bnmV2MOFMgsnZaBLkYIRRmMjdXwyFhYjsOCP
	 K+d5f5191igJMX90LW8VBw48FtK0erkcBw7/BLoJi53uZv6NYuvMXkRj/+EWLUBnUv
	 1t4Bq7GeU4OK5uPVf8zktK5LdSDPa3m8e6QsiRVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAXBR7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbgAXBR7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:59 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFB022087E;
        Fri, 24 Jan 2020 01:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828678;
        bh=mwQz/jJ5kefqSlmbAplM0OP5U5yjCh5kFbvMim84M+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXYky0tK2X/yWYbhCQam6Wuf7Clmay/Gl5RKb+cxtuti6eKrjsXuf36mZIr67FSpo
         HZfA+PcyIjdekmZabn8IUYMc2KQIqqpOZfBsnqoXp1H71cDU0F4FkfOQtaxGx7Bp4K
         UIUgaeQfvanY45jP1yvn169KZ1pIMrLd1Xi4NXW8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 09/11] HID: ite: Add USB id match for Acer SW5-012 keyboard dock
Date:   Thu, 23 Jan 2020 20:17:45 -0500
Message-Id: <20200124011747.18575-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011747.18575-1-sashal@kernel.org>
References: <20200124011747.18575-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 8f18eca9ebc57d6b150237033f6439242907e0ba ]

The Acer SW5-012 2-in-1 keyboard dock uses a Synaptics S91028 touchpad
which is connected to an ITE 8595 USB keyboard controller chip.

This keyboard has the same quirk for its rfkill / airplane mode hotkey as
other keyboards with the ITE 8595 chip, it only sends a single release
event when pressed and released, it never sends a press event.

This commit adds this keyboards USB id to the hid-ite id-table, fixing
the rfkill key not working on this keyboard.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h | 1 +
 drivers/hid/hid-ite.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1949d6fca53e5..f5d3da93f51a8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1074,6 +1074,7 @@
 #define USB_DEVICE_ID_SYNAPTICS_LTS2	0x1d10
 #define USB_DEVICE_ID_SYNAPTICS_HD	0x0ac3
 #define USB_DEVICE_ID_SYNAPTICS_QUAD_HD	0x1ac3
+#define USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5_012	0x2968
 #define USB_DEVICE_ID_SYNAPTICS_TP_V103	0x5710
 
 #define USB_VENDOR_ID_TEXAS_INSTRUMENTS	0x2047
diff --git a/drivers/hid/hid-ite.c b/drivers/hid/hid-ite.c
index 98b059d79bc89..2ce1eb0c92125 100644
--- a/drivers/hid/hid-ite.c
+++ b/drivers/hid/hid-ite.c
@@ -43,6 +43,9 @@ static int ite_event(struct hid_device *hdev, struct hid_field *field,
 static const struct hid_device_id ite_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_258A, USB_DEVICE_ID_258A_6A88) },
+	/* ITE8595 USB kbd ctlr, with Synaptics touchpad connected to it. */
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS,
+			 USB_DEVICE_ID_SYNAPTICS_ACER_SWITCH5_012) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ite_devices);
-- 
2.20.1

