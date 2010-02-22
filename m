From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: TWL4030: add HID Force Feedback vibra
Date: Mon, 22 Feb 2010 10:38:09 -0800
Message-ID: <20100222183809.GA5233@core.coreip.homeip.net>
References: <1266409336-24146-1-git-send-email-ext-jari.vanhala@nokia.com>
 <20100222064004.GB2095@core.coreip.homeip.net>
 <1266844776.4787.3236.camel@tema>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:62167 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab0BVSiU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Feb 2010 13:38:20 -0500
Received: by fxm19 with SMTP id 19so2823881fxm.21
        for <linux-input@vger.kernel.org>; Mon, 22 Feb 2010 10:38:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266844776.4787.3236.camel@tema>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jari Vanhala <ext-jari.vanhala@nokia.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Feb 22, 2010 at 03:19:36PM +0200, Jari Vanhala wrote:
> On Mon, 2010-02-22 at 07:40 +0100, ext Dmitry Torokhov wrote:
> > > +config HID_TWL4030_VIBRA
> > > +	tristate "HID Support for TWL4030 Vibrator"
> > > +	depends on TWL4030_CORE
> > > +	select TWL4030_CODEC
> > > +	select INPUT_FF_MEMLESS
> > > +	---help---
> > > +	  This option enables support for TWL4030 Vibrator Driver.
> > > +
> > 
> > To compile this driver as a module...
> 
> Um. You mean help-text.. Added.
> 
> > > +struct vibra_info {
> > > +	struct device		*dev;
> > > +	struct input_dev	*input_dev;
> > > +
> > > +	struct workqueue_struct *workqueue;
> > 
> > Why do we need a separate workqueue? Can't keventd serve us?
> 
> There were problems with too long delays once in a while, own workqueue
> made things much better. Also, you can change priority if needed.
> 

OK, in this case you shoudl consider starting it only when input device
is opened and shutting it down when it is closed.

> > > +	struct work_struct	play_work;
> > > +
> > > +	int			enabled;
> > 
> > Use bool?
> 
> Ok.
> 
> > > +	int			speed;
> > > +	int			direction;
> > > +
> > > +	int			coexist;
> > 
> > Here as well?
> 
> Ok.
> 
> > > +static int vibra_play(struct input_dev *dev, void *data,
> > > +		      struct ff_effect *effect)
> > > +{
> > > +	struct vibra_info *info = data;
> > > +
> > > +	if (!info->workqueue)
> > > +		return 0;
> > 
> > How can workqueue be missig here?
> 
> It's missing when we remove driver. ff-memless wants to stop vibra (if
> it was running) and destroys info. And also we really don't want to
> start worker anymore.

I would expect the code to make sure workqueue is present while there
are any outstanding playback requests. Otherwise you need more locking
(what stops workqueue from being deleted right after you checked it?)

> 
> > > +static int twl4030_vibra_resume(struct platform_device *pdev)
> > > +{
> > > +	vibra_disable_leds();
> > > +	return 0;
> > > +}
> > Please convert ot dev_pm_ops.
> 
> Hum, pm...
> 
> > > +	info->input_dev = input_allocate_device();
> > > +	if (info->input_dev == NULL) {
> > > +		dev_err(&pdev->dev, "couldn't allocate input device\n");
> > > +		kfree(info);
> > 
> > Leaking workqueue.
> 
> Oops.
> 
> > > +		return -ENOMEM;
> > > +	}
> > > +	input_set_drvdata(info->input_dev, info);
> > > +
> > > +	info->input_dev->name = "twl4030:vibrator";
> > > +	info->input_dev->id.version = 1;
> > > +	info->input_dev->dev.parent = pdev->dev.parent;
> > > +	set_bit(FF_RUMBLE, info->input_dev->ffbit);
> > > +
> > > +	ret = input_register_device(info->input_dev);
> > > +	if (ret < 0) {
> > > +		dev_dbg(&pdev->dev, "couldn't register input device\n");
> > 
> > Here as well... Can we switch to standard "goto into error path" error
> > handling?
> 
> Too bad that freeing input is different at different stages, but I moved
> simple cleanup to error path. I will send corrected version after I test
> changes.
> 

It is quite easy to handle - either register input device last or, after
calling unput_unregister_device() set the variable to NULL - subsequent
input_free_device() will happily accept it.

-- 
Dmitry
