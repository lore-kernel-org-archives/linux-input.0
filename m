Return-Path: <SRS0=/ird=ZF=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ED8C43331
	for <linux-input@archiver.kernel.org>; Wed, 13 Nov 2019 02:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C868E21D7F
	for <linux-input@archiver.kernel.org>; Wed, 13 Nov 2019 02:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611152;
	bh=mVeXe/oLVm/UKSIJ1sNGQhVuu2K8tzzVlbBA6ZHxeuw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r08Q6d54jOqYXgqsDNN7n5yLUWJUfuOPDXgtaHJIAOGpCqlxZ8OGmdbOs23bwaP/p
	 6uIFWcZcrU0+zrj55cWWyzbaEyr6W8dpNXRduVL80HjmXNdGMsfHimrZMz0XmFJ4UA
	 kseKJy1OIbS/NVIKEvfNKMRT+bB7WpGZFhA4RedE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfKMB6T (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:58:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbfKMB6T (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D0B222CF;
        Wed, 13 Nov 2019 01:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610298;
        bh=mVeXe/oLVm/UKSIJ1sNGQhVuu2K8tzzVlbBA6ZHxeuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iddatUHQySqaYqPKnq3+lYJFpEW/vsoUp2oOHcIMtdUPRnAfOTXPYparycpkCG6BK
         zBTudqG9QZGEJgGaJyZkGcVIscWeMhLGZpDd/PzOxHOYBi9dd5WnP3rVhr3HHQQFra
         V1goB+5JL1xfMBN1hxUkjtJhdeTC/JSB/mW1j9PU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Sax <jsbc@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 070/115] Input: silead - try firmware reload after unsuccessful resume
Date:   Tue, 12 Nov 2019 20:55:37 -0500
Message-Id: <20191113015622.11592-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Julian Sax <jsbc@gmx.de>

[ Upstream commit dde27443211062e841806feaf690674b7c3a599f ]

A certain silead controller (Chip ID: 0x56810000) loses its firmware
after suspend, causing the resume to fail. This patch tries to load
the firmware, should a resume error occur and retries the resuming.

Signed-off-by: Julian Sax <jsbc@gmx.de>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/silead.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
index 0dbcf105f7db3..7c0eeef29b3cb 100644
--- a/drivers/input/touchscreen/silead.c
+++ b/drivers/input/touchscreen/silead.c
@@ -534,20 +534,33 @@ static int __maybe_unused silead_ts_suspend(struct device *dev)
 static int __maybe_unused silead_ts_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
+	bool second_try = false;
 	int error, status;
 
 	silead_ts_set_power(client, SILEAD_POWER_ON);
 
+ retry:
 	error = silead_ts_reset(client);
 	if (error)
 		return error;
 
+	if (second_try) {
+		error = silead_ts_load_fw(client);
+		if (error)
+			return error;
+	}
+
 	error = silead_ts_startup(client);
 	if (error)
 		return error;
 
 	status = silead_ts_get_status(client);
 	if (status != SILEAD_STATUS_OK) {
+		if (!second_try) {
+			second_try = true;
+			dev_dbg(dev, "Reloading firmware after unsuccessful resume\n");
+			goto retry;
+		}
 		dev_err(dev, "Resume error, status: 0x%02x\n", status);
 		return -ENODEV;
 	}
-- 
2.20.1

