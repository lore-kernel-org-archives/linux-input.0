From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 3/6] fixup gpio_buttons: detect and error-out if a button is requested for wakeup
Date: Wed, 24 Nov 2010 16:01:37 -0500
Message-ID: <3c1b59654d0cb56680662eae33db0eff3add546c.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56194 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:46 -0500
Received: by yxl31 with SMTP id 31so934610yxl.0
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:46 -0800 (PST)
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org

I'm fine also with ignoring the value of wakeup as you suggested.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 drivers/input/misc/gpio_buttons.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/gpio_buttons.c
index c34e978..0859b4d 100644
--- a/drivers/input/misc/gpio_buttons.c
+++ b/drivers/input/misc/gpio_buttons.c
@@ -136,6 +136,11 @@ static int __devinit gpio_buttons_probe(struct platform_device *pdev)
 		unsigned int gpio = button->gpio;
 		unsigned int type = button->type ?: EV_KEY;
 
+		if (button->wakeup) {
+			dev_err(dev, DRV_NAME " does not support wakeup\n");
+			goto err_free_gpio;
+		}
+
 		error = gpio_request(gpio,
 				     button->desc ? button->desc : DRV_NAME);
 		if (error) {
-- 
1.7.0.4

