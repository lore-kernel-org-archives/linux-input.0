From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Patch for oops in a grabbed evdev after disconnect
Date: Tue, 18 Mar 2008 14:54:17 -0400
Message-ID: <20080318144432.ZZRA012@mailhub.coreip.homeip.net>
References: <20080317234807.42c72a76.zaitcev@redhat.com> <20080318092733.ZZRA012@mailhub.coreip.homeip.net> <20080318110342.ad2bb3ea.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:15584 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935517AbYCSU50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 16:57:26 -0400
Received: by nf-out-0910.google.com with SMTP id g13so339986nfb.21
        for <linux-input@vger.kernel.org>; Wed, 19 Mar 2008 13:57:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080318110342.ad2bb3ea.zaitcev@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org, dwmw2@redhat.com

On Tue, Mar 18, 2008 at 11:03:42AM -0700, Pete Zaitcev wrote:
> On Tue, 18 Mar 2008 09:31:25 -0400, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Mon, Mar 17, 2008 at 11:48:07PM -0700, Pete Zaitcev wrote:
> 
> > > If a device was grabbed through evdev and then became disconnected,
> > > we oops on close. This happens because input_release_device uses memory
> > > which was freed.
> 
> > Could you tell me what memory is freed?
> 
> The input_dev is freed. We only have two structures involved,
> really: evdev and input_dev. The rest is either immaterial like
> evdev_client, or embedded into the two like input_handle and device.
> 
> It's freed by this route:
>  hidinput_disconnect
>    input_unregister_device
>      evdev_disconnect  --- marks evdev->exists = 0
>      device_unregister
>      put_device -- kobject_put -- kref_put -- kobject_cleanup
>        input_dev_release
> 
> > [] As far as I understand the
> > the input_dev structure shold be pinned in memory by the driver
> > core since we have this link:
> > 
> > 	evdev->dev.parent = &input_dev->dev;
> > 
> > This should guarantee that input_device is not gone until we
> > call evdev_free which should be done way after the ungrab.
> 
> I don't think anyone checks this, unless the accompaining refcount
> is set.
> 
> Honestly, I didn't consider the implications for the integrity
> of sysfs. It seems like there's no extra memory leak with my
> patch, that's the only thing I can promise. Maybe you want to
> poke Greg about it.
> 

I dont oppose your patch, I am just trying to understand why it
is needed because driver core should pin the parent device as
far as I understand and if this does not happen there are other
issues in input core that need to be taken care of.

>From what I see we should be automatically taking the reference
to parent kobject in

kobject_add_internal():
	parent = kobject_get(kobj->parent);

perent is set in kobject_add_varg():
	kobj->parent = parent;

.. which is called from kobject_add() which is called from
device_add().

Hmm, I wonder if obsolete sysfs links mess up proper parenting
data... I dont think I have obsolete links set up on any of my
boxes, can you see if oops goes away if you disable deprectated
sysfs? If so then instead of checking exist flag we need explicitely
take reference to the parent input_dev. Although I wonder what
other subsystems might be affected.

-- 
Dmitry
