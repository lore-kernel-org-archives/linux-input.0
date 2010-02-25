From: Jari Vanhala <ext-jari.vanhala@nokia.com>
Subject: Re: [PATCH v2 1/2] Input: TWL4030: add Force Feedback vibra
Date: Thu, 25 Feb 2010 10:44:32 +0200
Message-ID: <1267087472.4787.5673.camel@tema>
References: <1266935279-331-1-git-send-email-ext-jari.vanhala@nokia.com>
	 <20100223182455.GB11301@core.coreip.homeip.net>
Reply-To: ext-jari.vanhala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55727 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab0BYIpB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Feb 2010 03:45:01 -0500
In-Reply-To: <20100223182455.GB11301@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 2010-02-23 at 19:24 +0100, ext Dmitry Torokhov wrote:
> On Tue, Feb 23, 2010 at 04:27:58PM +0200, Jari Vanhala wrote:
> > +static int vibra_play(struct input_dev *dev, void *data,
> > +                   struct ff_effect *effect)
> > +{
> > +     struct vibra_info *info = data;
> > +
> > +     spin_lock(&info->lock);
> > +     if (!info->workqueue)
> > +             goto out;
> > +
> > +     info->speed = effect->u.rumble.strong_magnitude >> 8;
> > +     if (!info->speed)
> > +             info->speed = effect->u.rumble.weak_magnitude >> 9;
> > +     info->direction = effect->direction < EFFECT_DIR_180_DEG ? 0 : 1;
> > +     queue_work(info->workqueue, &info->play_work);
> 
> What if workqueue was not fast enough and previous queue has not been
> scheduled yet? It looks like we need to cancel and reschedule the work,
> otherwise our scheduling will be off. Or we don't really care?

queue_work() just return 0 if it was already queued. And it's better to
get latest speed than all fast changes, motor isn't that sensitive.

> > +out:
> > +     spin_unlock(&info->lock);
> > +     return 0;
> > +}
> > +
> > +/*** Module ***/
> > +#if CONFIG_PM
> > +static int twl4030_vibra_suspend(struct device *dev)
> > +{
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +     struct vibra_info *info = platform_get_drvdata(pdev);
> > +
> > +     if (info->enabled)
> > +             vibra_disable(info);
> > +
> 
> What will happen if memoryless core will schedule another play effect
> right here? It looks like it will re-enable the device... Need to handle
> this somehow. Or we depending on the workqueue thread being frozen?

We are trusting that nothing is happening from userspace anymore (as
it's frozen) and all other parts in kernel is also going down. Probably
if userspace doing something, suspend itself could be canceled (unless
forced) and we would get back to normal state.

> > +     return 0;
> > +}
> > +
> > +static int twl4030_vibra_resume(struct device *dev)
> > +{
> 
> Why don't we do vibra_enable() here if it was enabled at suspend time?
> Just waiting for the next play do do it for us?

We want to keep vibra's power off when it's not running, so we wait for
next play.

> > +     vibra_disable_leds();
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(twl4030_vibra_pm_ops,
> > +                      twl4030_vibra_suspend, twl4030_vibra_resume);
> > +#endif
> > +
> > +static int __devinit twl4030_vibra_probe(struct platform_device *pdev)
> > +{
> > +     struct twl4030_codec_vibra_data *pdata = pdev->dev.platform_data;
> > +     struct vibra_info *info;
> > +     int ret;
> > +
> > +     if (!pdata) {
> > +             dev_dbg(&pdev->dev, "platform_data not available\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> > +     if (!info)
> > +             return -ENOMEM;
> > +
> > +     info->dev = &pdev->dev;
> > +     info->enabled = false;
> 
> Kzalloc did it for us.

Ok.

> > +     info->coexist = pdata->coexist ? true : false;
> > +
> > +     platform_set_drvdata(pdev, info);
> > +
> > +     info->workqueue = create_singlethread_workqueue("vibra");
> > +     if (info->workqueue == NULL) {
> > +             dev_err(&pdev->dev, "couldn't create workqueue\n");
> > +             ret = -ENOMEM;
> > +             goto err_kzalloc;
> > +     }
> > +     INIT_WORK(&info->play_work, vibra_play_work);
> > +     spin_lock_init(&info->lock);
> > +
> > +     info->input_dev = input_allocate_device();
> > +     if (info->input_dev == NULL) {
> > +             dev_err(&pdev->dev, "couldn't allocate input device\n");
> > +             ret = -ENOMEM;
> > +             goto err_workq;
> > +     }
> > +     input_set_drvdata(info->input_dev, info);
> > +
> > +     info->input_dev->name = "twl4030:vibrator";
> > +     info->input_dev->id.version = 1;
> > +     info->input_dev->dev.parent = pdev->dev.parent;
> > +     set_bit(FF_RUMBLE, info->input_dev->ffbit);
> > +
> > +     ret = input_register_device(info->input_dev);
> > +     if (ret < 0) {
> > +             dev_dbg(&pdev->dev, "couldn't register input device\n");
> > +             goto err_ialloc;
> > +     }
> > +
> > +     ret = input_ff_create_memless(info->input_dev, info, vibra_play);
> > +     if (ret < 0) {
> > +             dev_dbg(&pdev->dev, "couldn't register vibrator to FF\n");
> > +             goto err_ireg;
> > +     }
> 
> This needs to happen before registering input device.

And I thought I checked that call order was right.. Fixing. Keeping info
as data to play is getting too complicated so I drop it and get it via
input-dev (@play).

> > +
> > +     vibra_disable_leds();
> > +
> > +     return 0;
> > +err_ireg:
> > +     input_unregister_device(info->input_dev);
> > +     info->input_dev = NULL;
> > +err_ialloc:
> > +     input_free_device(info->input_dev);
> > +err_workq:
> > +     destroy_workqueue(info->workqueue);
> > +err_kzalloc:
> > +     kfree(info);
> > +     return ret;
> > +}
> > +
> > +static int __devexit twl4030_vibra_remove(struct platform_device *pdev)
> > +{
> > +     struct vibra_info *info = platform_get_drvdata(pdev);
> > +     struct workqueue_struct *wq;
> > +
> > +     spin_lock(&info->lock);
> > +     wq = info->workqueue;
> > +     info->workqueue = NULL;
> > +     spin_unlock(&info->lock);
> 
> If you combine this and the next patch then this locking is not needed.

Hum. Unregister seems to call close.. Great.

> > +
> > +     cancel_work_sync(&info->play_work);
> > +     destroy_workqueue(wq);
> > +     if (info->enabled)
> > +             vibra_disable(info);
> > +     /* this also free ff-memless which (in turn) kfree info */
> > +     input_unregister_device(info->input_dev);
> > +
> 
> It is a good etiquette to do "platform_set_drvdata(pdev, NULL);" to
> avoid leaving dangling pointers behind.

Ok.

	++Jam



