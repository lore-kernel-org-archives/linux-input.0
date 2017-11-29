From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/2] Input: gpio-beeper: use helper variable to access device
 info
Date: Wed, 29 Nov 2017 12:07:36 +0100
Message-ID: <20171129110736.GB24064@lenoch>
References: <20171129110627.GA24064@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([148.251.95.138]:55266 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbdK2LHi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 06:07:38 -0500
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990477AbdK2LHhyb4tI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 29 Nov 2017 12:07:37 +0100
Content-Disposition: inline
In-Reply-To: <20171129110627.GA24064@lenoch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Using explicit struct device variable makes code a bit more readable.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Note: and it become more usefull one patch later

 drivers/input/misc/gpio-beeper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
index 16272fffeb7e..409c85da71c3 100644
--- a/drivers/input/misc/gpio-beeper.c
+++ b/drivers/input/misc/gpio-beeper.c
@@ -64,18 +64,19 @@ static void gpio_beeper_close(struct input_dev *input)
 
 static int gpio_beeper_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct gpio_beeper *beep;
 	struct input_dev *input;
 
-	beep = devm_kzalloc(&pdev->dev, sizeof(*beep), GFP_KERNEL);
+	beep = devm_kzalloc(dev, sizeof(*beep), GFP_KERNEL);
 	if (!beep)
 		return -ENOMEM;
 
-	beep->desc = devm_gpiod_get(&pdev->dev, NULL, GPIOD_OUT_LOW);
+	beep->desc = devm_gpiod_get(dev, NULL, GPIOD_OUT_LOW);
 	if (IS_ERR(beep->desc))
 		return PTR_ERR(beep->desc);
 
-	input = devm_input_allocate_device(&pdev->dev);
+	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
 
-- 
2.15.0

