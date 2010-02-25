From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: Re: [PATCH v2 2/2] Input: TWL4030-vibra: use dynamic workqueue
Date: Thu, 25 Feb 2010 10:25:26 +0200
Message-ID: <1267086326.4787.5672.camel@tema>
References: <1266935279-331-1-git-send-email-ext-jari.vanhala@nokia.com>
	 <1266935279-331-2-git-send-email-ext-jari.vanhala@nokia.com>
	 <20100223182845.GC11301@core.coreip.homeip.net>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53804 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741Ab0BYIZe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Feb 2010 03:25:34 -0500
In-Reply-To: <20100223182845.GC11301@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2010-02-23 at 19:28 +0100, ext Dmitry Torokhov wrote:
> On Tue, Feb 23, 2010 at 04:27:59PM +0200, Jari Vanhala wrote:
> > +static void twl4030_vibra_wq_destroy(struct vibra_info *info)
> > +{
> > +	struct workqueue_struct *wq;
> > +
> > +	spin_lock(&info->lock);
> > +	wq = info->workqueue;
> > +	info->workqueue = NULL;
> > +	spin_unlock(&info->lock);
> 
> No need for this locking, input core provides needed serialiization.

Looks like so. Ok.
> > +
> > +	if (wq) {
> > +		cancel_work_sync(&info->play_work);
> > +		INIT_WORK(&info->play_work, vibra_play_work); /* cleanup */
> > +		destroy_workqueue(wq);
> > +	}
> > +
> > +	if (info->enabled)
> > +		vibra_disable(info);
> > +}
> > +
> > +static void twl4030_vibra_close(struct input_dev *input)
> > +{
> > +	struct vibra_info *info = input_get_drvdata(input);
> > +
> > +	if (!(--info->users))
> > +		twl4030_vibra_wq_destroy(info);
> 
> Your workqueue is per-device (and there is only one vibrator) so no need
> to track users - input core will not call you more ofte than needed for
> single device.

So close isn't directly connected userspace close-calls, more like
input-subsystem closing device.. That makes life easier.

> > +}
> > +
> >  /*** Module ***/
> >  #if CONFIG_PM
> >  static int twl4030_vibra_suspend(struct device *dev)
> > @@ -197,12 +241,8 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, info);
> >  
> > -	info->workqueue = create_singlethread_workqueue("vibra");
> > -	if (info->workqueue == NULL) {
> > -		dev_err(&pdev->dev, "couldn't create workqueue\n");
> > -		ret = -ENOMEM;
> > -		goto err_kzalloc;
> > -	}
> > +	info->workqueue = NULL;
> > +	info->users = 0;
> >  	INIT_WORK(&info->play_work, vibra_play_work);
> >  	spin_lock_init(&info->lock);
> >  
> > @@ -210,13 +250,15 @@ static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
> >  	if (info->input_dev == NULL) {
> >  		dev_err(&pdev->dev, "couldn't allocate input device\n");
> >  		ret = -ENOMEM;
> > -		goto err_workq;
> > +		goto err_kzalloc;
> >  	}
> >  	input_set_drvdata(info->input_dev, info);
> >  
> >  	info->input_dev->name = "twl4030:vibrator";
> >  	info->input_dev->id.version = 1;
> >  	info->input_dev->dev.parent = pdev->dev.parent;
> > +	info->input_dev->open = twl4030_vibra_open;
> > +	info->input_dev->close = twl4030_vibra_close;
> >  	set_bit(FF_RUMBLE, info->input_dev->ffbit);
> >  
> >  	ret = input_register_device(info->input_dev);
> > @@ -239,8 +281,6 @@ err_ireg:
> >  	info->input_dev = NULL;
> >  err_ialloc:
> >  	input_free_device(info->input_dev);
> > -err_workq:
> > -	destroy_workqueue(info->workqueue);
> >  err_kzalloc:
> >  	kfree(info);
> >  	return ret;
> > @@ -249,17 +289,8 @@ err_kzalloc:
> >  static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
> >  {
> >  	struct vibra_info *info = platform_get_drvdata(pdev);
> > -	struct workqueue_struct *wq;
> > -
> > -	spin_lock(&info->lock);
> > -	wq = info->workqueue;
> > -	info->workqueue = NULL;
> > -	spin_unlock(&info->lock);
> >  
> > -	cancel_work_sync(&info->play_work);
> > -	destroy_workqueue(wq);
> > -	if (info->enabled)
> > -		vibra_disable(info);
> > +	twl4030_vibra_wq_destroy(info);
> 
> If device has not been opened there is no workqueue. If device has been
> opened input core will call close for it. There is no need to try to
> destroy workqueue here.

That input_unregister_device() seems to call it. Ok.

Looks like there was more in this approach than I thought. Maybe it's
better to combine these. I'm a bit busy with other things, so resending
probably takes couple days.

	++Jam


