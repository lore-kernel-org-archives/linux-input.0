From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/2] Input: gpio_keys - Set ABS params when using axes
Date: Tue,  1 Nov 2016 11:25:04 +0100
Message-ID: <20161101102504.3783-3-paul@crapouillou.net>
References: <20161101102504.3783-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161101102504.3783-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Maarten ter Huurne <maarten@treewalker.org>, Paul Cercueil <paul@crapouillou.net>
List-Id: linux-input@vger.kernel.org

The gpio-keys supports the EV_ABS event type, but does not actually
configure the input device to work with that mode.

This patch configures the axis corresponding to button->code as being
in the range [-1,+1]. This makes it possible to use gpio-keys to
implement a hat (using the ABS_HAT0X /ABS_HAT0Y axes, with two GPIOs
each with values -1/+1).

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/input/keyboard/gpio_keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 7018c49..1f2850a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -540,6 +540,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 
 	input_set_capability(input, button->type ?: EV_KEY, button->code);
 
+	if (button->type == EV_ABS)
+		input_set_abs_params(input, button->code, -1, 1, 0, 0);
+
 	/*
 	 * Install custom action to cancel release timer and
 	 * workqueue item.
-- 
2.9.3
