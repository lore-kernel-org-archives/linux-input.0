From: Sean Young <sean@mess.org>
Subject: [PATCH 1/3] input: remove redundant check for EV_REP
Date: Fri, 24 Nov 2017 11:43:59 +0000
Message-ID: <19939ec6f47e552c8c0b552d35cc0640a6af74f3.1511523174.git.sean@mess.org>
References: <cover.1511523174.git.sean@mess.org>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1511523174.git.sean@mess.org>
In-Reply-To: <cover.1511523174.git.sean@mess.org>
References: <cover.1511523174.git.sean@mess.org>
Sender: linux-media-owner@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The caller input_pass_values has already checked this bit.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/input/input.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 762bfb9487dc..ecc41d65b82a 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -74,9 +74,7 @@ static int input_defuzz_abs_event(int value, int old_val, int fuzz)
 
 static void input_start_autorepeat(struct input_dev *dev, int code)
 {
-	if (test_bit(EV_REP, dev->evbit) &&
-	    dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] &&
-	    dev->timer.data) {
+	if (dev->rep[REP_PERIOD] && dev->rep[REP_DELAY] && dev->timer.data) {
 		dev->repeat_key = code;
 		mod_timer(&dev->timer,
 			  jiffies + msecs_to_jiffies(dev->rep[REP_DELAY]));
-- 
2.14.3
