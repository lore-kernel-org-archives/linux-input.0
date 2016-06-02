From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: [PATCH v2] hid-sony: Prevent crash when rumble effects are still
 loaded at USB disconnect
Date: Thu, 2 Jun 2016 19:53:27 +0200
Message-ID: <01146ebc-3710-e3cd-812a-ca4f0ef84372@m-reimer.de>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de>
 <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
 <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:36003 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932967AbcFBRxj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jun 2016 13:53:39 -0400
In-Reply-To: <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, jikos@kernel.org

On 05/30/2016 09:15 PM, Manuel Reimer wrote:
> It may now actually be possible that the memory has been freed again and
> some event in the queue kicked in after that. It may also be possible
> that the hid driver subsystem doesn't really like this case, that the
> device is stopped, but someone still sends to it.

It definitively seems to be a bad idea to continue to interact with the 
HID device as soon as hid_hw_stop was called.

"Somewhere" while hid_hw_stop is running, the cleanup of loaded force 
feedback events is happening. I don't know if schedule_work will run the 
work asynchronously. If so, then calls could be triggered even after 
hid_hw_stop is already finished.

One possible option would be to add a input_unregister_device into 
sony_remove right before the call to "sony_cancel_work_sync". A call to 
input_unregister_device triggers the cleanup, too and so allows to move 
this to a point earlier in the shutdown procedure. But I don't know if 
this is actually a good idea to do this here.

At the end of this mail is a second attempt for a fix. The idea of this 
is, that after "sony_cancel_work_sync" was called, the worker itself 
shouldn't be able to take any new work. To do this, I set 
worker_initialized back to zero and check for this in a newly introduced 
function sony_schedule_work. This seems to fix the problem. If I pull 
the plug while effects are loaded or playing, then I get one or more of 
my added error messages, but, so far, no more kernel panic.

So finally I am at a point where I need feedback to continue my work. 
Would be great if someone could offer some help.

Signed-off-by: Manuel Reimer <mail@m-reimer.de>

--- a/drivers/hid/hid-sony.c	2016-05-13 16:13:00.339346161 +0200
+++ b/drivers/hid/hid-sony.c	2016-06-02 19:33:59.621212336 +0200
@@ -1051,6 +1051,14 @@ struct sony_sc {
  	__u8 led_count;
  };

+static inline void sony_schedule_work(struct sony_sc *sc)
+{
+	if (sc->worker_initialized)
+		schedule_work(&sc->state_worker);
+	else
+		printk(KERN_ERR "hid-sony: Sending to uninitialized device failed!\n");
+}
+
  static __u8 *sixaxis_fixup(struct hid_device *hdev, __u8 *rdesc,
  			     unsigned int *rsize)
  {
@@ -1542,7 +1550,7 @@ static void buzz_set_leds(struct sony_sc
  static void sony_set_leds(struct sony_sc *sc)
  {
  	if (!(sc->quirks & BUZZ_CONTROLLER))
-		schedule_work(&sc->state_worker);
+		sony_schedule_work(sc);
  	else
  		buzz_set_leds(sc);
  }
@@ -1653,7 +1661,7 @@ static int sony_led_blink_set(struct led
  		new_off != drv_data->led_delay_off[n]) {
  		drv_data->led_delay_on[n] = new_on;
  		drv_data->led_delay_off[n] = new_off;
-		schedule_work(&drv_data->state_worker);
+		sony_schedule_work(drv_data);
  	}

  	return 0;
@@ -1963,7 +1971,7 @@ static int sony_play_effect(struct input
  	sc->left = effect->u.rumble.strong_magnitude / 256;
  	sc->right = effect->u.rumble.weak_magnitude / 256;

-	schedule_work(&sc->state_worker);
+	sony_schedule_work(sc);
  	return 0;
  }

@@ -2265,8 +2273,10 @@ static inline void sony_init_output_repo

  static inline void sony_cancel_work_sync(struct sony_sc *sc)
  {
-	if (sc->worker_initialized)
+	if (sc->worker_initialized) {
+		sc->worker_initialized = 0;
  		cancel_work_sync(&sc->state_worker);
+	}
  }

  static int sony_probe(struct hid_device *hdev, const struct 
hid_device_id *id)
