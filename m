From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add driver for EETI touchpanels
Date: Thu, 7 May 2009 19:29:54 -0700
Message-ID: <20090508022950.GB30616@dtor-d630.eng.vmware.com>
References: <1241002247-23923-1-git-send-email-daniel@caiaq.de> <1241019084-19204-1-git-send-email-daniel@caiaq.de> <20090507173502.GA12946@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:45198 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbZEHCaB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 22:30:01 -0400
Received: by rv-out-0506.google.com with SMTP id f9so900775rvb.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 19:30:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090507173502.GA12946@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

Hi Daniel,

On Thu, May 07, 2009 at 07:35:02PM +0200, Daniel Mack wrote:
> > +
> > +	if (buf[0] & REPORT_BIT_HAS_PRESSURE)
> > +		input_report_abs(priv->input, ABS_PRESSURE, buf[5]);
> > +
> > +	input_report_key(priv->input, BTN_TOUCH, !!pressed);
> > +	input_report_abs(priv->input, ABS_X, x);
> > +	input_report_abs(priv->input, ABS_Y, y);
> > +	input_sync(priv->input);

I think you should also do:

	if (!pressed)
		input_report_abs(priv->input, ABS_PRESSURE, 0);

for the benefit of applications that use purely pressure data to
determine touch points.

> > +	enable_irq(priv->irq);
> > +}
> > +
> > +static irqreturn_t eeti_ts_isr(int irq, void *dev_id)
> > +{
> > +	struct eeti_ts_priv *priv = dev_id;
> > +
> > +	 /* postpone I2C transactions as we are atomic */
> > +	disable_irq_nosync(irq);
> > +	schedule_delayed_work(&priv->work, HZ / 100);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int eeti_ts_open(struct input_dev *dev)
> > +{
> > +	struct eeti_ts_priv *priv = input_get_drvdata(dev);

Blank line after declarations, pretty please. Also, is it mailer's fault
or you need to use tabs for identation.

> > +	/* Read the events once to arm the IRQ */
> > +	eeti_ts_read(&priv->work.work);
> > +
> > +	return 0;
> > +}
> > +

Thanks.

-- 
Dmitry
