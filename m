From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] Input: soc_button_array - Debounce the buttons
Date: Mon,  9 Jan 2017 18:57:07 +0100
Message-ID: <20170109175707.12854-2-hdegoede@redhat.com>
References: <20170109175707.12854-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422779AbdAIR5L (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 9 Jan 2017 12:57:11 -0500
In-Reply-To: <20170109175707.12854-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org

The soc_button_array driver was initializing (kzalloc) the
debounce_interval value to 0, leading to no debouncing at all,
while the buttons are simple mechanical switches.

This commit sets debounce_interval to 50ms to avoid spurious button
press reports both on press and release of the button. Note 50ms may
seem like a lot but soc_button_array is typically used with cheap
tablets, with not so great buttons. I tried 10ms on my tablet and it
is not enough, where as 50ms works well.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/misc/soc_button_array.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index d2e5186..e53b0a1 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -101,6 +101,8 @@ soc_button_device_create(struct platform_device *pdev,
 		gpio_keys[n_buttons].active_low = 1;
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
+		/* These devices often use cheap buttons, use 50 ms debounce */
+		gpio_keys[n_buttons].debounce_interval = 50;
 		n_buttons++;
 	}
 
-- 
2.9.3

