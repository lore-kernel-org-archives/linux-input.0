From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: tsc2007 - switch to using input_set_capability()
Date: Fri, 17 Feb 2017 14:56:27 -0800
Message-ID: <20170217225627.GA27132@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36148 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964811AbdBQW4b (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Feb 2017 17:56:31 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org

Do not manipulate evbit/keybit directly, use helper for that.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index fdf81a2b989a..98dbefc3357d 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -364,8 +364,7 @@ static int tsc2007_probe(struct i2c_client *client,
 
 	input_set_drvdata(input_dev, ts);
 
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
 	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, 0);
 	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, 0);
-- 
2.11.0.483.g087da7b7c-goog


-- 
Dmitry
