From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 18 Sep 2013 07:15:33 -0700
Message-ID: <20130918141533.GA16424@core.coreip.homeip.net>
References: <1379393047-11772-1-git-send-email-zubair.lutfullah@gmail.com>
 <1379393047-11772-3-git-send-email-zubair.lutfullah@gmail.com>
 <20130918042726.GB13196@core.coreip.homeip.net>
 <20130918065406.GA13451@gmail.com>
 <53771776-0d33-436d-9687-995ed0d6345d@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53771776-0d33-436d-9687-995ed0d6345d-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 18, 2013 at 10:39:42AM +0100, Jonathan Cameron wrote:
> 
> 
> "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >On Tue, Sep 17, 2013 at 09:27:27PM -0700, Dmitry Torokhov wrote:
> >> Hi Zubair,
> >> 
> >> On Tue, Sep 17, 2013 at 09:44:07AM +0500, Zubair Lutfullah wrote:
> >> > +
> >> > +	ret = devm_request_threaded_irq(indio_dev->dev.parent,
> >> > +				irq,
> >> > +				pollfunc_th, pollfunc_bh,
> >> > +				flags, indio_dev->name,
> >> > +				indio_dev);
> >> > +	if (ret)
> >> > +		goto error_kfifo_free;
> >> > +
> >> > +	indio_dev->setup_ops = setup_ops;
> >> > +	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
> >> > +
> >> > +	ret = iio_buffer_register(indio_dev,
> >> > +				  indio_dev->channels,
> >> > +				  indio_dev->num_channels);
> >> > +	if (ret)
> >> > +		goto error_free_irq;
> >> > +
> >> > +	return 0;
> >> > +
> >> > +error_free_irq:
> >> > +	devm_free_irq(indio_dev->dev.parent, irq, indio_dev);
> >> 
> >> What is the point of using devm_* here if you are doing explicit
> >> management of the resource anyway (you explicitly release it in all
> >code
> >> paths)?
> >> 
> >> Thanks.
> >> 
> >> -- 
> >> Dmitry
> >
> >I admit I am unaware at the moment about how it works.
> >
> >I use devm and simply ignore the error path?
> >
> >The devm function header description said something about using
> >devm_free when freeing. And this is the way I am used to seeing 
> >error handling.
> 

> The devm interfaces ensure this is all cleaned when the device is
> removed thus avoiding the need to free the stuff explicitly.  Device
> will get freed on deliberate remove and on an error from probe. Hence
> you can drop all calls to devm free. The devm free functions are only
> needed if you wish to free in order to reallocate. This might happen
> if you want to change a buffer size for instance.

However in this case such conversion us dangerous. With all but IRQ
resource managed by the traditional methods they will be released first
with IRQ handler deregistered very last. Therefore if device is not
properly quiesced IRQ raised during driver unbinding is likely to result
in kernel oops.

IOW devm_request_irq() is very often evil (it is still useful if _all_
your resources are managed by devm_*).

In case of your driver I'd recommend switching to
request_irq()/free_irq() instead.

Thanks.

-- 
Dmitry
