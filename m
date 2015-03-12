From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH] input: misc: pwm-beeper: remove useless call to pwm_config()
Date: Thu, 12 Mar 2015 14:09:30 +0100
Message-ID: <1426165770-11130-1-git-send-email-olivier@sobrie.be>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:45837 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893AbbCLNJl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Mar 2015 09:09:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

Calling pwm_config() with a period equal to zero always results in
error (-EINVAL) and pwm chip config method is never called.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---
 drivers/input/misc/pwm-beeper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index a28ee70..2a23643 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -50,7 +50,6 @@ static int pwm_beeper_event(struct input_dev *input,
 	}
 
 	if (value == 0) {
-		pwm_config(beeper->pwm, 0, 0);
 		pwm_disable(beeper->pwm);
 	} else {
 		period = HZ_TO_NANOSECONDS(value);
-- 
1.9.1

