From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/3] ASoC: tlv320dac33: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 14:26:09 +0530
Message-ID: <b61f3ee038bc0f577e60256c71a68bea783d0a13.1524819052.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-input@vger.kernel.org

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/codecs/tlv320dac33.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index a957eae..c23b9db 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -397,13 +397,13 @@ static int dac33_hard_power(struct snd_soc_component *component, int power)
 				goto exit;
 		}
 
-		if (dac33->power_gpio >= 0)
+		if (gpio_is_valid(dac33->power_gpio))
 			gpio_set_value(dac33->power_gpio, 1);
 
 		dac33->chip_power = 1;
 	} else {
 		dac33_soft_power(component, 0);
-		if (dac33->power_gpio >= 0)
+		if (gpio_is_valid(dac33->power_gpio))
 			gpio_set_value(dac33->power_gpio, 0);
 
 		ret = regulator_bulk_disable(ARRAY_SIZE(dac33->supplies),
@@ -1519,7 +1519,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
 	/* Check if the reset GPIO number is valid and request it */
-	if (dac33->power_gpio >= 0) {
+	if (gpio_is_valid(dac33->power_gpio)) {
 		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
 		if (ret < 0) {
 			dev_err(&client->dev,
@@ -1548,7 +1548,7 @@ static int dac33_i2c_probe(struct i2c_client *client,
 
 	return ret;
 err_get:
-	if (dac33->power_gpio >= 0)
+	if (gpio_is_valid(dac33->power_gpio))
 		gpio_free(dac33->power_gpio);
 err_gpio:
 	return ret;
@@ -1561,7 +1561,7 @@ static int dac33_i2c_remove(struct i2c_client *client)
 	if (unlikely(dac33->chip_power))
 		dac33_hard_power(dac33->component, 0);
 
-	if (dac33->power_gpio >= 0)
+	if (gpio_is_valid(dac33->power_gpio))
 		gpio_free(dac33->power_gpio);
 
 	return 0;
-- 
1.9.1
