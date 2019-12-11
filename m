Return-Path: <SRS0=YbS0=2B=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA68C2D0C7
	for <linux-input@archiver.kernel.org>; Wed, 11 Dec 2019 16:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5689E2077B
	for <linux-input@archiver.kernel.org>; Wed, 11 Dec 2019 16:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Uo6+0Q+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfLKQDZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:03:25 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:7328 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732106AbfLKQDZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Dec 2019 11:03:25 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Y1tg0Hgtzr8;
        Wed, 11 Dec 2019 17:03:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1576080203; bh=qIl1THC9oO+fwYqLjOR13WDhI1qnw2uCdBrbAkY/woU=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Uo6+0Q+STy4xcVHhXBJ/ColQ2+cbMOdnq7CqLeU0lhqnbmOFt+qDu6JEl+3KaCevK
         Ftp8UcfXmsdjPsvzB8RxU3r+bzw5u20/3nYjtmbsGwdCjHzQEOvVETeiyS8gjVpgXS
         q5yBsQWrHQCA4PTCZ0X/wlGB45DxAi4cIqQM2gdBEPNmI+qSAGyt4qEJdX7NBxzWQZ
         tqWX4SFfSGLUM+waOnkmD+UPUVNvZY59uEm2dbjnPvtxBgRHS6A3Ibp5tA8904RpWO
         UNoMe8LR8H3iJ3rMxSKitV/bglAZ1op83/lApJW1IBPnXczP6Nzwe0VBmfM7GrtMa4
         guDpvNHtkZI0g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Wed, 11 Dec 2019 17:03:22 +0100
Message-Id: <77d45d5208804fd99fb4bfae27a43b1da4abf90f.1576079249.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1576079249.git.mirq-linux@rere.qmqm.pl>
References: <cover.1576079249.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/9] input: elants: override touchscreen info with DT
 properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        James Chen <james.chen@emc.com.tw>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh-dt@kernel.org>,
        Scott Liu <scott.liu@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Allow overriding of information from hardware and support additional
common DT properties like axis inversion. This is required for eg.
Nexus 7 and TF300T where the programmed values in firmware differ
from reality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
[moved "prop" before DMA buffer]
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/input/touchscreen/elants_i2c.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index ab9d63239ff5..bc24f52b2932 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/firmware.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/gpio/consumer.h>
@@ -148,6 +149,7 @@ struct elants_data {
 	unsigned int y_res;
 	unsigned int x_max;
 	unsigned int y_max;
+	struct touchscreen_properties prop;
 
 	enum elants_state state;
 	enum elants_iap_mode iap_mode;
@@ -833,8 +835,7 @@ static void elants_i2c_mt_event(struct elants_data *ts, u8 *buf,
 
 			input_mt_slot(input, i);
 			input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
-			input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
-			input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
+			touchscreen_report_pos(input, &ts->prop, x, y, true);
 			input_event(input, EV_ABS, ABS_MT_PRESSURE, p);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, w);
 
@@ -1267,6 +1268,8 @@ static int elants_i2c_probe(struct i2c_client *client,
 	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
 	input_abs_set_res(ts->input, ABS_MT_POSITION_Y, ts->y_res);
 
+	touchscreen_parse_properties(ts->input, true, &ts->prop);
+
 	error = input_register_device(ts->input);
 	if (error) {
 		dev_err(&client->dev,
-- 
2.20.1

