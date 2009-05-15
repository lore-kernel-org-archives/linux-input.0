From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: add touchscreen driver for MELFAS MCS-5000 controller
Date: Thu, 14 May 2009 19:52:42 -0700
Message-ID: <200905141952.43442.dmitry.torokhov@gmail.com>
References: <4A0819EE.2050209@samsung.com> <20090514150947.GB30027@dtor-d630.eng.vmware.com> <4A0CBC24.2060605@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:64211 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbZEOCwt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2009 22:52:49 -0400
Received: by pxi29 with SMTP id 29so835458pxi.33
        for <linux-input@vger.kernel.org>; Thu, 14 May 2009 19:52:50 -0700 (PDT)
In-Reply-To: <4A0CBC24.2060605@samsung.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com

On Thursday 14 May 2009 17:49:40 Joonyoung Shim wrote:
> >>>> +	case INPUT_TYPE_SINGLE:
> >>>> +		x = (buffer[READ_X_POS_UPPER] << 8) | buffer[READ_X_POS_LOWER];
> >>>> +		y = (buffer[READ_Y_POS_UPPER] << 8) | buffer[READ_Y_POS_LOWER];
> >>>> +
> >>>> +		input_report_key(data->input_dev, BTN_TOUCH, 1);
> >>>> +		input_report_abs(data->input_dev, ABS_X, x);
> >>>> +		input_report_abs(data->input_dev, ABS_Y, y);
> >>>> +		input_report_abs(data->input_dev, ABS_PRESSURE,
> >>>> +				DEFAULT_PRESSURE);
> >>>
> >>> If the hardware does not support pressure reading don't fake it.
> >>> BTN_TOUCH should be enough to signal touch.
> >>
> >> MCS-5000 supports pressure reading, but the value of pressure is
> >> unstable in my target, so i used the static value defined.
> >> I will add pressure reading after more test.
> >
> > OK. Alternatively you may indicate in the platform data if pressure
> > reading is supported and set ABS_PRESSURE bit and report pressure only
> > when you know it works well.
>
> OK, i will add the thing about pressure in the platform data.
>
> >> signal touch? Do you mean single touch?
> >
> > I meant "signal" as "convey", "indicate".
>
> I see :)
>
> >>>> +
> >>>> +	if (request_irq(data->irq, mcs5000_ts_interrupt,
> >>>> +			IRQF_TRIGGER_LOW, "mcs5000_ts_input", data)) {
> >>>> +		dev_err(&data->client->dev, "Failed to register interrupt\n");
> >>>> +		ret = -EINVAL;
> >>>
> >>> Why EINVAL and not EBUSY? Or better yet, why don't you propagate what
> >>> reqiest_irq returned?
> >>
> >> Hmm, EINVAL is used in wm97xx-core.c file, but you are right.
> >
> > I am always taking patches ;))
>
> OK, i will send the patch about it.
>
> >>>> +{
> >>>> +	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
> >>>> +
> >>>> +	cancel_work_sync(&data->ts_event_work);
> >>>
> >>> There is a race here, IRQ handler may resubmit work after
> >>> cancel_work_sync() returns. You need to  make sure that
> >>> IRQ handler does not resubmit work while device is being shut down.
> >>
> >> ok, how about doing free_irq() before cancel_work_sync() call?
> >
> > Then there is a risk that your work will try to enable_irq() on irq that
> > was freed. I am not sure if IRQ core will be happy with it,
>
> Oh, i didn't think about that, then, how about the following patch?
> The work handler decides trying to enable_irq() by whether irq is NULL or
> not.
>
> @@ -179,7 +179,8 @@ static void mcs5000_ts_irq_worker(struct work_struct
> *work)
>
>  	mcs5000_ts_input_read(data);
>
> -	enable_irq(data->irq);
> +	if (data->irq)
> +		enable_irq(data->irq);
>  }
>
>  static irqreturn_t mcs5000_ts_interrupt(int irq, void *dev_id)
> @@ -307,8 +308,9 @@ static int mcs5000_ts_remove(struct i2c_client *client)
>  {
>  	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
>
> -	cancel_work_sync(&data->ts_event_work);
>  	free_irq(data->irq, data);
> +	data->irq = 0;

Not if you want to enable IRQ 0 every once in a while. I think a separate 
flag, the check in the IRQ handler as opposed to workqueue handler and a 
memory barrier should work though.

> +	cancel_work_sync(&data->ts_event_work);
>  	input_unregister_device(data->input_dev);
>  	input_free_device(data->input_dev);
>  	kfree(data);

-- 
Dmitry
