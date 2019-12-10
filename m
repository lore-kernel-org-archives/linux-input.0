Return-Path: <SRS0=db+e=2A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01B1C04E30
	for <linux-input@archiver.kernel.org>; Tue, 10 Dec 2019 00:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B476420838
	for <linux-input@archiver.kernel.org>; Tue, 10 Dec 2019 00:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="WtYMlSZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfLJATi (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 9 Dec 2019 19:19:38 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:33426 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfLJATU (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 9 Dec 2019 19:19:20 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47X0ws1pr4zKW;
        Tue, 10 Dec 2019 01:16:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575937005; bh=YsyNObBBW1OvJDWq+l2QUR44LJx4brO0CWUVjUFNO6I=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=WtYMlSZCQ3PVpW0dr9oxJkJm3qsavL4CXsGsKF2SW6MWhbSpXLiFno9XEiqEJEYTK
         hEzWm41lhpTpqklbPgGpkLjL5dag0s4skYYTsBR0VL06wVkt7ZDmpc+8euA9+Bq3N6
         hpLR8U9u1fKESj0LxxTSngKJ/qouyICKZAYE22VtMu9PrmEUiws63ocqJjKV4IvC72
         6gm0KHScnpdSYBjwWr+7Xf4zP5zT/7KLe5eLCm6mFbllRsFHKL1+viZ1xVsLupbnn9
         mQcXLGPnReSxd/BU8XvkTzA2kxktt9HZARWNOoz5NnE1NJJzSWuJBNuiLfEceeIzsM
         0qfly5zBIyalg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 10 Dec 2019 01:19:17 +0100
Message-Id: <7e650a6ef98e3178d6829c3c2c83f21437070d84.1575936961.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1575936961.git.mirq-linux@rere.qmqm.pl>
References: <cover.1575936961.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/6] input: elants: support common touchscreen DT properties
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Support common DT properties like axis inversions to complement
information obtained from device's firmware.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/input/touchscreen/elants_i2c.c | 27 ++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index eadd26d5a06f..02bd5e3e2171 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -31,6 +31,7 @@
 #include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
+#include <linux/input/touchscreen.h>
 #include <linux/input/mt.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -146,8 +147,7 @@ struct elants_data {
 	u16 hw_version;
 	unsigned int x_res;	/* resolution in units/mm */
 	unsigned int y_res;
-	unsigned int x_max;
-	unsigned int y_max;
+	struct touchscreen_properties prop;
 
 	enum elants_state state;
 	enum elants_iap_mode iap_mode;
@@ -498,10 +498,10 @@ static int elants_i2c_query_ts_info(struct elants_data *ts)
 			 rows, cols, osr);
 	} else {
 		/* translate trace number to TS resolution */
-		ts->x_max = ELAN_TS_RESOLUTION(rows, osr);
-		ts->x_res = DIV_ROUND_CLOSEST(ts->x_max, phy_x);
-		ts->y_max = ELAN_TS_RESOLUTION(cols, osr);
-		ts->y_res = DIV_ROUND_CLOSEST(ts->y_max, phy_y);
+		ts->prop.max_x = ELAN_TS_RESOLUTION(rows, osr);
+		ts->x_res = DIV_ROUND_CLOSEST(ts->prop.max_x, phy_x);
+		ts->prop.max_y = ELAN_TS_RESOLUTION(cols, osr);
+		ts->y_res = DIV_ROUND_CLOSEST(ts->prop.max_y, phy_y);
 	}
 
 	return 0;
@@ -833,8 +833,7 @@ static void elants_i2c_mt_event(struct elants_data *ts, u8 *buf,
 
 			input_mt_slot(input, i);
 			input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
-			input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
-			input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
+			touchscreen_report_pos(input, &ts->prop, x, y, true);
 			input_event(input, EV_ABS, ABS_MT_PRESSURE, p);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, w);
 
@@ -1251,13 +1250,15 @@ static int elants_i2c_probe(struct i2c_client *client,
 	ts->input->name = "Elan Touchscreen";
 	ts->input->id.bustype = BUS_I2C;
 
+	touchscreen_parse_properties(ts->input, true, &ts->prop);
+
 	__set_bit(BTN_TOUCH, ts->input->keybit);
 	__set_bit(EV_ABS, ts->input->evbit);
 	__set_bit(EV_KEY, ts->input->evbit);
 
 	/* Single touch input params setup */
-	input_set_abs_params(ts->input, ABS_X, 0, ts->x_max, 0, 0);
-	input_set_abs_params(ts->input, ABS_Y, 0, ts->y_max, 0, 0);
+	input_set_abs_params(ts->input, ABS_X, 0, ts->prop.max_x, 0, 0);
+	input_set_abs_params(ts->input, ABS_Y, 0, ts->prop.max_y, 0, 0);
 	input_set_abs_params(ts->input, ABS_PRESSURE, 0, 255, 0, 0);
 	input_abs_set_res(ts->input, ABS_X, ts->x_res);
 	input_abs_set_res(ts->input, ABS_Y, ts->y_res);
@@ -1271,8 +1272,10 @@ static int elants_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, ts->x_max, 0, 0);
-	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, ts->y_max, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_POSITION_X,
+			     0, ts->prop.max_x, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_POSITION_Y,
+			     0, ts->prop.max_y, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
 	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
-- 
2.20.1

