From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/7] Input: fix NULL-derefs at probe
Date: Sat, 18 Mar 2017 10:13:31 +0100
Message-ID: <20170318091331.GG20622@localhost>
References: <20170313123539.28103-1-johan@kernel.org>
 <1489418118.30110.26.camel@suse.com>
 <20170313154552.GT4211@localhost>
 <20170316223728.GC2935@dtor-ws>
 <20170317105337.GD20622@localhost>
 <20170317210315.GC26166@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170317210315.GC26166@dtor-ws>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 17, 2017 at 02:03:15PM -0700, Dmitry Torokhov wrote:
> On Fri, Mar 17, 2017 at 11:53:37AM +0100, Johan Hovold wrote:
> > On Thu, Mar 16, 2017 at 03:37:28PM -0700, Dmitry Torokhov wrote:
> > > On Mon, Mar 13, 2017 at 04:45:52PM +0100, Johan Hovold wrote:
> > > > On Mon, Mar 13, 2017 at 04:15:18PM +0100, Oliver Neukum wrote:
> > > > > Am Montag, den 13.03.2017, 13:35 +0100 schrieb Johan Hovold:
> > > > > > This series fixes a number of NULL-pointer dereferences due to
> > > > > > missing endpoint sanity checks that can be triggered by a
> > > > > > malicious USB device.
> > 
> > > Applied the lot.
> > 
> > I noticed you dropped the Fixes tag from the patches that fix bugs which
> > predate git. While this is probably not much of an issue in this case, I
> > think it's generally a bad idea since we're loosing information this
> > way, and this specifically makes it harder for the stable maintainers to
> > figure out which tree to backport a fix to.
> 
> As far as I know the rule is: if no special markings then stable patch
> should be applied as far as it can go.

That's true for the stable tag itself, yes.

> There is no reason to say specify 2.6.12 commit, as in fact the
> offending change is likely to be even earlier, so the annotation would
> be effectively wrong.

It is still the first git commit which has the bug, and everyone
(dealing with code forensics) knows that 1da177e4c3f4
("Linux-2.6.12-rc2") is special.

Adding a Fixes-tag pointing to that initial commit, makes it clear that
bug has indeed been tracked as far back as reasonable. Omission of a
Fixes-tag could on the other hand be due to the submitter not bothering
to track the offending commit, thereby leaving it up to a stable
maintainer to do so (if only just be sure).

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
