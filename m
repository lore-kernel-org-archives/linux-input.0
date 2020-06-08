Return-Path: <SRS0=GK5G=7W=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFC8C433E0
	for <linux-input@archiver.kernel.org>; Tue,  9 Jun 2020 00:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307DA2078D
	for <linux-input@archiver.kernel.org>; Tue,  9 Jun 2020 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661986;
	bh=9/zpqtvcvi/aDsfbxPRxBceob0fFvjcGLgPlCn/Du6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bk2+dtlBYtWlZEIdT/fVX8Er9yxmcEnuC1EhSmuQG4VGa0OeH0r6FAEkZNGlEdb1e
	 CViTmsmM9OgfB8kWMFEvuxr29c23bKMwyOHfW81slEf5IGrUNjfd7trPy5MXfLhIXZ
	 d3RJKq/cH5plsSsM3vdoxuCpMS2UKgo/MA79ny90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgFHXSP (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbgFHXSL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB5052083E;
        Mon,  8 Jun 2020 23:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658291;
        bh=9/zpqtvcvi/aDsfbxPRxBceob0fFvjcGLgPlCn/Du6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksueB7PYm8KRNguIr9Q/tkdu0AOoxKY6JLEv3vNoOJbMQ3t226RBmsVNR97BvIMJn
         lZxzOomoVWQfQYMiJzQ4YXK8x78tE4BGyRP/HPglS5nx/eGx96T6As0WX/z5bMvkZJ
         KhYXMaQGGCCSOvDTBfWmgaVr8bEPIc506OgSg7ww=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 295/606] Input: synaptics-rmi4 - really fix attn_data use-after-free
Date:   Mon,  8 Jun 2020 19:07:00 -0400
Message-Id: <20200608231211.3363633-295-sashal@kernel.org>
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

From: Evan Green <evgreen@chromium.org>

[ Upstream commit d5a5e5b5fa7b86c05bf073acc0ba98fa280174ec ]

Fix a use-after-free noticed by running with KASAN enabled. If
rmi_irq_fn() is run twice in a row, then rmi_f11_attention() (among
others) will end up reading from drvdata->attn_data.data, which was
freed and left dangling in rmi_irq_fn().

Commit 55edde9fff1a ("Input: synaptics-rmi4 - prevent UAF reported by
KASAN") correctly identified and analyzed this bug. However the attempted
fix only NULLed out a local variable, missing the fact that
drvdata->attn_data is a struct, not a pointer.

NULL out the correct pointer in the driver data to prevent the attention
functions from copying from it.

Fixes: 55edde9fff1a ("Input: synaptics-rmi4 - prevent UAF reported by KASAN")
Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Signed-off-by: Evan Green <evgreen@chromium.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200427145537.1.Ic8f898e0147beeee2c005ee7b20f1aebdef1e7eb@changeid
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 190b9974526b..c18e1a25bca6 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -205,7 +205,7 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
 
 	if (count) {
 		kfree(attn_data.data);
-		attn_data.data = NULL;
+		drvdata->attn_data.data = NULL;
 	}
 
 	if (!kfifo_is_empty(&drvdata->attn_fifo))
-- 
2.25.1

