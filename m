From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Thu, 14 May 2009 08:09:48 -0700
Message-ID: <20090514150947.GB30027@dtor-d630.eng.vmware.com>
References: <4A0819EE.2050209@samsung.com> <20090512020921.GA1965@dtor-d630.eng.vmware.com> <4A0C1419.5070604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:50451 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbZENPKA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 11:10:00 -0400
Received: by pxi29 with SMTP id 29so614104pxi.33
        for <linux-input@vger.kernel.org>; Thu, 14 May 2009 08:10:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A0C1419.5070604@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com

On Thu, May 14, 2009 at 09:52:41PM +0900, Joonyoung Shim wrote:
> Hi,
> 
> Thank you for your review.
> 
> > Hi,
> > 
> > On Mon, May 11, 2009 at 09:28:30PM +0900, Joonyoung Shim wrote:
> >> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
> >> controller can see at the following website:
> >>
> >> http://www.melfas.com/product/product01.asp?k_r=eng_
> >>
> >> This patch supports only the i2c interface.
> >>
> > 
> > Thank you for the patch. Some comments below.
> > 
> >> +
> >> +/* Touchscreen absolute values */
> >> +static int abs_x[3] = {0, 1024, 0};
> >> +module_param_array(abs_x, int, NULL, 0);
> >> +MODULE_PARM_DESC(abs_x, "Touchscreen absolute X min, max, fuzz");
> >> +
> >> +static int abs_y[3] = {0, 1024, 0};
> >> +module_param_array(abs_y, int, NULL, 0);
> >> +MODULE_PARM_DESC(abs_y, "Touchscreen absolute Y min, max, fuzz");
> >> +
> > 
> > Do we need to have these as module parameters give the fact that we can
> > set them dynamically with EVIOCSABS? I'd =say they should go.
> 
> I think that this part is unnecessary, we can get resolution of
> touchscreen from platform_data or i will use the defined values.
> 

Ok, that would work as well.

> >> +	case INPUT_TYPE_SINGLE:
> >> +		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
> >> +		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
> >> +
> >> +		input_report_key(data->input_dev, BTN_TOUCH, 1);
> >> +		input_report_abs(data->input_dev, ABS_X, x);
> >> +		input_report_abs(data->input_dev, ABS_Y, y);
> >> +		input_report_abs(data->input_dev, ABS_PRESSURE,
> >> +				DEFAULT_PRESSURE);
> > 
> > If the hardware does not support pressure reading don't fake it.
> > BTN_TOUCH should be enough to signal touch.
> 
> MCS-5000 supports pressure reading, but the value of pressure is unstable in
> my target, so i used the static value defined.
> I will add pressure reading after more test.

OK. Alternatively you may indicate in the platform data if pressure
reading is supported and set ABS_PRESSURE bit and report pressure only
when you know it works well.
> 
> signal touch? Do you mean single touch?

I meant "signal" as "convey", "indicate".

> >> +
> >> +	if (request_irq(data->irq, mcs5000_ts_interrupt,
> >> +			IRQF_TRIGGER_LOW, "mcs5000_ts_input", data)) {
> >> +		dev_err(&data->client->dev, "Failed to register interrupt\n");
> >> +		ret = -EINVAL;
> > 
> > Why EINVAL and not EBUSY? Or better yet, why don't you propagate what
> > reqiest_irq returned?
> 
> Hmm, EINVAL is used in wm97xx-core.c file, but you are right.

I am always taking patches ;))

> 
> > 
> >> +{
> >> +	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
> >> +
> >> +	cancel_work_sync(&data->ts_event_work);
> > 
> > There is a race here, IRQ handler may resubmit work after
> > cancel_work_sync() returns. You need to  make sure that
> > IRQ handler does not resubmit work while device is being shut down.
> 
> ok, how about doing free_irq() before cancel_work_sync() call?
> 

Then there is a risk that your work will try to enable_irq() on irq that
was freed. I am not sure if IRQ core will be happy with it,

-- 
Dmitry
