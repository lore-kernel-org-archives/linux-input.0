From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 3/7] Input: pwm-beeper - use input_set_capability()
Date: Thu, 19 Jan 2017 14:40:53 -0800
Message-ID: <20170119224057.9995-3-dmitry.torokhov@gmail.com>
References: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36480 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbdASWlC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 17:41:02 -0500
In-Reply-To: <20170119224057.9995-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>, Frieder Schrempf <frieder.schrempf@exceet.de>

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
2.11.0.483.g087da7b7c-goog

