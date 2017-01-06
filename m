From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3 v2] Input: pwm-beeper - use input_set_capability()
Date: Fri, 6 Jan 2017 10:29:28 -0800
Message-ID: <20170106182928.GA2474@dtor-ws>
References: <20170106182050.2772-1-dmitry.torokhov@gmail.com>
 <20170106182050.2772-3-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34533 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031876AbdAFS3b (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Jan 2017 13:29:31 -0500
Content-Disposition: inline
In-Reply-To: <20170106182050.2772-3-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>

Instead of manipulating capability bits directly, let's use
input_set_capability() API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/pwm-beeper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index 14c52054f5b7..ce6eec48ec5f 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -131,8 +131,8 @@ static int pwm_beeper_probe(struct platform_device *pdev)
 	beeper->input->id.product = 0x0001;
 	beeper->input->id.version = 0x0100;
 
-	beeper->input->evbit[0] = BIT(EV_SND);
-	beeper->input->sndbit[0] = BIT(SND_TONE) | BIT(SND_BELL);
+	input_set_capability(beeper->input, EV_SND, SND_TONE);
+	input_set_capability(beeper->input, EV_SND, SND_BELL);
 
 	beeper->input->event = pwm_beeper_event;
 	beeper->input->close = pwm_beeper_close;
-- 
2.11.0.390.gc69c2f50cf-goog

