Return-Path: <SRS0=GK5G=7W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F7C433E1
	for <linux-input@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D945206C3
	for <linux-input@archiver.kernel.org>; Tue,  9 Jun 2020 00:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662905;
	bh=0s4kw//tMF6/0U/1tQBmB3KpJtoo0PmRghH2t4jItlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Md3dDFg/daJ5HdsQwLyOJb3wyg56ye3+dtF4ItHVuPd0yfB1Wlz7ajXF0WWpFANWc
	 W6K7GCv18xiBdrrTbp9BJlsnzXEki+8YxFt2EyicEV92gonwz1jSZVOG1FkSUjqjgm
	 JxsOW8XQG3oGtJv9KbFUNHmBd3ynM89ZgdfB/Sk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgFIAfE (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbgFHXOb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D65D214F1;
        Mon,  8 Jun 2020 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658070;
        bh=0s4kw//tMF6/0U/1tQBmB3KpJtoo0PmRghH2t4jItlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ElU86haAyRjSgMmVkatfW4Z7s9sIevaNjbD1ap3fihDVUFwUyplPgIsgoeUbX7ZsB
         UjxXBsWwosLCIABdsNmUSybs93HhQxT75JpCeaXsgFco/tQT1wDJXOJiwUmfKb4O6c
         tkUCXD0/J3S+nQqSoVPyB4xSipHATBuRCnzRxdpI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 116/606] HID: i2c-hid: reset Synaptics SYNA2393 on resume
Date:   Mon,  8 Jun 2020 19:04:01 -0400
Message-Id: <20200608231211.3363633-116-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Daniel Playfair Cal <daniel.playfair.cal@gmail.com>

[ Upstream commit 538f67407e2c0e5ed2a46e7d7ffa52f2e30c7ef8 ]

On the Dell XPS 9570, the Synaptics SYNA2393 touchpad generates spurious
interrupts after resuming from suspend until it receives some input or
is reset. Add it to the quirk I2C_HID_QUIRK_RESET_ON_RESUME so that it
is reset when resuming from suspend.

More information about the bug can be found in this mailing list
discussion: https://www.spinics.net/lists/linux-input/msg59530.html

Signed-off-by: Daniel Playfair Cal <daniel.playfair.cal@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h              | 3 +++
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b3cc26ca375f..55afc089cb25 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1094,6 +1094,9 @@
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
 #define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
+#define I2C_VENDOR_ID_SYNAPTICS     0x06cb
+#define I2C_PRODUCT_ID_SYNAPTICS_SYNA2393   0x7a13
+
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
 #define USB_DEVICE_ID_SYNAPTICS_INT_TP	0x0002
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 009000c5d55c..294c84e136d7 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -177,6 +177,8 @@ static const struct i2c_hid_quirks {
 		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ USB_VENDOR_ID_ALPS_JP, HID_ANY_ID,
 		 I2C_HID_QUIRK_RESET_ON_RESUME },
+	{ I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA2393,
+		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ 0, 0 }
-- 
2.25.1

