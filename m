From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
Date: Sun, 15 Jul 2018 09:42:25 +0200
Message-ID: <20180715074225.GB15123@gmail.com>
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com>
 <20180714085109.mbhk6aybpjsbuq6l@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180714085109.mbhk6aybpjsbuq6l@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-input@vger.kernel.org

On Sat, Jul 14, 2018 at 08:51:09AM +0000, Dmitry Torokhov wrote:
> On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
> > Hi Alexey,
> > 
> > Good catch!
> > 
> > On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
> > > pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
> > > anywhere in the driver.
> > > 
> > > The patch adds one to error handling code and to pxrc_disconnect().
> > > 
> > > Found by Linux Driver Verification project (linuxtesting.org).
> > > 
> > > Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > 
> > Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> 
> Hmm, the biggest question however if we need to "take" the device, as I
> do not think interface can outlive the device, and whether we actually
> need to store it in pxrc, as we only need it during set up, as far as I
> can see.

Yep, the device is only used during setup.
I interpret the comments for usb_get_dev() as you should take a
reference count on the device even if you only use the interface, but I
could be wrong.

>From usb_get_dev()::

	 * usb_get_dev - increments the reference count of the usb device structure
	 * @dev: the device being referenced
	 *
	 * Each live reference to a device should be refcounted.
	 *
	 * Drivers for USB interfaces should normally record such references in
	 * their probe() methods, when they bind to an interface, and release
	 * them by calling usb_put_dev(), in their disconnect() methods.

I can fix the driver to not take the device if that is what we want.
If not Alexey want to fix it of course, it is his catch :-)

> 
> Thanks.
> 
> -- 
> Dmitry

Best regards
Marcus Folkesson
