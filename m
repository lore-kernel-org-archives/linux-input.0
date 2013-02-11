From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two
 locks.
Date: Mon, 11 Feb 2013 22:05:26 +0100
Message-ID: <20130211220526.6909cc0f@neptune.home>
References: <CAG_cf+eZ2w4i=a_kMieb92Pa0Gf2aOB_2Bs39G=aB7ui-Y08Pw@mail.gmail.com>
	<CANq1E4Q-dWrf4nwn+SZ4TdjBSZ5i6UEGgVxm=eboZ0i6Dk9ZqA@mail.gmail.com>
	<20130211185527.63d1c1f9@neptune.home>
	<CAG_cf+cNqrveHTR+JqYueTafH7Jtv+VDebU4QNicfWY3dhY+7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:38873 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759563Ab3BKVFi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 16:05:38 -0500
In-Reply-To: <CAG_cf+cNqrveHTR+JqYueTafH7Jtv+VDebU4QNicfWY3dhY+7w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Linux Input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Mon, 11 February 2013 Andrew de los Reyes wrote:
> > > > @@ -1734,9 +1742,15 @@ static int hid_device_remove(struct device *dev)
> > > >  {
> > > >         struct hid_device *hdev = container_of(dev, struct hid_device, dev);
> > > >         struct hid_driver *hdrv;
> > > > +       int ret = 0;
> > > >
> > > >         if (down_interruptible(&hdev->driver_lock))
> > > >                 return -EINTR;
> > > > +       if (down_interruptible(&hdev->driver_input_lock)) {
> > > > +               ret = -EINTR;
> > > > +               goto unlock_driver_lock;
> > > > +       }
> > > > +       hdev->io_started = false;
> > >
> > > If we lock driver_input_lock during remove, we might lose important
> > > packages here because the input handler drops them.
> > >
> > > Drivers that require this should deal with it properly, but you might
> > > get annoying timeouts during remove if you do I/O and lose an
> > > important packet here.
> > >
> > > But I think the proper way to fix this is to move I/O handling into
> > > workqueues instead of interrupt-context so we can actually sleep in
> > > handle_input. So I think this is fine.
> >
> > Though the driver would suffer the same timeout if it does not shortcut
> > them when the device is being physically unplugged.
> > So in both cases the driver does need to take explicit action in ->remove()
> > probably even before reenabling I/O in order to "cancel" pending activity
> > prior to doing the removal reconfiguration on logical unplug.
> 
> The kernel already blocks input during remove(); this patch doesn't
> change that behavior. We could have another API that allows drivers to
> opt-out of this behavior, but maybe that should be another patch.

I was mostly replying to David on the timeout part.
But sure it is for another patch.

There are two case here anyhow:
- physical unplug

  Here it will never make sense to restart I/O as there device is gone

- logical unplug

  In this case, maybe driver could tell which variant it prefers, stopping
  I/O itself during remove() or having I/O stopped by HID (with option to
  temporarily restart it as needed)

  In the case driver specifies "don't stop I/O on logical unplug" driver
  needs to be able to check current state of I/O. Either using a
  hid_device_io_can_start() or having hid_device_io_start() having a return
  value of 0 for successful start (even if I/O had never been stopped) and
  return -ENODEV if the device is gone.

Bruno
