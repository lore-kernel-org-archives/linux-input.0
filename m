From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: [PATCH] Fix effect aborting in ff-memless
Date: Sun, 19 Jun 2016 14:44:35 +0200
Message-ID: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:47534 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbcFSMpK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Jun 2016 08:45:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org, dmitry.torokhov@gmail.com

Hello,

while debugging a problem with hid-sony I got stuck with a problem 
actually caused by ff-memless. In some situations effect aborting is 
delayed, so it may be triggered seconds after all devices have been 
destroyed, which causes the kernel to panic.

The aborting request actually gets received here:
https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L467
This "aborting" flag is then handled here:
https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L376
But before this line is reached, there is a time check to check if the 
effect actually is due to be started:
https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L359

This time check now causes a problem if the effect, which is meant to be 
*aborted* was scheduled to be *started* some time in future and the 
device is destroyed before this time is reached.

My patch fixes this by setting the trigger times to "now" after setting 
the aborting flag. This way the following code deals with aborting the 
effect immediately without setting a timer for it.

There may be other ways to fix this, so I would be happy to get some 
feedback.


Signed-off-by: Manuel Reimer <mail@m-reimer.de>

--- a/drivers/input/ff-memless.c	2016-05-13 16:06:29.722685021 +0200
+++ b/drivers/input/ff-memless.c	2016-06-19 14:25:39.790375270 +0200
@@ -463,9 +463,11 @@ static int ml_ff_playback(struct input_d
  	} else {
  		pr_debug("initiated stop\n");

-		if (test_bit(FF_EFFECT_PLAYING, &state->flags))
+		if (test_bit(FF_EFFECT_PLAYING, &state->flags)) {
  			__set_bit(FF_EFFECT_ABORTING, &state->flags);
-		else
+			state->play_at = jiffies;
+			state->adj_at = jiffies;
+		} else
  			__clear_bit(FF_EFFECT_STARTED, &state->flags);
  	}

