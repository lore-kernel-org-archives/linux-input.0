Return-Path: <SRS0=onHS=64=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C57C433E2
	for <linux-input@archiver.kernel.org>; Thu, 14 May 2020 19:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3C920727
	for <linux-input@archiver.kernel.org>; Thu, 14 May 2020 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483058;
	bh=1doIepixfBvAmZeI1g5ivNd1DvuwcCmBcvuTbbMX9vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=clKvn1DOtkFI65/l4peR0lvOqHNkyn2oMJxgWHWwactB0AWecQj7qxMZOSIJHaRzv
	 zUdKMz9LEo7qLSFFEoKyCsIhzw+J1xT5ITHy5x7onpgB/G4ccY4N6goc1pQSpdAZLc
	 x4+PorpCU36VMrKipgkeUVz31fmYz8NZssfkY/oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgENTEM (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 14 May 2020 15:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:54726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgENSye (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 14 May 2020 14:54:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF469206F1;
        Thu, 14 May 2020 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482473;
        bh=1doIepixfBvAmZeI1g5ivNd1DvuwcCmBcvuTbbMX9vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CGvdFys0Cgz1LFCFWs0kwkZVHh1Gmwp5AJJYnJvVWgjAjj+UhqWtS585caPwwdMm
         +l66bV/ohiO2e1FGqKqVoYg9mOSa1+CwhekNmIrW7oHdRyLnEG4mBWHJ0Qa8MqkETA
         30eMVmT2Wi9d/5QehStGFTZ89lGPSmo5D+h7UC9Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Playfair Cal <daniel.playfair.cal@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 16/31] HID: i2c-hid: reset Synaptics SYNA2393 on resume
Date:   Thu, 14 May 2020 14:53:58 -0400
Message-Id: <20200514185413.20755-16-sashal@kernel.org>
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
index 2a9cec9764cf9..e071fd3c6b2b0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1064,6 +1064,9 @@
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
 #define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
+#define I2C_VENDOR_ID_SYNAPTICS     0x06cb
+#define I2C_PRODUCT_ID_SYNAPTICS_SYNA2393   0x7a13
+
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
 #define USB_DEVICE_ID_SYNAPTICS_INT_TP	0x0002
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index f2c8c59fc5823..f17ebbe53abf0 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -187,6 +187,8 @@ static const struct i2c_hid_quirks {
 		 I2C_HID_QUIRK_BOGUS_IRQ },
 	{ USB_VENDOR_ID_ALPS_JP, HID_ANY_ID,
 		 I2C_HID_QUIRK_RESET_ON_RESUME },
+	{ I2C_VENDOR_ID_SYNAPTICS, I2C_PRODUCT_ID_SYNAPTICS_SYNA2393,
+		 I2C_HID_QUIRK_RESET_ON_RESUME },
 	{ USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_LEGION_Y720,
 		I2C_HID_QUIRK_BAD_INPUT_SIZE },
 	{ 0, 0 }
-- 
2.20.1

