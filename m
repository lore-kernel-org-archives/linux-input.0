From: Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] input: ar1021_i2c: add previously wrongly removed ABS_X parameter
Date: Mon,  1 May 2017 16:57:09 +0200
Message-ID: <20170501145709.9803-1-martink@posteo.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout02.posteo.de ([185.67.36.66]:48606 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756893AbdEAO5V (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 1 May 2017 10:57:21 -0400
Received: from submission (posteo.de [89.146.220.130])
        by mout02.posteo.de (Postfix) with ESMTPS id 7ECCB20BC4
        for <linux-input@vger.kernel.org>; Mon,  1 May 2017 16:57:19 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>

The recent change

commit 2098cc15d9a0 ("Input: ar1021_i2c - enable touch mode during open")

also removed the ABS_X input code to be set. This must have been done
by mistake; so we bring back the X axis!

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

Dmitry,

this must have slipped in somehow. I didn't have this mistake included:
https://www.spinics.net/lists/linux-input/msg51103.html

thanks
                         martin


 drivers/input/touchscreen/ar1021_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index ff59c3a383d6..3f55f673f661 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -118,6 +118,7 @@ static int ar1021_i2c_probe(struct i2c_client *client,
 	input->close = ar1021_i2c_close;
 
 	input_set_capability(input, EV_KEY, BTN_TOUCH);
+	input_set_abs_params(input, ABS_X, 0, AR1021_MAX_X, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, AR1021_MAX_Y, 0, 0);
 
 	input_set_drvdata(input, ar1021);
-- 
2.11.0

