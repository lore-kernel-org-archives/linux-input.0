Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AB6C43460
	for <linux-input@archiver.kernel.org>; Mon, 19 Apr 2021 08:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 735FB61107
	for <linux-input@archiver.kernel.org>; Mon, 19 Apr 2021 08:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbhDSIj7 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 19 Apr 2021 04:39:59 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59415 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237717AbhDSIj5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Apr 2021 04:39:57 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1FB6E5C00D6;
        Mon, 19 Apr 2021 04:39:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 04:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=Ce9Y9YKTf2RGN
        +1Lg+fvm8yJDxZYIMZFZEP5ALleVhM=; b=Fky6wf+dNakOSJskz3NvOTyu0rgfE
        xWPs67af36YFHQU0AJ4ewa5MTMXwwJNrxKA+u79O8zbhc2GINibKITbyFbHnKI9/
        b7CbObmtldrxMdZMTvv8HkIh+jolgO8FhvwfLWqsAmWGUQpMvrX7+iqfU8SFwOXo
        oWZdrLXv7xfJU2tLCMzTa04ARXbUZb96r6O0y/qRaink5rH7zSAEA0pRDOCFVxyU
        avqRwr4WPDeH/Bg6bwclU4YRKaND+8HdoZtPlj4JjvHXzwkRZQ/tl/RsGXXrK4X8
        qmj4lzmHKM6i0AKmLfL5ochK92erFdTVbqALXAuNnv/S6Ccyl3ymzqflg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=Ce9Y9YKTf2RGN+1Lg+fvm8yJDxZYIMZFZEP5ALleVhM=; b=ErldjM1z
        kO7d9PeA6gPtMr2RN6gm/6QOjjtCRGF/hFIVmLhRO/A2nbYMwIngGOaKrPQgMpiR
        2Qo6fKLlZLzKT9deAWwsZ1OxM+Fo3bfTByxRtH/aNLuGf1cOh7M8jvNVLmCo3RfE
        mYqu8uffCNvgqeP+Qwg9IDVxz7aNHDJKVRtN40Pxs06dJBRZNJA8p7fhghLoRp/X
        qVBBcuZtIAJfIuMlIhhIxKLxDqBy0DzAj1paxr0lq+VE5Y6PVDpLSLpwU3k2fExC
        aKQ83/xXbaFAvk3IoVsXS2v9G5om8zfLshgC4EGqatsyuXNeBhH0McqRcnbDGmbZ
        aJ3n5KVu9z0sDA==
X-ME-Sender: <xms:wEF9YGHOqPLt-ZovSJWn7YUXAnx2Oy7EETceSbwrkC7rQsQCX89WJw>
    <xme:wEF9YHUhraKT6Smm5hTAldvrvhsLvwlbPcUOyb42qOxud5lUuLvNLb3PcwsxsdoHI
    w2tD26xHUyte9beBOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgr
    ihhrsegrlhhishhtrghirhdvfedrmhgvqeenucggtffrrghtthgvrhhnpeeggedtteejke
    eggeeugfehueevudegvdetjeeviedugedvtdekffekhedtteduhfenucfkphepkeelrdeg
    gedruddtrdduvdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:wEF9YAK1AhVFWGwXd8upNuHw8j1KZtcY8v5iefou2KPauYK9cPUinw>
    <xmx:wEF9YAFKgj8JgN-T8hFNS0j-6pMsarMbtrdmsMYwPsWYmPXm-A1vNg>
    <xmx:wEF9YMUsJmzLIixpVHeXgMX9Qh6fVLaG-KyoTX6pSNIoeFqg5RKTjw>
    <xmx:wEF9YDQDT66kigYGFuVtit2JYXYMDRnpegl4zPVGKZqzO6P51AhMfg>
Received: from ThinkpadX1Yoga3.localdomain (unknown [89.44.10.123])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5552A108005B;
        Mon, 19 Apr 2021 04:39:25 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v5 4/9] Input: wacom_i2c - Add touchscren properties
Date:   Mon, 19 Apr 2021 07:00:59 +1000
Message-Id: <20210418210104.2876-4-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210418210104.2876-1-alistair@alistair23.me>
References: <20210418210104.2876-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Connect touchscreen properties to the wacom_i2c.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 drivers/input/touchscreen/wacom_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index dd3fc54d3825..28290724b3da 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include <linux/irq.h>
+#include <linux/input/touchscreen.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <asm/unaligned.h>
@@ -33,6 +34,7 @@ struct wacom_features {
 struct wacom_i2c {
 	struct i2c_client *client;
 	struct input_dev *input;
+	struct touchscreen_properties props;
 	u8 data[WACOM_QUERY_SIZE];
 	bool prox;
 	int tool;
@@ -114,12 +116,12 @@ static irqreturn_t wacom_i2c_irq(int irq, void *dev_id)
 
 	wac_i2c->prox = data[3] & 0x20;
 
+	touchscreen_report_pos(input, &wac_i2c->props, features.x_max,
+			       features.y_max, true);
 	input_report_key(input, BTN_TOUCH, tsw || ers);
 	input_report_key(input, wac_i2c->tool, wac_i2c->prox);
 	input_report_key(input, BTN_STYLUS, f1);
 	input_report_key(input, BTN_STYLUS2, f2);
-	input_report_abs(input, ABS_X, x);
-	input_report_abs(input, ABS_Y, y);
 	input_report_abs(input, ABS_PRESSURE, pressure);
 	input_sync(input);
 
@@ -188,6 +190,7 @@ static int wacom_i2c_probe(struct i2c_client *client,
 	__set_bit(BTN_STYLUS2, input->keybit);
 	__set_bit(BTN_TOUCH, input->keybit);
 
+	touchscreen_parse_properties(input, true, &wac_i2c->props);
 	input_set_abs_params(input, ABS_X, 0, features.x_max, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, features.y_max, 0, 0);
 	input_set_abs_params(input, ABS_PRESSURE,
-- 
2.31.1

