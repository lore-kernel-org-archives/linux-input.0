From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input: evdev: fix queueing of SYN_DROPPED event for
 EVIOCG[type] IOCTL case
Date: Sun, 22 Jan 2017 11:45:21 +0100
Message-ID: <CANq1E4S62r=j3nMBHoGekdp+_VscPXPzM0tiWN7UM54U+OtFpw@mail.gmail.com>
References: <1480018303-4220-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34163 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbdAVKpW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 05:45:22 -0500
In-Reply-To: <1480018303-4220-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <a.mathur@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Aniroop Mathur <aniroop.mathur@gmail.com>, s.samuel@samsung.com, r.mahale@samsung.com

Hi

On Thu, Nov 24, 2016 at 9:11 PM, Aniroop Mathur <a.mathur@samsung.com> wrote:
> Currently, when EVIOCG[type] ioctl call is issued and bits_to_user fails,
> then SYN_DROPPED event is inserted in the event queue always.
>
> However, it is not compulsory that some events are flushed out on every
> EVIOCG[type] ioctl call like in case of empty event queue and in case when
> EVIOCG[type] ioctl is issued for say A type of events but event queue does
> not have any A type of events but some other type of events.
>
> Therefore, insert SYN_DROPPED event only when some events have been flushed
> out from event queue plus bits_to_user fails.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/evdev.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index e9ae3d5..f8b295e 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -108,9 +108,11 @@ static bool __evdev_is_filtered(struct evdev_client *client,
>  }
>
>  /* flush queued events of type @type, caller must hold client->buffer_lock */
> -static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
> +static unsigned int __evdev_flush_queue(struct evdev_client *client,
> +                                       unsigned int type)
>  {
>         unsigned int i, head, num;
> +       unsigned int drop_count = 0;
>         unsigned int mask = client->bufsize - 1;
>         bool is_report;
>         struct input_event *ev;
> @@ -129,9 +131,11 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>
>                 if (ev->type == type) {
>                         /* drop matched entry */
> +                       drop_count++;
>                         continue;
>                 } else if (is_report && !num) {
>                         /* drop empty SYN_REPORT groups */
> +                       drop_count++;

Dropping an empty report-group should not be considered in
`drop_count` here. Empty report groups carry no information and should
not affect client's state. You should only increment `drop_count` in
the first block.

>                         continue;
>                 } else if (head != i) {
>                         /* move entry to fill the gap */
> @@ -151,6 +155,7 @@ static void __evdev_flush_queue(struct evdev_client *client, unsigned int type)
>         }
>
>         client->head = head;
> +       return drop_count;
>  }
>
>  static void __evdev_queue_syn_dropped(struct evdev_client *client)
> @@ -920,6 +925,7 @@ static int evdev_handle_get_val(struct evdev_client *client,
>         int ret;
>         unsigned long *mem;
>         size_t len;
> +       unsigned int drop_count = 0;
>
>         len = BITS_TO_LONGS(maxbit) * sizeof(unsigned long);
>         mem = kmalloc(len, GFP_KERNEL);
> @@ -933,12 +939,12 @@ static int evdev_handle_get_val(struct evdev_client *client,
>
>         spin_unlock(&dev->event_lock);
>
> -       __evdev_flush_queue(client, type);
> +       drop_count = __evdev_flush_queue(client, type);
>
>         spin_unlock_irq(&client->buffer_lock);
>
>         ret = bits_to_user(mem, maxbit, maxlen, p, compat);
> -       if (ret < 0)
> +       if (ret < 0 && drop_count > 0)
>                 evdev_queue_syn_dropped(client);

I don't see the point. If bits_to_user() fails, you get EFAULT.
User-space cannot assume anything is still valid if they get EFAULT.
This is not like ENOMEM or other errors that you can recover from.
EFAULT means _programming_ error, not runtime exception.

IOW, EFAULT is special nearly everywhere in the kernel. Usually,
whenever a syscall returns an error, you can rely on it to not have
modified state. EFAULT is an exception on most paths, since it might
occur when copying over results, and it is overly expensive to handle
EFAULT gracefully there (you'd have to copy _results_ to user-space,
before making them visible to the system).

Long story short: I don't see the point in this patch. This path is
*never* triggered, except if your client is buggy. And even if you
trigger it, placing SYN_DROPPED in the queue does no harm at all.

Care to elaborate why exactly you want this modification?
David

>
>         kfree(mem);
> --
> 2.6.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
