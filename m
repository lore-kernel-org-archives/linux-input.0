From: Oliver Neukum <oneukum@suse.de>
Subject: Re: question on releasing keys
Date: Thu, 6 May 2010 15:33:49 +0200
Message-ID: <201005061533.49845.oneukum@suse.de>
References: <201004281053.52598.oneukum@suse.de> <201004280942.25746.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34439 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758110Ab0EFNeF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 09:34:05 -0400
In-Reply-To: <201004280942.25746.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Am Mittwoch, 28. April 2010 18:42:24 schrieb Dmitry Torokhov:
> Hi Oliver,
> 
> On Wednesday 28 April 2010 01:53:52 am Oliver Neukum wrote:
> > Hi,
> > 
> > I am seeing a generic problem with buttons on devices released during S3.
> > The input layer then assumes that the button is still pressed. It would be
> > best for drivers to either verify that a button is still held or
> > alternatively, to release all buttons upon resumption. Is there a generic
> > way to do that?
> >
> 
> I think input core should force release of all keys when device is
> being suspended, I guess we need to change input.c::input_dev_reset().

Something like this?

	Regards
		Oliver

>From 96c19e9e0c6164655600e764a9b5c3a6f132723d Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 6 May 2010 15:30:28 +0200
Subject: [PATCH] input: release pressed keys during resume()

As the kernel has no way to know whether a key was released
while the system was asleep, keys need to be reported released
as the system is resumed, lest autorepeat set in.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/input/input.c |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 9c79bd5..04be575 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -528,6 +528,27 @@ void input_close_device(struct input_handle *handle)
 EXPORT_SYMBOL(input_close_device);
 
 /*
+ * Simulate keyup events for all pressed keys so that handlers
+ * are not left with "stuck" keys. The driver may continue
+ * generate events even after we done here but they will not
+ * reach any handlers.
+ */
+static void release_keys(struct input_dev *dev)
+{
+	int code;
+
+	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
+		for (code = 0; code <= KEY_MAX; code++) {
+			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
+			    __test_and_clear_bit(code, dev->key)) {
+				input_pass_event(dev, EV_KEY, code, 0);
+			}
+		}
+		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
+	}
+}
+
+/*
  * Prepare device for unregistering
  */
 static void input_disconnect_device(struct input_dev *dev)
@@ -546,21 +567,7 @@ static void input_disconnect_device(struct input_dev *dev)
 
 	spin_lock_irq(&dev->event_lock);
 
-	/*
-	 * Simulate keyup events for all pressed keys so that handlers
-	 * are not left with "stuck" keys. The driver may continue
-	 * generate events even after we done here but they will not
-	 * reach any handlers.
-	 */
-	if (is_event_supported(EV_KEY, dev->evbit, EV_MAX)) {
-		for (code = 0; code <= KEY_MAX; code++) {
-			if (is_event_supported(code, dev->keybit, KEY_MAX) &&
-			    __test_and_clear_bit(code, dev->key)) {
-				input_pass_event(dev, EV_KEY, code, 0);
-			}
-		}
-		input_pass_event(dev, EV_SYN, SYN_REPORT, 1);
-	}
+	release_keys(dev);
 
 	list_for_each_entry(handle, &dev->h_list, d_node)
 		handle->open = 0;
@@ -1433,6 +1440,9 @@ static int input_dev_resume(struct device *dev)
 
 	mutex_lock(&input_dev->mutex);
 	input_dev_reset(input_dev, true);
+	spin_lock_irq(&input_dev->event_lock);
+	release_keys(input_dev);
+	spin_unlock_irq(&input_dev->event_lock);
 	mutex_unlock(&input_dev->mutex);
 
 	return 0;
-- 
1.6.4.2

