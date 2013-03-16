From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC/RFT] Reset bcm5974 into wellspring mode when it forgets
Date: Sat, 16 Mar 2013 20:31:43 +0100
Message-ID: <20130316193143.GA6050@polaris.bitmath.org>
References: <1363271407.4853.52.camel@i7.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:48062 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab3CPT1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Mar 2013 15:27:35 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 4BFB0EA9C0
	for <linux-input@vger.kernel.org>; Sat, 16 Mar 2013 20:27:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1363271407.4853.52.camel@i7.infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-input@vger.kernel.org

Hi David,

> Occasionally the trackpad in my MacBookPro 8,3 stops working, spewing
>  'bcm5974: bad trackpad package, length: 8'

We have seen this on a few exemplars over the years. It could be a
hardware problem.

> I haven't been able to reproduce this on demand, but it's annoying when
> it does happen. I'm *assuming* that it's somehow forgotten what mode
> it's supposed to be in. The fix for this on suspend/resume was to switch
> it back to Wellspring mode again, so let's try that...

What do you mean by "fix for this on suspend/resume"? The driver
always returns to normal mode at suspend, and sets wellspring mode at
resume.

> Untested, because my trackpad seems to *know* when I'm actually running
> a kernel with this patch, and doesn't ever misbehave. I've played with
> removing the *normal* mode switch in bcm5974_start_traffic() but can't
> get it to produce the 'bad trackpad package' message at all in that
> case, so the rest function doesn't get invoked.

Being random, it really sounds like faulty hardware. As such, perhaps
the problem can be detected in the usb layer?

> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>
> 
> diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
> index 2baff1b..db0b3ab 100644
> --- a/drivers/input/mouse/bcm5974.c
> +++ b/drivers/input/mouse/bcm5974.c
> @@ -244,6 +244,7 @@ struct bcm5974 {
>  	struct bt_data *bt_data;	/* button transferred data */
>  	struct urb *tp_urb;		/* trackpad usb request block */
>  	u8 *tp_data;			/* trackpad transferred data */
> +	struct work_struct reset_work;	/* reset to wellspring mode */
>  	const struct tp_finger *index[MAX_FINGERS];	/* finger index data */
>  	struct input_mt_pos pos[MAX_FINGERS];		/* position array */
>  	int slots[MAX_FINGERS];				/* slot assignments */
> @@ -676,9 +677,14 @@ static void bcm5974_irq_trackpad(struct urb *urb)
>  	if (dev->tp_urb->actual_length == 2)
>  		goto exit;
>  
> -	if (report_tp_state(dev, dev->tp_urb->actual_length))
> +	if (report_tp_state(dev, dev->tp_urb->actual_length)) {
>  		dprintk(1, "bcm5974: bad trackpad package, length: %d\n",
>  			dev->tp_urb->actual_length);
> +		if (dev->tp_urb->actual_length == 8) {
> +			/* Hm. Make sure it's in wellspring mode... */
> +			schedule_work(&dev->reset_work);
> +		}
> +	}
>  
>  exit:
>  	error = usb_submit_urb(dev->tp_urb, GFP_ATOMIC);
> @@ -815,6 +821,14 @@ static int bcm5974_resume(struct usb_interface *iface)
>  	return error;
>  }
>  
> +static void bcm5974_mode_workfn(struct work_struct *work)
> +{
> +	struct bcm5974 *dev = container_of(work, struct bcm5974, reset_work);
> +
> +	dev_info(&dev->intf->dev, "Reset into wellspring mode...\n");
> +	bcm5974_wellspring_mode(dev, true);
> +}
> +

This looks racy.

>  static int bcm5974_probe(struct usb_interface *iface,
>  			 const struct usb_device_id *id)
>  {
> @@ -840,6 +854,7 @@ static int bcm5974_probe(struct usb_interface *iface,
>  	dev->input = input_dev;
>  	dev->cfg = *cfg;
>  	mutex_init(&dev->pm_mutex);
> +	INIT_WORK(&dev->reset_work, bcm5974_mode_workfn);
>  
>  	/* setup urbs */
>  	if (cfg->tp_type == TYPE1) {
> @@ -936,6 +951,7 @@ static void bcm5974_disconnect(struct usb_interface *iface)
>  				  dev->bt_data, dev->bt_urb->transfer_dma);
>  	usb_free_urb(dev->tp_urb);
>  	usb_free_urb(dev->bt_urb);
> +	cancel_work_sync(&dev->reset_work);
>  	kfree(dev);
>  }
>  

In general, It does not really make sense for the transaction mode to
change under our feet without anything in the usb layer knowing about
it. Maybe there is a reset state cycle which does not get handle
properly in the driver?

Thanks,
Henrik

