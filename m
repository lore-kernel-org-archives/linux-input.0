From: "Du, Alek" <alek.du@intel.com>
Subject: [PATCH] [resend] INPUT: Give more precise auto repeat control for
 gpio_keys driver
Date: Wed, 24 Jun 2009 22:29:36 +0800
Message-ID: <EADF0A36011179459010BDF5142A457501C9E91F28@pdsmsx502.ccr.corp.intel.com>
References: <20090611200754.572f8268@dxy.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32110 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597AbZFXOap convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2009 10:30:45 -0400
In-Reply-To: <20090611200754.572f8268@dxy.sh.intel.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

>From 99fbdefb4d9e74e5641e892bb9fbe7cae1c1e39a Mon Sep 17 00:00:00 2001
From: Alek Du <alek.du@intel.com>
Date: Fri, 8 May 2009 12:35:48 +0800
Subject: [PATCH] INPUT: Give more precise auto repeat control for gpio_keys driver

gpio_keys_platform_data has a rep flag to control auto repeat feature. But
It is not enough, for example, there is a situation that most of buttons are repeatable, while some buttons like poweroff or mute can't be repeatable. By adding another repeat flag for gpio_keys_button, we could precisely control that.

Signed-off-by: Alek Du <alek.du@intel.com>
---
 drivers/input/keyboard/gpio_keys.c |    3 +++
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5e9fb79..bfde124 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -50,6 +50,9 @@ static void gpio_keys_report_event(struct work_struct *work)
 	int state = (gpio_get_value(button->gpio) ? 1 : 0) ^ button->active_low;
 
 	input_event(input, type, button->code, !!state);
+	/* if button disabled auto repeat */
+	if (state && test_bit(EV_REP, input->evbit) && button->norep)
+		input_event(input, type, button->code, 0);
 	input_sync(input);
 }
 
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 1289fa7..ffda87c 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -10,6 +10,7 @@ struct gpio_keys_button {
 	int type;		/* input event type (EV_KEY, EV_SW) */
 	int wakeup;		/* configure the button as a wake-up source */
 	int debounce_interval;	/* debounce ticks interval in msecs */
+	unsigned int norep:1;	/* more precise auto repeat control */
 };
 
 struct gpio_keys_platform_data {
-- 
1.6.0.4
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
