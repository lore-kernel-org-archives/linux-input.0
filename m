From: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] iio: ti_am335x_adc: Add continuous sampling support
Date: Wed, 18 Sep 2013 16:25:38 +0500
Message-ID: <20130918112536.GA17126@gmail.com>
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
Cc: "Zubair Lutfullah :" <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 18, 2013 at 10:39:42AM +0100, Jonathan Cameron wrote:
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
...
> >> > +
> >> > +error_free_irq:
> >> > +	devm_free_irq(indio_dev->dev.parent, irq, indio_dev);
> >> 
> >> What is the point of using devm_* here if you are doing explicit
> >> management of the resource anyway (you explicitly release it in all
> >> Dmitry
> 
> The devm interfaces ensure this is all cleaned when the device is removed thus avoiding the need to free the stuff explicitly.
> Device will get freed on deliberate remove and on an error from probe. Hence you can drop all calls to devm free. The devm free functions are only needed if you wish to free in order to reallocate. This might happen if you want to change a buffer size for instance.
>

Thank-you for the feedback.
Updated and resent the series.

Zubair
 
> -- 
