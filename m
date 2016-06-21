From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix effect aborting in ff-memless
Date: Mon, 20 Jun 2016 20:24:10 -0700
Message-ID: <20160621032410.GA35864@dtor-ws>
References: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
 <20160620173303.GA22426@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34807 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbcFUDYO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 23:24:14 -0400
Received: by mail-pf0-f196.google.com with SMTP id 66so318956pfy.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2016 20:24:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160620173303.GA22426@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>, Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org

On Mon, Jun 20, 2016 at 10:33:03AM -0700, Dmitry Torokhov wrote:
> On Sun, Jun 19, 2016 at 02:44:35PM +0200, Manuel Reimer wrote:
> > Hello,
> > 
> > while debugging a problem with hid-sony I got stuck with a problem
> > actually caused by ff-memless. In some situations effect aborting is
> > delayed, so it may be triggered seconds after all devices have been
> > destroyed, which causes the kernel to panic.
> > 
> > The aborting request actually gets received here:
> > https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L467
> > This "aborting" flag is then handled here:
> > https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L376
> > But before this line is reached, there is a time check to check if
> > the effect actually is due to be started:
> > https://github.com/torvalds/linux/blob/master/drivers/input/ff-memless.c#L359
> > 
> > This time check now causes a problem if the effect, which is meant
> > to be *aborted* was scheduled to be *started* some time in future
> > and the device is destroyed before this time is reached.
> 
> I am not clear how this can happen. If effect hasn't actually started
> playing (i.e. we have FF_EFFECT_STARTED bit set, but FF_EFFECT_PLAYING
> is not yet set), then when stopping effect we do not need to do anything
> except clear FF_EFFECT_STARTED (since we did not touch the hardware
> yet).
> 
> Now, if FF_EFFECT_PLAYING is set, that means that play_at time is in
> the past and we won't be skipping this effect in ml_get_combo_effect().
> 
> Could you please post a stack trace of the crash you observed?

Actually, I wonder if the patch below will fix the issue you are seeing.

Thanks.

-- 
Dmitry


Input: fix flushing of FF effects when unregistering devices

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/input.c |   10 +++++++---
 include/linux/input.h |    8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index d95c34e..220aa17 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -144,7 +144,7 @@ static void input_pass_values(struct input_dev *dev,
 		count = input_to_handler(handle, vals, count);
 	} else {
 		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
-			if (handle->open) {
+			if (handle->active) {
 				count = input_to_handler(handle, vals, count);
 				if (!count)
 					break;
@@ -552,7 +552,7 @@ static void __input_release_device(struct input_handle *handle)
 		synchronize_rcu();
 
 		list_for_each_entry(handle, &dev->h_list, d_node)
-			if (handle->open && handle->handler->start)
+			if (handle->active && handle->handler->start)
 				handle->handler->start(handle);
 	}
 }
@@ -613,6 +613,8 @@ int input_open_device(struct input_handle *handle)
 		}
 	}
 
+	handle->active = handle->open > 0;
+
  out:
 	mutex_unlock(&dev->mutex);
 	return retval;
@@ -663,6 +665,8 @@ void input_close_device(struct input_handle *handle)
 		synchronize_rcu();
 	}
 
+	handle->active = handle->open > 0;
+
 	mutex_unlock(&dev->mutex);
 }
 EXPORT_SYMBOL(input_close_device);
@@ -716,7 +720,7 @@ static void input_disconnect_device(struct input_dev *dev)
 	input_dev_release_keys(dev);
 
 	list_for_each_entry(handle, &dev->h_list, d_node)
-		handle->open = 0;
+		handle->active = false;
 
 	spin_unlock_irq(&dev->event_lock);
 }
diff --git a/include/linux/input.h b/include/linux/input.h
index 1e96769..87ec2f7 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -307,8 +307,10 @@ struct input_handler {
 /**
  * struct input_handle - links input device with an input handler
  * @private: handler-specific data
- * @open: counter showing whether the handle is 'open', i.e. should deliver
- *	events from its device
+ * @open: counter showing whether the handle is 'open', i.e. there is
+ *	a consumer for the events from input device
+ * @active: indicates that input events should be delivered from input
+ *	device to input handler through this handle
  * @name: name given to the handle by handler that created it
  * @dev: input device the handle is attached to
  * @handler: handler that works with the device through this handle
@@ -321,6 +323,8 @@ struct input_handle {
 	void *private;
 
 	int open;
+	bool active;
+
 	const char *name;
 
 	struct input_dev *dev;
