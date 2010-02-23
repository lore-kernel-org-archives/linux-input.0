From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Tue, 23 Feb 2010 10:40:07 +0200
Message-ID: <1266914407.4787.3308.camel@tema>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
	 <20100222064004.GB2095@core.coreip.homeip.net>
	 <1266844776.4787.3236.camel@tema>
	 <20100222183809.GA5233@core.coreip.homeip.net>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:30319 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0BWIkU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 03:40:20 -0500
In-Reply-To: <20100222183809.GA5233@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 2010-02-22 at 19:38 +0100, ext Dmitry Torokhov wrote:
> On Mon, Feb 22, 2010 at 03:19:36PM +0200, Jari Vanhala wrote:
> > On Mon, 2010-02-22 at 07:40 +0100, ext Dmitry Torokhov wrote:
> > > > +struct vibra_info {
> > > > +	struct device		*dev;
> > > > +	struct input_dev	*input_dev;
> > > > +
> > > > +	struct workqueue_struct *workqueue;
> > > 
> > > Why do we need a separate workqueue? Can't keventd serve us?
> > 
> > There were problems with too long delays once in a while, own workqueue
> > made things much better. Also, you can change priority if needed.
> > 
> 
> OK, in this case you shoudl consider starting it only when input device
> is opened and shutting it down when it is closed.

Hum.. Delayed workqueue creating/destroying makes driver much more
complex. I create separate patch for it.

> > > > +static int vibra_play(struct input_dev *dev, void *data,
> > > > +		      struct ff_effect *effect)
> > > > +{
> > > > +	struct vibra_info *info = data;
> > > > +
> > > > +	if (!info->workqueue)
> > > > +		return 0;
> > > 
> > > How can workqueue be missig here?
> > 
> > It's missing when we remove driver. ff-memless wants to stop vibra (if
> > it was running) and destroys info. And also we really don't want to
> > start worker anymore.
> 
> I would expect the code to make sure workqueue is present while there
> are any outstanding playback requests. Otherwise you need more locking
> (what stops workqueue from being deleted right after you checked it?)

I think locking is kind of overkill. Vibra_play is run in atomic-context
and.. but I can add spinlock to protect work.

	++Jam


