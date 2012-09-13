From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 4/5] IIO : ADC: tiadc: Add support of TI's ADC driver
Date: Thu, 13 Sep 2012 09:58:34 -0700
Message-ID: <20120913165833.GC3519@core.coreip.homeip.net>
References: <1347532819-505-1-git-send-email-rachna@ti.com>
 <1347532819-505-5-git-send-email-rachna@ti.com>
 <5051CDEA.5080200@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5051CDEA.5080200-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 13, 2012 at 01:13:30PM +0100, Jonathan Cameron wrote:
> On 13/09/12 11:40, Patil, Rachna wrote:
> >This patch adds support for TI's ADC driver.
> >This is a multifunctional device.
> >Analog input lines are provided on which
> >voltage measurements can be carried out.
> >You can have upto 8 input lines.
> >
> >Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> 
> There's a little fuzz in applying this due to other drivers that have
> gone in recently.
> 
> Actually this is going to be 'interesting' to merge. Dmitry, Samuel
> thoughts on who takes this one and how?  Maybe this is a case for a
> 'special' branch pulled into more than one tree?

I'd be OK with it going through MFD tree.

-- 
Dmitry
