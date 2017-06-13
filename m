From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2] HID: Replace semaphore driver_lock with mutex
Date: Tue, 13 Jun 2017 11:56:18 +0200
Message-ID: <20170613095618.GB29589@mail.corp.redhat.com>
References: <1497345926-3262-1-git-send-email-binoy.jayan@linaro.org>
 <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752515AbdFMJ40 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 05:56:26 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a27bGLpisra1YDT7VntWByk6oS0Fz3e2E0-Nmf-6pVYCA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Binoy Jayan <binoy.jayan@linaro.org>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Jiri Kosina <jikos@kernel.org>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

Hi,

On Jun 13 2017 or thereabouts, Arnd Bergmann wrote:
> On Tue, Jun 13, 2017 at 11:25 AM, Binoy Jayan <binoy.jayan@linaro.org> wrote:
> > The semaphore 'driver_lock' is used as a simple mutex, and
> > also unnecessary as suggested by Arnd. Hence removing it, as
> > the concurrency between the probe and remove is already
> > handled in the driver core.
> >
> > Signed-off-by: Binoy Jayan <binoy.jayan@linaro.org>
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks good to me, but I see you didn't include David and Andrew on
> Cc, it would be good for at least one of them to provide an Ack as well.

Please also CC linux-input@

> 
> quoting the entire patch for reference, one more comment below:
> 

As stated by Arnd in v1, this semaphore only protects probe/removed from
being called concurrently on the same device. And as Arnd said, the
driver model should prevent this to ever happen.

So Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

(one more nitpick below too)

> > ---
> >
> > v1 --> v2
> >
> > Removed driver_lock
> >
> >  drivers/hid/hid-core.c | 15 ++++-----------
> >  include/linux/hid.h    |  2 +-
> >  2 files changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 04cee65..559533b 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2225,11 +2225,9 @@ static int hid_device_probe(struct device *dev)
> >         const struct hid_device_id *id;
> >         int ret = 0;
> >
> > -       if (down_interruptible(&hdev->driver_lock))
> > -               return -EINTR;
> >         if (down_interruptible(&hdev->driver_input_lock)) {
> >                 ret = -EINTR;
> > -               goto unlock_driver_lock;
> > +               goto end;
> >         }
> >         hdev->io_started = false;
> >
> > @@ -2256,8 +2254,7 @@ static int hid_device_probe(struct device *dev)
> >  unlock:
> >         if (!hdev->io_started)
> >                 up(&hdev->driver_input_lock);
> > -unlock_driver_lock:
> > -       up(&hdev->driver_lock);
> > +end:
> >         return ret;
> >  }
> >
> > @@ -2267,11 +2264,9 @@ static int hid_device_remove(struct device *dev)
> >         struct hid_driver *hdrv;
> >         int ret = 0;
> >
> > -       if (down_interruptible(&hdev->driver_lock))
> > -               return -EINTR;
> >         if (down_interruptible(&hdev->driver_input_lock)) {
> >                 ret = -EINTR;
> > -               goto unlock_driver_lock;
> > +               goto end;
> >         }
> >         hdev->io_started = false;
> >
> > @@ -2287,8 +2282,7 @@ static int hid_device_remove(struct device *dev)
> >
> >         if (!hdev->io_started)
> >                 up(&hdev->driver_input_lock);
> > -unlock_driver_lock:
> > -       up(&hdev->driver_lock);
> > +end:
> >         return ret;
> >  }
> >
> > @@ -2745,7 +2739,6 @@ struct hid_device *hid_allocate_device(void)
> >         init_waitqueue_head(&hdev->debug_wait);
> >         INIT_LIST_HEAD(&hdev->debug_list);
> >         spin_lock_init(&hdev->debug_list_lock);
> > -       sema_init(&hdev->driver_lock, 1);
> >         sema_init(&hdev->driver_input_lock, 1);
> >
> >         return hdev;
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index 5be325d..1add2b3 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -516,7 +516,7 @@ struct hid_device {                                                 /* device report descriptor */
> >         struct hid_report_enum report_enum[HID_REPORT_TYPES];
> >         struct work_struct led_work;                                    /* delayed LED worker */
> >

A little bit below, there is:
	bool io_started;						/* Protected by driver_lock. If IO has started */

You should probably remove the mention to driver_lock here.

> > -       struct semaphore driver_lock;                                   /* protects the current driver, except during input */
> > +       struct mutex driver_lock;                                       /* protects the current driver, except during input */
> >         struct semaphore driver_input_lock;                             /* protects the current driver */

Unless I am mistaken, this one could also be converted to a mutex (in a
separate patch, of course).

Cheers,
Benjamin

> >         struct device dev;                                              /* device */
> >         struct hid_driver *driver;
> 
> You forgot to actually drop the definition.
> 
>        Arnd
