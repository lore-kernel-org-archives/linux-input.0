From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - Use EBADFD for flush() errors
Date: Thu, 3 Sep 2015 22:37:23 -0700
Message-ID: <20150904053723.GB22340@dtor-ws>
References: <1439969895-26163-1-git-send-email-tiwai@suse.de>
 <s5hvbbuvhki.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36067 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbbIDFh0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2015 01:37:26 -0400
Received: by pacwi10 with SMTP id wi10so13463921pac.3
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2015 22:37:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hvbbuvhki.wl-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-input@vger.kernel.org

Hi Takashi,

On Tue, Sep 01, 2015 at 07:23:25AM +0200, Takashi Iwai wrote:
> On Wed, 19 Aug 2015 09:38:15 +0200,
> Takashi Iwai wrote:
> > 
> > We've got bug reports showing the old systemd-logind (at least
> > system-210) aborting unexpectedly, and this turned out to be because
> > of an invalid error code from close() call to evdev devices.  close()
> > is supposed to return only either EINTR or EBADFD, while the device
> > returned ENODEV.  logind was overreacting to it and decided to kill
> > itself when an unexpected error code was received.  What a tragedy.
> > 
> > The bad error code comes from flush fops, and actually evdev_flush()
> > returns -ENODEV and else.  This patch papers over it, simply fixing
> > the error return code to the acceptable values above.
> > 
> > Bugzilla: http://bugzilla.suse.com/show_bug.cgi?id=939834
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Hi,
> 
> any comments on this patch?
> 

As we have discussed previously returning EBADF will not actually help
failing versions of systemd because they were not expecting getting
any errors from close().

Considering the code and close() behavior I think the best way would be
to stop reporting any errors from evdev_flush(), like in the version of
the patch below. Please let me know if you are OK with this and I'll
apply it.

Thanks!

-- 
Dmitry

Input: evdev - do not report errors form flush()

From: Takashi Iwai <tiwai@suse.de>

We've got bug reports showing the old systemd-logind (at least
system-210) aborting unexpectedly, and this turned out to be because
of an invalid error code from close() call to evdev devices.  close()
is supposed to return only either EINTR or EBADFD, while the device
returned ENODEV.  logind was overreacting to it and decided to kill
itself when an unexpected error code was received.  What a tragedy.

The bad error code comes from flush fops, and actually evdev_flush()
returns -ENODEV when device is disconnected or client's access to it is
revoked. But in these cases the fact that flush did not actually happen is
not an error, but rather normal behavior. For non-disconnected devices
result of flush is also not that interesting as there is no potential of
data loss and even if it fails application has no way of handling the
error. Because of that we are better off always returning success from
evdev_flush().

Also returning -EINTR from flush()/close() is discouraged (as it is not
clear how application should handle this error), so let's stop taking
evdev->mutex interruptibly.

Bugzilla: http://bugzilla.suse.com/show_bug.cgi?id=939834
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/evdev.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index 9d35499..08d4964 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -290,19 +290,14 @@ static int evdev_flush(struct file *file, fl_owner_t id)
 {
 	struct evdev_client *client = file->private_data;
 	struct evdev *evdev = client->evdev;
-	int retval;
 
-	retval = mutex_lock_interruptible(&evdev->mutex);
-	if (retval)
-		return retval;
+	mutex_lock(&evdev->mutex);
 
-	if (!evdev->exist || client->revoked)
-		retval = -ENODEV;
-	else
-		retval = input_flush_device(&evdev->handle, file);
+	if (evdev->exist && !client->revoked)
+		input_flush_device(&evdev->handle, file);
 
 	mutex_unlock(&evdev->mutex);
-	return retval;
+	return 0;
 }
 
 static void evdev_free(struct device *dev)
