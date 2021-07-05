Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D88C11F6F
	for <linux-input@archiver.kernel.org>; Mon,  5 Jul 2021 15:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D0E61997
	for <linux-input@archiver.kernel.org>; Mon,  5 Jul 2021 15:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhGEPdW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 5 Jul 2021 11:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232166AbhGEPck (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Jul 2021 11:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B94DF61986;
        Mon,  5 Jul 2021 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625499003;
        bh=rrd+/5m+XlZ0KDdlO/QC2mj8cTFCxMABq/dve2gKSus=;
        h=From:To:Cc:Subject:Date:From;
        b=HnVoknjJefw21tPX7he7+MJjan35c7mhqDJbwcF+4DHYqBAZApvmH/9UkqyX30EpW
         ua31ogeMhvwhgnZEhS656gWa1FXPVOU4JeibpzEAUqBqHkFYNpaEDWqRKTkqZJzHSy
         HeOmSSYT8JwADdJaMZuLbUGFykqi1zaV7Bg3nORLsChOkbQkg06iI0cdtk+wEO2f4f
         ZFt119OmKf+8XijHZ7R+kWXp0AEU9TYhQffnecgMxZc4Y0RQAQEELlRl05RW0b+dPa
         b//sGaV6pY5Zs3DeGJd51hliEx3vdoInZ7pZ49UGT5zAA6y528tZ+jwHHFi+h6qx3d
         7m79xHBK2DiMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 01/41] HID: do not use down_interruptible() when unbinding devices
Date:   Mon,  5 Jul 2021 11:29:21 -0400
Message-Id: <20210705153001.1521447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit f2145f8dc566c4f3b5a8deb58dcd12bed4e20194 ]

Action of unbinding driver from a device is not cancellable and should not
fail, and driver core does not pay attention to the result of "remove"
method, therefore using down_interruptible() in hid_device_remove() does
not make sense.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0f69f35f2957..5550c943f985 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2306,12 +2306,8 @@ static int hid_device_remove(struct device *dev)
 {
 	struct hid_device *hdev = to_hid_device(dev);
 	struct hid_driver *hdrv;
-	int ret = 0;
 
-	if (down_interruptible(&hdev->driver_input_lock)) {
-		ret = -EINTR;
-		goto end;
-	}
+	down(&hdev->driver_input_lock);
 	hdev->io_started = false;
 
 	hdrv = hdev->driver;
@@ -2326,8 +2322,8 @@ static int hid_device_remove(struct device *dev)
 
 	if (!hdev->io_started)
 		up(&hdev->driver_input_lock);
-end:
-	return ret;
+
+	return 0;
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *a,
-- 
2.30.2

