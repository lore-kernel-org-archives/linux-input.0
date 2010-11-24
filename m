From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH WIP 1/6] fixup gpio_buttons: use the same debounce_interval member found in gpio_key to obtain a threshold count based on polling interval
Date: Wed, 24 Nov 2010 16:01:35 -0500
Message-ID: <08372c879762c2b1c2accd013318ffb6765f806c.1290631852.git.bengardiner@nanometrics.ca>
References: <1290524800-21419-10-git-send-email-juhosg@openwrt.org> <cover.1290631852.git.bengardiner@nanometrics.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34995 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756333Ab0KXVBo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 16:01:44 -0500
Received: by mail-yw0-f49.google.com with SMTP id 7so110886ywf.8
        for <linux-input@vger.kernel.org>; Wed, 24 Nov 2010 13:01:43 -0800 (PST)
In-Reply-To: <cover.1290631852.git.bengardiner@nanometrics.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-input@vger.kernel.org

my reasoning was that if the debounce interval was set then the platform 
_wants_ to supress spurious events so it was better to roundup and swallow 
real events than round down and not supress. 

I'm fine also with using the poll_interval and debuonce_interval directly as
you suggested.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
---
 drivers/input/misc/gpio_buttons.c |    7 +++++--
 include/linux/gpio_buttons.h      |    2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/gpio_buttons.c
index 51288a3..f42906c 100644
--- a/drivers/input/misc/gpio_buttons.c
+++ b/drivers/input/misc/gpio_buttons.c
@@ -68,13 +68,16 @@ static void gpio_buttons_poll(struct input_polled_dev *dev)
 	struct gpio_buttons_dev *bdev = dev->private;
 	struct gpio_buttons_platform_data *pdata = bdev->pdata;
 	struct input_dev *input = dev->input;
-	int i;
+	int i, threshold;
 
 	for (i = 0; i < bdev->pdata->nbuttons; i++) {
 		struct gpio_button *button = &pdata->buttons[i];
 		struct gpio_button_data *bdata = &bdev->data[i];
 
-		if (bdata->count < button->threshold)
+		threshold = round_up(button->debounce_interval,
+				pdata->poll_interval) /
+				pdata->poll_interval;
+		if (bdata->count < threshold)
 			bdata->count++;
 		else
 			gpio_buttons_check_state(input, button, bdata);
diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_buttons.h
index f85b993..c016f07 100644
--- a/include/linux/gpio_buttons.h
+++ b/include/linux/gpio_buttons.h
@@ -21,7 +21,7 @@ struct gpio_button {
 	char	*desc;		/* button description */
 	int	type;		/* input event type (EV_KEY, EV_SW) */
 	int	code;		/* input event code (KEY_*, SW_*) */
-	int	threshold;	/* count threshold */
+	int debounce_interval;	/* debounce ticks interval in msecs */
 };
 
 struct gpio_buttons_platform_data {
-- 
1.7.0.4

