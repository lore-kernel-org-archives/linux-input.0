From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH] USB: input: powermate: fix oops with malicious USB
 descriptors
Date: Mon, 14 Mar 2016 10:07:10 -0700
Message-ID: <20160314170710.GA619@kroah.com>
References: <1457964773-29512-1-git-send-email-jwboyer@fedoraproject.org>
 <20160314161548.GA2585@kroah.com>
 <CA+5PVA5XPO8sQHi07kDSLR-EfocV7Kpqvu3aa1Qvy9Sq7Of=Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA+5PVA5XPO8sQHi07kDSLR-EfocV7Kpqvu3aa1Qvy9Sq7Of=Dw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 14, 2016 at 12:46:26PM -0400, Josh Boyer wrote:
> On Mon, Mar 14, 2016 at 12:15 PM, Greg Kroah-Hartman
> <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org> wrote:
> > On Mon, Mar 14, 2016 at 10:12:53AM -0400, Josh Boyer wrote:
> >> The powermate driver expects at least one valid USB endpoint in its
> >> probe function.  If given malicious descriptors that specify 0 for
> >> the number of endpoints, it will crash.  Validate the number of
> >> endpoints on the interface before using them.
> >>
> >> The full report for this issue can be found here:
> >> http://seclists.org/bugtraq/2016/Mar/85
> >>
> >> Reported-by: Ralf Spenneberg <ralf-bSzMNvQHHtybz89kn3q7ow@public.gmane.org>
> >> Cc: stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> >> Signed-off-by: Josh Boyer <jwboyer-rxtnV0ftBwyoClj4AeEUq9i2O/JbrIOy@public.gmane.org>
> >> ---
> >>  drivers/input/misc/powermate.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >
> > I'll queue these up after 4.6-rc1 is out as the merge window is closed
> > right now, but we might want to think about a better way to handle this
> > type of thing in the USB core.  A way to keep from having to add checks
> > like this for every single driver, when the driver shouldn't even really
> > have their probe function called unless their expected endpoints are
> > going to be there.
> 
> I thought this discussion came up a while ago, when something very
> similar was fixed in the whiteheat driver (commit cbb4be652d374).  I
> can't find the thread at the moment, but I thought someone said this
> had to be per-driver for some reason.  I'm more than happy to have a
> core subsystem fix if it's possible.
> 
> > I'll think about that over the next few weeks...
> 
> I have something around 8 drivers with issues like this.  I think
> Oliver (now CC'd) is working from the same set of bugs.  Should we
> hold off on submitting individual fixes until later, or should we go
> ahead and submit them?

Please submit them, that will give us a framework to be able to figure
out the specifics of what needs to be changed.

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
