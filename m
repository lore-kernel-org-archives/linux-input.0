From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for oops in a grabbed evdev after disconnect
Date: Tue, 8 Apr 2008 10:41:53 -0700
Message-ID: <20080408104153.33c74b97.zaitcev@redhat.com>
References: <20080317234807.42c72a76.zaitcev@redhat.com>
	<20080318092733.ZZRA012@mailhub.coreip.homeip.net>
	<20080318110342.ad2bb3ea.zaitcev@redhat.com>
	<20080318144432.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56600 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbYDHRqs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Apr 2008 13:46:48 -0400
In-Reply-To: <20080318144432.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dwmw2@redhat.com

On Tue, 18 Mar 2008 14:54:17 -0400, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> > > [] As far as I understand the
> > > the input_dev structure shold be pinned in memory by the driver
> > > core since we have this link:
> > > 
> > > 	evdev->dev.parent = &input_dev->dev;

> > I don't think anyone checks this, unless the accompaining refcount
> > is set.

> From what I see we should be automatically taking the reference
> to parent kobject in
> 
> kobject_add_internal():
> 	parent = kobject_get(kobj->parent);
> 
> perent is set in kobject_add_varg():
> 	kobj->parent = parent;

I see you fixed this in a7097ff89c3204737a07eecbc83f9ae6002cc534.
Adam Jackson reports on the X11 side that it worked.

-- Pete
