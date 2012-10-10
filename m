From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input: extend the number of event (and other) devices
Date: Wed, 10 Oct 2012 09:58:16 -0700
Message-ID: <20121010165816.GF19335@core.coreip.homeip.net>
References: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
 <1349298182-22452-4-git-send-email-dmitry.torokhov@gmail.com>
 <CANq1E4SK9poZO7etxYNmKHpK3SX1OM+0JC71HTC0f8h1uYDfBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42657 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab2JJQ6V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Oct 2012 12:58:21 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so271252dak.19
        for <linux-input@vger.kernel.org>; Wed, 10 Oct 2012 09:58:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANq1E4SK9poZO7etxYNmKHpK3SX1OM+0JC71HTC0f8h1uYDfBg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org

Hi David,

On Sun, Oct 07, 2012 at 04:52:28PM +0200, David Herrmann wrote:
> Hi Dmitry
> 
> On Wed, Oct 3, 2012 at 11:03 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> [snip]
> 
> > @@ -991,43 +950,47 @@ static void evdev_cleanup(struct evdev *evdev)
> >
> >  /*
> >   * Create new evdev device. Note that input core serializes calls
> > - * to connect and disconnect so we don't need to lock evdev_table here.
> > + * to connect and disconnect.
> >   */
> >  static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
> >                          const struct input_device_id *id)
> >  {
> >         struct evdev *evdev;
> >         int minor;
> > +       int dev_no;
> >         int error;
> >
> > -       for (minor = 0; minor < EVDEV_MINORS; minor++)
> > -               if (!evdev_table[minor])
> > -                       break;
> > -
> > -       if (minor == EVDEV_MINORS) {
> > -               pr_err("no more free evdev devices\n");
> > -               return -ENFILE;
> > +       minor = input_get_new_minor(EVDEV_MINOR_BASE, EVDEV_MINORS, true);
> > +       if (minor < 0) {
> > +               error = minor;
> > +               pr_err("failed to reserve new minor: %d\n", error);
> > +               return error;
> 
> You could also do:
>  return minor;
> So you can drop that "error = minor;" line.

Right, but I prefer doing this to signify that the value in 'minor' is
actually an error code.

> 
> [snip]
> 
> > @@ -1062,6 +1028,7 @@ static void evdev_disconnect(struct input_handle *handle)
> >
> >         device_del(&evdev->dev);
> >         evdev_cleanup(evdev);
> > +       input_free_minor(MINOR(evdev->dev.devt));
> 
> I was wondering whether we should free the minors in evdev_free()
> instead. Because if we free them here, we might end up with two
> user-space applications listening to the same cdev (based on
> major/minor) but to different input devices that drive the cdev.
> 
> The older of both cdevs would be already dead and I don't think this
> is a big issue, but I just wanted to mention it if others can think of
> corner cases where this would be bad.

I believe this is OK and how the rest of Unix objects work - they do not
get freed until all users release them, but new users will get the new
instance.

> 
> [snip]
> 
> > @@ -2016,22 +2017,14 @@ EXPORT_SYMBOL(input_unregister_device);
> >  int input_register_handler(struct input_handler *handler)
> >  {
> >         struct input_dev *dev;
> > -       int retval;
> > +       int error;
> >
> > -       retval = mutex_lock_interruptible(&input_mutex);
> > -       if (retval)
> > -               return retval;
> > +       error = mutex_lock_interruptible(&input_mutex);
> > +       if (error)
> > +               return error;
> 
> Still wondering why you change that variable name here?

My style preference: when the same variable is used to return error
codes and success/real values I call it retval. If I have separate error
handling path and explicit success path I use "return error;"/"return 0;".
Here we transitioned to explicitly returning success, so I changed the
name.

> 
> [snip]
> 
> > @@ -576,13 +556,14 @@ static int mousedev_open(struct inode *inode, struct file *file)
> >                 goto err_free_client;
> >
> >         file->private_data = client;
> > +       nonseekable_open(inode, file);
> 
> Ouh, seems like we never called this for mousedevs, isn't that a bug
> that should also go to stable? It just sets some flags but I am not
> sure what happends if we don't set them.
> It isn't related to this patch (I think?).

I split it out, but we do not need it for stable. We still were
installing noop_llseek() fops handler so it should still work even
without nonseekable_open().

> 
> [snip]
> 
> Sorry for the bikeshedding. The patch looks really good and all I
> found are just minor optional suggestions (or personal taste).

Thank you very mich for going over the code!

> Thanks a lot for fixing this! It looks much better than my first approach.
> 
> Reviewed-by: David Herrmann <dh.herrmann@googlemail.com>
> 
> Regards
> David

-- 
Dmitry
