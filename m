From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/2] input: add ADC resistor ladder driver
Date: Fri, 29 Jul 2016 00:49:21 +0200
Message-ID: <20160728224921.GF1494@piout.net>
References: <1468352186-14190-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468352186-14190-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160713004150.GB24789@dtor-ws>
 <20160728220918.GA25461@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160728220918.GA25461@dtor-ws>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 28/07/2016 at 15:09:18 -0700, Dmitry Torokhov wrote :
> On Tue, Jul 12, 2016 at 05:41:50PM -0700, Dmitry Torokhov wrote:
> > Hi Alexandre,
> > 
> > On Tue, Jul 12, 2016 at 09:36:26PM +0200, Alexandre Belloni wrote:
> > > A common way of multiplexing buttons on a single input in cheap devices is
> > > to use a resistor ladder on an ADC. This driver supports that configuration
> > > by polling an ADC channel provided by IIO.
> > 
> > This looks quite reasonable, just a few small comments.
> 
> Ping.
> 
> Did the version below work for you? I am trying sweep in the brand new
> drivers before we close merge window.
> 

I was thinking it was too late for 4.8. I've juste tested and it works
fine. However, I just sent v5 including the exact same changes but
changing mvolt to millivolt as that seemed preferred by Rob. Both
versions haver been tested and are fine for me.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
