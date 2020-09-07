Return-Path: <SRS0=pnPe=CQ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4D2C433E2
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 20:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38FFA21582
	for <linux-input@archiver.kernel.org>; Mon,  7 Sep 2020 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIGUky (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgIGUkx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2020 16:40:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D05C061573;
        Mon,  7 Sep 2020 13:40:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6F9B5285353
Received: by jupiter.universe (Postfix, from userid 1000)
        id 08765480115; Mon,  7 Sep 2020 22:40:47 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        =?UTF-8?q?Myl=C3=A8ne=20Josserand?= 
        <mylene.josserand@collabora.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv2 2/4] Input: rotary-encoder - Fix steps property reading
Date:   Mon,  7 Sep 2020 22:40:43 +0200
Message-Id: <20200907204045.95530-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907204045.95530-1-sebastian.reichel@collabora.com>
References: <20200907204045.95530-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

The DT binding specifies 24 being used by default, but driver
initializes to 0. The steps variable will be used for a modulo
operation at a later step, so do not allow 0 (does not make
sense in any case).

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/input/misc/rotary_encoder.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 6d613f2a017c..e9a5dbb10513 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -198,7 +198,12 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 
 	mutex_init(&encoder->access_mutex);
 
+	encoder->steps = 24;
 	device_property_read_u32(dev, "rotary-encoder,steps", &encoder->steps);
+	if (!encoder->steps) {
+		dev_err(dev, "invalid steps setting\n");
+		return -EINVAL;
+	}
 
 	err = device_property_read_u32(dev, "rotary-encoder,steps-per-period",
 				       &steps_per_period);
-- 
2.28.0

