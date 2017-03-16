From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/7] Input: fix NULL-derefs at probe
Date: Thu, 16 Mar 2017 15:37:28 -0700
Message-ID: <20170316223728.GC2935@dtor-ws>
References: <20170313123539.28103-1-johan@kernel.org>
 <1489418118.30110.26.camel@suse.com>
 <20170313154552.GT4211@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170313154552.GT4211@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Oliver Neukum <oneukum@suse.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Mar 13, 2017 at 04:45:52PM +0100, Johan Hovold wrote:
> On Mon, Mar 13, 2017 at 04:15:18PM +0100, Oliver Neukum wrote:
> > Am Montag, den 13.03.2017, 13:35 +0100 schrieb Johan Hovold:
> > > This series fixes a number of NULL-pointer dereferences due to
> > > missing
> > > endpoint sanity checks that can be triggered by a malicious USB
> > > device.
> >
> > At the risk of repeating myself, doesn't the sheer number of fixes
> > demonstrate the need for a more centralized check?
> 
> No, I don't think that follows. These are plain bugs that needs to be
> fixed (cf. not checking for allocation failures or whatever) and
> backported to the stable trees.
> 
> I think I may have surveyed just about every USB driver this last week,
> and there is no single pattern for how endpoints are verified and
> retrieved that could easily be refactored into USB core.
> 
> Now there are certain patterns that could benefit from a few helpers,
> and some obvious bugs could then be caught by declaring those helpers as
> __must_check. But specifically, you'd still be checking the return
> value from the helpers.
> 
> Then verifying the endpoint counts before calling driver probe,
> typically only saves a bit of time while probing *malicious* devices
> (and the occasional odd interface which cannot be matched on other
> attributes).
> 
> That being said, we could still add a centralised sanity check for a
> large class of drivers (e.g. that do not use altsettings and only need
> minimum constraints) but it's not going to obviate the need for careful
> driver implementations.
> 
> I'll be posting some more patches related to this shortly.

There were some discussions about making and that would allow drivers
declare endpoints they want and have USB core ether fill them or not
even try to bind, but nothing concrete.

Anyway, I do not think we should be blocking this patch series on it; if
we come up with something clever we can always switch over.

Applied the lot.

Thanks.

-- 
Dmitry
