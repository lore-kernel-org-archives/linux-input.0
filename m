From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 4/4] Input: extend the number of event (and other) devices
Date: Sun, 7 Oct 2012 16:52:28 +0200
Message-ID: <CANq1E4SK9poZO7etxYNmKHpK3SX1OM+0JC71HTC0f8h1uYDfBg@mail.gmail.com>
References: <1349298182-22452-1-git-send-email-dmitry.torokhov@gmail.com>
	<1349298182-22452-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44150 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab2JGOwa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Oct 2012 10:52:30 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so2816263wib.1
        for <linux-input@vger.kernel.org>; Sun, 07 Oct 2012 07:52:28 -0700 (PDT)
In-Reply-To: <1349298182-22452-4-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry

On Wed, Oct 3, 2012 at 11:03 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

[snip]

> @@ -991,43 +950,47 @@ static void evdev_cleanup(struct evdev *evdev)
>
>  /*
>   * Create new evdev device. Note that input core serializes calls
> - * to connect and disconnect so we don't need to lock evdev_table here.
> + * to connect and disconnect.
>   */
>  static int evdev_connect(struct input_handler *handler, struct input_dev *dev,
>                          const struct input_device_id *id)
>  {
>         struct evdev *evdev;
>         int minor;
> +       int dev_no;
>         int error;
>
> -       for (minor = 0; minor < EVDEV_MINORS; minor++)
> -               if (!evdev_table[minor])
> -                       break;
> -
> -       if (minor == EVDEV_MINORS) {
> -               pr_err("no more free evdev devices\n");
> -               return -ENFILE;
> +       minor = input_get_new_minor(EVDEV_MINOR_BASE, EVDEV_MINORS, true);
> +       if (minor < 0) {
> +               error = minor;
> +               pr_err("failed to reserve new minor: %d\n", error);
> +               return error;

You could also do:
 return minor;
So you can drop that "error = minor;" line.

[snip]

> @@ -1062,6 +1028,7 @@ static void evdev_disconnect(struct input_handle *handle)
>
>         device_del(&evdev->dev);
>         evdev_cleanup(evdev);
> +       input_free_minor(MINOR(evdev->dev.devt));

I was wondering whether we should free the minors in evdev_free()
instead. Because if we free them here, we might end up with two
user-space applications listening to the same cdev (based on
major/minor) but to different input devices that drive the cdev.

The older of both cdevs would be already dead and I don't think this
is a big issue, but I just wanted to mention it if others can think of
corner cases where this would be bad.

[snip]

> @@ -2016,22 +2017,14 @@ EXPORT_SYMBOL(input_unregister_device);
>  int input_register_handler(struct input_handler *handler)
>  {
>         struct input_dev *dev;
> -       int retval;
> +       int error;
>
> -       retval = mutex_lock_interruptible(&input_mutex);
> -       if (retval)
> -               return retval;
> +       error = mutex_lock_interruptible(&input_mutex);
> +       if (error)
> +               return error;

Still wondering why you change that variable name here?

[snip]

> @@ -576,13 +556,14 @@ static int mousedev_open(struct inode *inode, struct file *file)
>                 goto err_free_client;
>
>         file->private_data = client;
> +       nonseekable_open(inode, file);

Ouh, seems like we never called this for mousedevs, isn't that a bug
that should also go to stable? It just sets some flags but I am not
sure what happends if we don't set them.
It isn't related to this patch (I think?).

[snip]

Sorry for the bikeshedding. The patch looks really good and all I
found are just minor optional suggestions (or personal taste).
Thanks a lot for fixing this! It looks much better than my first approach.

Reviewed-by: David Herrmann <dh.herrmann@googlemail.com>

Regards
David
