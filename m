From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for oops in a grabbed evdev after disconnect
Date: Tue, 18 Mar 2008 11:03:42 -0700
Message-ID: <20080318110342.ad2bb3ea.zaitcev@redhat.com>
References: <20080317234807.42c72a76.zaitcev@redhat.com>
	<20080318092733.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937284AbYCSV16 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 17:27:58 -0400
In-Reply-To: <20080318092733.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, zaitcev@redhat.com, dwmw2@redhat.com

On Tue, 18 Mar 2008 09:31:25 -0400, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Mon, Mar 17, 2008 at 11:48:07PM -0700, Pete Zaitcev wrote:

> > If a device was grabbed through evdev and then became disconnected,
> > we oops on close. This happens because input_release_device uses memory
> > which was freed.

> Could you tell me what memory is freed?

The input_dev is freed. We only have two structures involved,
really: evdev and input_dev. The rest is either immaterial like
evdev_client, or embedded into the two like input_handle and device.

It's freed by this route:
 hidinput_disconnect
   input_unregister_device
     evdev_disconnect  --- marks evdev->exists = 0
     device_unregister
     put_device -- kobject_put -- kref_put -- kobject_cleanup
       input_dev_release

> [] As far as I understand the
> the input_dev structure shold be pinned in memory by the driver
> core since we have this link:
> 
> 	evdev->dev.parent = &input_dev->dev;
> 
> This should guarantee that input_device is not gone until we
> call evdev_free which should be done way after the ungrab.

I don't think anyone checks this, unless the accompaining refcount
is set.

Honestly, I didn't consider the implications for the integrity
of sysfs. It seems like there's no extra memory leak with my
patch, that's the only thing I can promise. Maybe you want to
poke Greg about it.

It may be easier for you to reproduce it than to parse my arguments,
it's trivial. Use the evdev-x which I attached to the bug, or write
an application which:
 - opens evdev
 - grabs <------- this is important
 - sleeps for 10 seconds
 - exits
Run it, pull the plug while it sleeps. The system will oops.
If you enable lock debugging, it will traceback first like in
the bug, because slab poisoning destroys spinlock magic.

-- Pete
