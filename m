Return-Path: <SRS0=+qu7=77=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7712C433E0
	for <linux-input@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA74D2083B
	for <linux-input@archiver.kernel.org>; Thu, 18 Jun 2020 02:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448719;
	bh=RN2bILSQm9t4nnyHUz9ZGhGu6QRwP2bTK5/z6XWX6JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RTtOIISK8XTlTNG2U3bDf/dZ4WPXlI4evsFgrrTBDxIsa76mvWZC8dyPMRxNg7+HC
	 Jm4ye+vAXpPUPkN1NCIj6LRAHhYT8Ttsk1CR2g0enGR/mwoYxZvquHQGMX9klgSNVL
	 +jB4FJW6KnVQt0xVOIphp1NVFJKhGY67cb795IHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgFRBIr (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgFRBIq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9114921D6C;
        Thu, 18 Jun 2020 01:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442526;
        bh=RN2bILSQm9t4nnyHUz9ZGhGu6QRwP2bTK5/z6XWX6JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwjVUpuhW1Ls1i5Mf99YeXEAWn/rm5HDPsrIaN2LfUt0gcn6N+Ux4wwFAF9DsnJF2
         HkesmzMPJJEUvrUFytb75Kdav8fEJLYcwpKoThKmMMQP04in2Q/zQda9HQtSeNMMKM
         WfKdZmIBZmYmJ47C2psABr4V62/qfx82uqeoXV6Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 030/388] Input: edt-ft5x06 - fix get_default register write access
Date:   Wed, 17 Jun 2020 21:02:07 -0400
Message-Id: <20200618010805.600873-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 255cdaf73412de13608fb776101402dca68bed2b ]

Since commit b6eba86030bf ("Input: edt-ft5x06 - add offset support for
ev-ft5726") offset-x and offset-y is supported. Devices using those
offset parameters don't support the offset parameter so we need to add
the NO_REGISTER check for edt_ft5x06_ts_get_defaults().

Fixes: b6eba86030bf ("Input: edt-ft5x06 - add offset support for ev-ft5726")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20200227112819.16754-2-m.felsch@pengutronix.de
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/edt-ft5x06.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d2587724c52a..9b8450794a8a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -938,19 +938,25 @@ static void edt_ft5x06_ts_get_defaults(struct device *dev,
 
 	error = device_property_read_u32(dev, "offset", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset, val);
+		if (reg_addr->reg_offset != NO_REGISTER)
+			edt_ft5x06_register_write(tsdata,
+						  reg_addr->reg_offset, val);
 		tsdata->offset = val;
 	}
 
 	error = device_property_read_u32(dev, "offset-x", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset_x, val);
+		if (reg_addr->reg_offset_x != NO_REGISTER)
+			edt_ft5x06_register_write(tsdata,
+						  reg_addr->reg_offset_x, val);
 		tsdata->offset_x = val;
 	}
 
 	error = device_property_read_u32(dev, "offset-y", &val);
 	if (!error) {
-		edt_ft5x06_register_write(tsdata, reg_addr->reg_offset_y, val);
+		if (reg_addr->reg_offset_y != NO_REGISTER)
+			edt_ft5x06_register_write(tsdata,
+						  reg_addr->reg_offset_y, val);
 		tsdata->offset_y = val;
 	}
 }
-- 
2.25.1

