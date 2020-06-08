Return-Path: <SRS0=8jYR=7V=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541E1C433E0
	for <linux-input@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E42E2086A
	for <linux-input@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658297;
	bh=kMZ8z483ON/zTTVEyFoP7XJhnrafJFQO56c/L6OUIsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tsebwjalEgHQ/syv3GK0UE+xRJjBI9lICQ+ATDsN0WQGu8UE3SCTFxWqfWtCAizvi
	 OrTHLv3KRbbSWIizTQLAANoC+m0nNuxDMImd0RUXU3mo1CCvpQKwLPLQcpVrXo+74o
	 nb5t1C5/z5Vvq7MvW0rC+tPEZN6eU5tawRgX92hY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgFHXSN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbgFHXSM (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 120A220842;
        Mon,  8 Jun 2020 23:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658292;
        bh=kMZ8z483ON/zTTVEyFoP7XJhnrafJFQO56c/L6OUIsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nl/G01bTyM4JCF2WaJ9D8OyhMHa5IxOqoWiebSo/oipOmB89ypbamcbOZTy6gugPa
         RpnOSNuR2tQK/O+olskoAUzvsIHxYSPSJsxE31rshKLfZa8YS+HRx3vYZyeHfP/6LT
         Ex/nDPEwUpKtVSCkwQsLntWXZYnJU/vbWF9KX/HU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 296/606] Input: synaptics-rmi4 - fix error return code in rmi_driver_probe()
Date:   Mon,  8 Jun 2020 19:07:01 -0400
Message-Id: <20200608231211.3363633-296-sashal@kernel.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

[ Upstream commit 5caab2da63207d6d631007f592f5219459e3454d ]

Fix to return a negative error code from the input_register_device()
error handling case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Link: https://lore.kernel.org/r/20200428134948.78343-1-weiyongjun1@huawei.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index c18e1a25bca6..258d5fe3d395 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -1210,7 +1210,8 @@ static int rmi_driver_probe(struct device *dev)
 	if (data->input) {
 		rmi_driver_set_input_name(rmi_dev, data->input);
 		if (!rmi_dev->xport->input) {
-			if (input_register_device(data->input)) {
+			retval = input_register_device(data->input);
+			if (retval) {
 				dev_err(dev, "%s: Failed to register input device.\n",
 					__func__);
 				goto err_destroy_functions;
-- 
2.25.1

