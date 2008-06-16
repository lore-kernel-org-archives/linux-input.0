From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Mon, 16 Jun 2008 14:34:52 -0400
Message-ID: <20080616143112.ZZRA012@mailhub.coreip.homeip.net>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:61638 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbYFPSfV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Jun 2008 14:35:21 -0400
Received: by yx-out-2324.google.com with SMTP id 31so496689yxl.1
        for <linux-input@vger.kernel.org>; Mon, 16 Jun 2008 11:35:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48556723.2090204@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Hi Anssi,

On Sun, Jun 15, 2008 at 10:01:55PM +0300, Anssi Hannula wrote:
> Hi all!
> 
> It seems a new spinlock input_dev->event_lock has been added [1] to the
> input subsystem since the force feedback support was reworked.
> 
> However, the force feedback subsystem sleeps on events in multiple
> places, e.g. ff-core.c uses a mutex, and hid-pidff driver waits for hid
> io (otherwise commands were lost, IIRC; if necessary I'll test again).
> 
> ff_device->mutex is used to shield effects[], so it is locked when
> handling EV_FF events, on flushes, and on effect upload and erase ioctls.
> 
> Maybe we should make EV_FF handling atomic? For effect uploading we
> could either make it completely atomic, or lock only for reserving the
> effect slot, then release the lock, and mark it as ready after upload is
> complete.
> Making even the upload completely atomic would mean that no force
> feedback events/ioctl() would sleep, which AFAIK would be a plus for
> userspace ff applications. On the other hand, hid-pidff (device managed
> mode) driver doesn't know whether effect upload was successful until it
> has received a report from the device, so it wouldn't be able to report
> failure immediately. Other drivers would, though.
> 
> What do you think?
> 

I think something the patch below is what is needed. EV_FF handling is
already atomic because of event_lock (and it is here to stay), but
uploading does not need to be atomic, only installing into effect
table needs the lock. Any change you could test the patch? I dont have
any FF devices.

Thanks!

-- 
Dmitry


Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/ff-core.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux/drivers/input/ff-core.c
===================================================================
--- linux.orig/drivers/input/ff-core.c
+++ linux/drivers/input/ff-core.c
@@ -166,8 +166,10 @@ int input_ff_upload(struct input_dev *de
 	if (ret)
 		goto out;
 
+	spin_lock_irq(&dev->event_lock);
 	ff->effects[id] = *effect;
 	ff->effect_owners[id] = file;
+	spin_unlock_irq(&dev->event_lock);
 
  out:
 	mutex_unlock(&ff->mutex);
@@ -189,16 +191,22 @@ static int erase_effect(struct input_dev
 	if (error)
 		return error;
 
+	spin_lock_irq(&dev->event_lock);
 	ff->playback(dev, effect_id, 0);
+	ff->effect_owners[effect_id] = NULL;
+	spin_unlock_irq(&dev->event_lock);
 
 	if (ff->erase) {
 		error = ff->erase(dev, effect_id);
-		if (error)
+		if (error) {
+			spin_lock_irq(&dev->event_lock);
+			ff->effect_owners[effect_id] = file;
+			spin_unlock_irq(&dev->event_lock);
+
 			return error;
+		}
 	}
 
-	ff->effect_owners[effect_id] = NULL;
-
 	return 0;
 }
 
@@ -263,8 +271,6 @@ int input_ff_event(struct input_dev *dev
 	if (type != EV_FF)
 		return 0;
 
-	mutex_lock(&ff->mutex);
-
 	switch (code) {
 	case FF_GAIN:
 		if (!test_bit(FF_GAIN, dev->ffbit) || value > 0xffff)
@@ -286,7 +292,6 @@ int input_ff_event(struct input_dev *dev
 		break;
 	}
 
-	mutex_unlock(&ff->mutex);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(input_ff_event);
