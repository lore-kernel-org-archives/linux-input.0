From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH] HID: Separate struct hid_device's driver_lock into two
 locks.
Date: Thu, 14 Feb 2013 08:06:48 +0100
Message-ID: <20130214080648.6f84682e@pluto.restena.lu>
References: <CAG_cf+eZ2w4i=a_kMieb92Pa0Gf2aOB_2Bs39G=aB7ui-Y08Pw@mail.gmail.com>
	<CANq1E4Q-dWrf4nwn+SZ4TdjBSZ5i6UEGgVxm=eboZ0i6Dk9ZqA@mail.gmail.com>
	<20130211185527.63d1c1f9@neptune.home>
	<CAG_cf+cm_q-0KJzZUaBsw=i5zqGp_Q+6Ga8=7mWVMXXidfEVpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:45203 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755773Ab3BNHGw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Feb 2013 02:06:52 -0500
In-Reply-To: <CAG_cf+cm_q-0KJzZUaBsw=i5zqGp_Q+6Ga8=7mWVMXXidfEVpA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, Linux Input <linux-input@vger.kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Wed, 13 Feb 2013 21:08:20 -0800 Andrew de los Reyes wrote:
> > > >  /**
> > > > + * hid_device_io_start - enable HID input during probe, remove
> > > > + *
> > > > + * @hid - the device
> > > > + *
> > > > + * This should only be called during probe or remove. It will allow
> > > > + * incoming packets to be delivered to the driver.
> > > > + */
> > > > +static inline void hid_device_io_start(struct hid_device *hid) {
> > > > +  up(&hid->driver_input_lock);
> > > > +  hid->io_started = true;
> > >
> > > Shouldn't these lines be swapped? Doesn't matter but it looks weird to
> > > me this way.
> > >
> > > But more importantly, we must go sure this is called from the same
> > > thread that probe() is called on. Other use-cases are not supported by
> > > semaphores and might break due to missing barriers. So maybe the
> > > comment could include that?
> >
> > Maybe even check what value hid->io_started has and WARN() [+skip
> > up()/down()]
> > in case hid_device_io_start()/stop() was not called in a balanced way.
> 
> It is a goal to support hid_device_io_start()/stop() not being called
> in a balanced way. This is specifically needed by a change I'm making
> to hid-logitech-dj.c: During probe(), the driver will send out a
> request to the USB dongle to list any attached mice/keyboards. The
> reply packets aren't needed during probe(), so probe will return, but
> the driver wants packets to flow in, and it doesn't mind if they come
> in while probe() is still running or not. In this case, during
> probe(), the driver will call hid_device_io_start() to allow incoming
> packets, but then not call hid_device_io_stop().

With unbalanced I meant calling hid_device_io_start()/stop() twice or
more in a row in _probe() (or _remove()) without corresponding
_stop()/_start() call.
That kind of cases might happen (mostly) with error paths.

Like the following (simplified) example when both if() match:

int driver_probe(...)
{
   ...
   if (...) {
      ...
      hid_device_io_start();
      ...
   }
   ...
   if (...) {
      ...
      hid_device_io_start();
      ...
   }
   ...
}


Bruno
