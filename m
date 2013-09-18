From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 18 Sep 2013 11:54:07 +0500
Message-ID: <20130918065406.GA13451@gmail.com>
References: <1379393047-11772-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379393047-11772-3-git-send-email-zubair.lutfullah@gmail.com>
 <20130918042726.GB13196@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130918042726.GB13196-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Sep 17, 2013 at 09:27:27PM -0700, Dmitry Torokhov wrote:
> Hi Zubair,
> 
> On Tue, Sep 17, 2013 at 09:44:07AM +0500, Zubair Lutfullah wrote:
> > +
> > +	ret = devm_request_threaded_irq(indio_dev->dev.parent,
> > +				irq,
> > +				pollfunc_th, pollfunc_bh,
> > +				flags, indio_dev->name,
> > +				indio_dev);
> > +	if (ret)
> > +		goto error_kfifo_free;
> > +
> > +	indio_dev->setup_ops = setup_ops;
> > +	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> > +
> > +	ret = iio_buffer_register(indio_dev,
> > +				  indio_dev->channels,
> > +				  indio_dev->num_channels);
> > +	if (ret)
> > +		goto error_free_irq;
> > +
> > +	return 0;
> > +
> > +error_free_irq:
> > +	devm_free_irq(indio_dev->dev.parent, irq, indio_dev);
> 
> What is the point of using devm_* here if you are doing explicit
> management of the resource anyway (you explicitly release it in all code
> paths)?
> 
> Thanks.
> 
> -- 
> Dmitry

I admit I am unaware at the moment about how it works.

I use devm and simply ignore the error path?

The devm function header description said something about using
devm_free when freeing. And this is the way I am used to seeing 
error handling.

Zubair
