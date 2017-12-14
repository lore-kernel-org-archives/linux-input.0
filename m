From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] input - leds: fix input_led_disconnect path
Date: Thu, 14 Dec 2017 14:25:22 +0100
Message-ID: <20171214132522.20346-3-benjamin.tissoires@redhat.com>
References: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171214132522.20346-1-benjamin.tissoires@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Before unregistering the led classes, we have to be sure there is no
more events in the input pipeline.
Closing the input node before removing the led classes flushes the
pipeline and this prevents segfaults.

Found with https://github.com/whot/fuzzydevice
Link: https://bugzilla.kernel.org/show_bug.cgi?id=197679

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/input-leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/input-leds.c b/drivers/input/input-leds.c
index c86eb3d648bf..8aefcc186a02 100644
--- a/drivers/input/input-leds.c
+++ b/drivers/input/input-leds.c
@@ -211,6 +211,7 @@ static void input_leds_disconnect(struct input_handle *handle)
 	int i;
 
 	cancel_delayed_work_sync(&leds->init_work);
+	input_close_device(handle);
 
 	for (i = 0; i < leds->num_leds; i++) {
 		struct input_led *led = &leds->leds[i];
@@ -219,7 +220,6 @@ static void input_leds_disconnect(struct input_handle *handle)
 		kfree(led->cdev.name);
 	}
 
-	input_close_device(handle);
 	input_unregister_handle(handle);
 
 	kfree(leds);
-- 
2.14.3
