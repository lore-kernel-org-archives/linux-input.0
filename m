From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: leds - fix out of bound access
Date: Fri, 6 Apr 2018 11:12:42 -0700
Message-ID: <20180406181242.GA225849@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Tasos Sahanidis <tasos@tasossah.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>
List-Id: linux-input@vger.kernel.org

UI_SET_LEDBIT ioctl() causes the following KASAN splat when used with
led > LED_CHARGING:

[ 1274.663418] BUG: KASAN: slab-out-of-bounds in input_leds_connect+0x611/0x730 [input_leds]
[ 1274.663426] Write of size 8 at addr ffff88003377b2c0 by task ckb-next-daemon/5128

This happens because we were writing to the led structure before making
sure that it exists.

Reported-by: Tasos Sahanidis <tasos@tasossah.com>
Tested-by: Tasos Sahanidis <tasos@tasossah.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input-leds.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 766bf26601163..5f04b2d946350 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -88,6 +88,7 @@ static int input_leds_connect(struct input_handler *handler,
 			      const struct input_device_id *id)
 {
 	struct input_leds *leds;
+	struct input_led *led;
 	unsigned int num_leds;
 	unsigned int led_code;
 	int led_no;
@@ -119,14 +120,13 @@ static int input_leds_connect(struct input_handler *handler,
 
 	led_no = 0;
 	for_each_set_bit(led_code, dev->ledbit, LED_CNT) {
-		struct input_led *led = &leds->leds[led_no];
+		if (!input_led_info[led_code].name)
+			continue;
 
+		led = &leds->leds[led_no];
 		led->handle = &leds->handle;
 		led->code = led_code;
 
-		if (!input_led_info[led_code].name)
-			continue;
-
 		led->cdev.name = kasprintf(GFP_KERNEL, "%s::%s",
 					   dev_name(&dev->dev),
 					   input_led_info[led_code].name);
-- 
2.17.0.484.g0c8726318c-goog


-- 
Dmitry
