From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two locks.
Date: Mon, 11 Feb 2013 11:13:08 -0800
Message-ID: <CAG_cf+cNqrveHTR+JqYueTafH7Jtv+VDebU4QNicfWY3dhY+7w@mail.gmail.com>
References: <CAG_cf+eZ2w4i=a_kMieb92Pa0Gf2aOB_2Bs39G=aB7ui-Y08Pw@mail.gmail.com>
 <CANq1E4Q-dWrf4nwn+SZ4TdjBSZ5i6UEGgVxm=eboZ0i6Dk9ZqA@mail.gmail.com> <20130211185527.63d1c1f9@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:61858 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab3BKTN3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 14:13:29 -0500
Received: by mail-ia0-f177.google.com with SMTP id k38so1245853iah.8
        for <linux-input@vger.kernel.org>; Mon, 11 Feb 2013 11:13:28 -0800 (PST)
In-Reply-To: <20130211185527.63d1c1f9@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Linux Input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, Feb 11, 2013 at 9:55 AM, Bruno Pr=E9mont
<bonbons@linux-vserver.org> wrote:
>
> Hi Andrew, David,
>
> On Mon, 11 February 2013 David Herrmann wrote:
> > Thanks a lot for the patch. I think it's fine and I would like to s=
ee
> > it applied upstream:
> >   Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
>
> Reviewed-by: Bruno Pr=E9mont <bonbons@linux-vserver.org>
>
> > Some small things below. They're just my personal opinion so I am a=
lso
> > ok with this being applied right away.
>
> Same from me, with the idea of making possible driver-bugs more visib=
le.
>
> Thanks,
> Bruno
>
>
> > On Sun, Feb 10, 2013 at 6:47 PM, Andrew de los Reyes
> > <andrew-vger@gizmolabs.org> wrote:
> > > Hi Linux-Input and others,
> > >
> > > This is the latest version of the patch to allow device drivers t=
o
> > > communicate with the corresponding device during probe(). I've
> > > incorporated many of David Herrmann's suggestions into this revis=
ion.
> > > The most notable change is that by using helper functions, we no
> > > longer need to have a special magic number return value from prob=
e().
> > >
> > > This patch is part of a patch series to support Logitech touch de=
vices
> > > (e.g., Wireless Touchpad). The rest of the series is not yet read=
y for
> > > discussion here, but those curious can see it here:
> > > https://github.com/adlr/linux/commits/logitech7
> > >
> > > Thanks for your comments,
> > > -andrew
> > >
> > > This patch separates struct hid_device's driver_lock into two. Th=
e
> > > goal is to allow hid device drivers to receive input during their
> > > probe() or remove() function calls. This is necessary because som=
e
> > > drivers need to communicate with the device to determine paramete=
rs
> > > needed during probe (e.g., size of a multi-touch surface), and if
> > > possible, may perfer to communicate with a device on host-initiat=
ed
> > > disconnect (e.g., to put it into a low-power state).
> > >
> > > Historically, three functions used driver_lock:
> > >
> > > - hid_device_probe: blocks to acquire lock
> > > - hid_device_remove: blocks to acquire lock
> > > - hid_input_report: if locked returns -EBUSY, else acquires lock
> > >
> > > This patch adds another lock (driver_input_lock) which is used to
> > > block input from occurring. The lock behavior is now:
> > >
> > > - hid_device_probe: blocks to acq. driver_lock, then driver_input=
_lock
> > > - hid_device_remove: blocks to acq. driver_lock, then driver_inpu=
t_lock
> > > - hid_input_report: if driver_input_lock locked returns -EBUSY, e=
lse
> > >   acquires driver_input_lock
> > >
> > > This patch also adds two helper functions to be called during pro=
be()
> > > or remove(): hid_device_io_start() and hid_device_io_stop(). Thes=
e
> > > functions lock and unlock, respectively, driver_input_lock; they =
also
> > > make a note of whether they did so that hid-core knows if a drive=
r has
> > > changed the lock state.
> > >
> > > This patch results in no behavior change for existing devices and
> > > drivers. However, during a probe() or remove() function call in a
> > > driver, that driver may now selectively call hid_device_io_start(=
) to
> > > let input events come through, then optionally call
> > > hid_device_io_stop() to stop them.
> > >
> > > Change-Id: I737f6fc15911134b51273acf8d3de92fa5cc0f85
> > > ---
> > >  drivers/hid/hid-core.c | 24 +++++++++++++++++++++---
> > >  include/linux/hid.h    | 36 +++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 56 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > > index 4da66b4..6a04b72 100644
> > > --- a/drivers/hid/hid-core.c
> > > +++ b/drivers/hid/hid-core.c
> > > @@ -1097,7 +1097,7 @@ int hid_input_report(struct hid_device *hid=
, int
> > > type, u8 *data, int size, int i
> > >         if (!hid)
> > >                 return -ENODEV;
> > >
> > > -       if (down_trylock(&hid->driver_lock))
> > > +       if (down_trylock(&hid->driver_input_lock))
> > >                 return -EBUSY;
> > >
> > >         if (!hid->driver) {
> > > @@ -1150,7 +1150,7 @@ nomem:
> > >         hid_report_raw_event(hid, type, data, size, interrupt);
> > >
> > >  unlock:
> > > -       up(&hid->driver_lock);
> > > +       up(&hid->driver_input_lock);
> > >         return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(hid_input_report);
> > > @@ -1703,6 +1703,11 @@ static int hid_device_probe(struct device =
*dev)
> > >
> > >         if (down_interruptible(&hdev->driver_lock))
> > >                 return -EINTR;
> > > +       if (down_interruptible(&hdev->driver_input_lock)) {
> > > +               ret =3D -EINTR;
> > > +               goto unlock_driver_lock;
> > > +       }
> > > +       hdev->io_started =3D false;
> > >
> > >         if (!hdev->driver) {
> > >                 id =3D hid_match_device(hdev, hdrv);
> > > @@ -1726,6 +1731,9 @@ static int hid_device_probe(struct device *=
dev)
> > >                         hdev->driver =3D NULL;
> > >         }
> > >  unlock:
> > > +       if (!hdev->io_started)
> > > +               hid_device_io_start(hdev);
> >
> > For symmetry you might use up() here and use the wrapper-functions
> > only in drivers? I don't know. Jiri should say what he prefers.
>
> Then same for the _remove() case, see below

Sounds good. I'll make this change for both.

>
> > > +unlock_driver_lock:
> > >         up(&hdev->driver_lock);
> > >         return ret;
> > >  }
> > > @@ -1734,9 +1742,15 @@ static int hid_device_remove(struct device=
 *dev)
> > >  {
> > >         struct hid_device *hdev =3D container_of(dev, struct hid_=
device, dev);
> > >         struct hid_driver *hdrv;
> > > +       int ret =3D 0;
> > >
> > >         if (down_interruptible(&hdev->driver_lock))
> > >                 return -EINTR;
> > > +       if (down_interruptible(&hdev->driver_input_lock)) {
> > > +               ret =3D -EINTR;
> > > +               goto unlock_driver_lock;
> > > +       }
> > > +       hdev->io_started =3D false;
> >
> > If we lock driver_input_lock during remove, we might lose important
> > packages here because the input handler drops them.
> >
> > Drivers that require this should deal with it properly, but you mig=
ht
> > get annoying timeouts during remove if you do I/O and lose an
> > important packet here.
> >
> > But I think the proper way to fix this is to move I/O handling into
> > workqueues instead of interrupt-context so we can actually sleep in
> > handle_input. So I think this is fine.
>
> Though the driver would suffer the same timeout if it does not shortc=
ut
> them when the device is being physically unplugged.
> So in both cases the driver does need to take explicit action in ->re=
move()
> probably even before reenabling I/O in order to "cancel" pending acti=
vity
> prior to doing the removal reconfiguration on logical unplug.

The kernel already blocks input during remove(); this patch doesn't
change that behavior. We could have another API that allows drivers to
opt-out of this behavior, but maybe that should be another patch.

-andrew

>
> > >         hdrv =3D hdev->driver;
> > >         if (hdrv) {
> > > @@ -1747,8 +1761,11 @@ static int hid_device_remove(struct device=
 *dev)
> > >                 hdev->driver =3D NULL;
> > >         }
> > >
> > > +       if (!hdev->io_started)
> > > +               hid_device_io_start(hdev);
>
> If withing probe we switch to up() we should go for down() here
>
> > > +unlock_driver_lock:
> > >         up(&hdev->driver_lock);
> > > -       return 0;
> > > +       return ret;
> > >  }
> > >
> > >  static int hid_uevent(struct device *dev, struct kobj_uevent_env=
 *env)
> > > @@ -2126,6 +2143,7 @@ struct hid_device *hid_allocate_device(void=
)
> > >         init_waitqueue_head(&hdev->debug_wait);
> > >         INIT_LIST_HEAD(&hdev->debug_list);
> > >         sema_init(&hdev->driver_lock, 1);
> > > +       sema_init(&hdev->driver_input_lock, 1);
> > >
> > >         return hdev;
> > >  err:
> > > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > > index 3a95da6..ae7d32d 100644
> > > --- a/include/linux/hid.h
> > > +++ b/include/linux/hid.h
> > > @@ -481,7 +481,8 @@ struct hid_device {                          =
                       /* device report descriptor */
> > >         unsigned country;                                        =
       /* HID country */
> > >         struct hid_report_enum report_enum[HID_REPORT_TYPES];
> > >
> > > -       struct semaphore driver_lock;                            =
       /* protects the current driver */
> > > +       struct semaphore driver_lock;                            =
       /* protects the current driver,
> > > except during input */
> > > +       struct semaphore driver_input_lock;                      =
       /* protects the current driver */
> > >         struct device dev;                                       =
       /* device */
> > >         struct hid_driver *driver;
> > >         struct hid_ll_driver *ll_driver;
> > > @@ -502,6 +503,7 @@ struct hid_device {                          =
                       /* device report descriptor */
> > >         unsigned int status;                                     =
       /* see STAT flags above */
> > >         unsigned claimed;                                        =
       /* Claimed by hidinput, hiddev? */
> > >         unsigned quirks;                                         =
       /* Various quirks the device can pull on us */
> > > +       bool io_started;                                         =
       /* Protected by driver_lock. If IO has started */
> > >
> > >         struct list_head inputs;                                 =
       /* The list of inputs */
> > >         void *hiddev;                                            =
       /* The hiddev structure */
> > > @@ -622,6 +624,10 @@ struct hid_usage_id {
> > >   * @resume: invoked on resume if device was not reset (NULL mean=
s nop)
> > >   * @reset_resume: invoked on resume if device was reset (NULL me=
ans nop)
> > >   *
> > > + * probe should return -errno on error, or 0 on success. During =
probe,
> > > + * input will not be passed to raw_event unless hid_device_io_st=
art is
> > > + * called.
> > > + *
> > >   * raw_event and event should return 0 on no action performed, 1=
 when no
> > >   * further processing should be done and negative on error
> > >   *
> > > @@ -742,6 +748,34 @@ const struct hid_device_id *hid_match_id(str=
uct
> > > hid_device *hdev,
> > >                                          const struct hid_device_=
id *id);
> > >
> > >  /**
> > > + * hid_device_io_start - enable HID input during probe, remove
> > > + *
> > > + * @hid - the device
> > > + *
> > > + * This should only be called during probe or remove. It will al=
low
> > > + * incoming packets to be delivered to the driver.
> > > + */
> > > +static inline void hid_device_io_start(struct hid_device *hid) {
> > > +  up(&hid->driver_input_lock);
> > > +  hid->io_started =3D true;
> >
> > Shouldn't these lines be swapped? Doesn't matter but it looks weird=
 to
> > me this way.
> >
> > But more importantly, we must go sure this is called from the same
> > thread that probe() is called on. Other use-cases are not supported=
 by
> > semaphores and might break due to missing barriers. So maybe the
> > comment could include that?
>
> Maybe even check what value hid->io_started has and WARN() [+skip up(=
)/down()]
> in case hid_device_io_start()/stop() was not called in a balanced way=
=2E
>
> > > +}
> > > +
> > > +/**
> > > + * hid_device_io_stop - disable HID input during probe, remove
> > > + *
> > > + * @hid - the device
> > > + *
> > > + * Should only be called after hid_device_io_start. It will prev=
ent
> > > + * incoming packets from going to the driver for the duration of
> > > + * probe, remove. If called during probe, packets will still go =
to the
> > > + * driver after probe is complete.
> > > + */
> > > +static inline void hid_device_io_stop(struct hid_device *hid) {
> > > +  hid->io_started =3D false;
> > > +  down(&hid->driver_input_lock);
> >
> > Same.
>
> Same as _start() here
>
> > > +}
> > > +
> > > +/**
> > >   * hid_map_usage - map usage input bits
> > >   *
> > >   * @hidinput: hidinput which we are interested in
> > > --
> > > 1.8.1
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
