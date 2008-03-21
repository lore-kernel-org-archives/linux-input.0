From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for oops in a grabbed evdev after disconnect
Date: Fri, 21 Mar 2008 10:51:24 -0700
Message-ID: <20080321105124.9fa577f8.zaitcev@redhat.com>
References: <20080317234807.42c72a76.zaitcev@redhat.com>
	<20080318092733.ZZRA012@mailhub.coreip.homeip.net>
	<20080318110342.ad2bb3ea.zaitcev@redhat.com>
	<20080318144432.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688AbYCURzy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2008 13:55:54 -0400
In-Reply-To: <20080318144432.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dwmw2@redhat.com, greg@kroah.com

On Tue, 18 Mar 2008 14:54:17 -0400, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

I'm sorry, but I'm weak. I'll have to poke Greg (to cc:), although
I know he's pretty busy, but I don't grok sysfs and kobjects. So:

> > > > If a device was grabbed through evdev and then became disconnected,
> > > > we oops on close. This happens because input_release_device uses memory
> > > > which was freed.
> > 
> > > Could you tell me what memory is freed?
> > 
> > The input_dev is freed. [...]

> > > [] As far as I understand the
> > > the input_dev structure shold be pinned in memory by the driver
> > > core since we have this link:
> > > 
> > > 	evdev->dev.parent = &input_dev->dev;
> > > 
> > > This should guarantee that input_device is not gone until we
> > > call evdev_free which should be done way after the ungrab.
> > 
> > I don't think anyone checks this, unless the accompaining refcount
> > is set.

> I dont oppose your patch, I am just trying to understand why it
> is needed because driver core should pin the parent device as
> far as I understand and if this does not happen there are other
> issues in input core that need to be taken care of.
> 
> From what I see we should be automatically taking the reference
> to parent kobject in
> 
> kobject_add_internal():
> 	parent = kobject_get(kobj->parent);
> 
> perent is set in kobject_add_varg():
> 	kobj->parent = parent;
> 
> .. which is called from kobject_add() which is called from
> device_add().

Hmm, I see it now. OK.

> Hmm, I wonder if obsolete sysfs links mess up proper parenting
> data... I dont think I have obsolete links set up on any of my
> boxes, can you see if oops goes away if you disable deprectated
> sysfs? If so then instead of checking exist flag we need explicitely
> take reference to the parent input_dev. []

I'll check this.

-- Pete
