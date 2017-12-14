From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] input - leds: do not iterate over non initialized leds
Date: Thu, 14 Dec 2017 14:25:21 +0100
Message-ID: <20171214132522.20346-2-benjamin.tissoires@redhat.com>
References: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We only instantiate the led classes if there is a definition in
input_led_info[].
However, the max for EV_LED is bigger than the values filled in this
array, and there are some holes in it.

In .connect(), we check for these holes, but in leds_init_work() we do
not, leading to some nice kernel oopses.

Found by running https://github.com/whot/fuzzydevice

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/input-leds.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index 83d930f7396a..c86eb3d648bf 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -94,6 +94,9 @@ static void leds_init_work(struct work_struct *work)
 	int led_no = 0;
 
 	for_each_set_bit(led_code, leds->handle.dev->ledbit, LED_CNT) {
+		if (!input_led_info[led_code].name)
+			continue;
+
 		led = &leds->leds[led_no];
 
 		down_read(&led->cdev.trigger_lock);
-- 
2.14.3
