From: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Key for tablet rotation?
Date: Tue, 23 Feb 2010 11:29:50 +0100
Message-ID: <20100223102950.GA7245@suse.cz>
References: <20100216211714.GA5071@srcf.ucam.org> <20100216225449.GA4466@core.coreip.homeip.net> <20100216225602.GB4466@core.coreip.homeip.net> <20100223092025.GF11685@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41981 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab0BWK3w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Feb 2010 05:29:52 -0500
Content-Disposition: inline
In-Reply-To: <20100223092025.GF11685@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-input@vger.kernel.org

On Tue, Feb 23, 2010 at 10:20:25AM +0100, Vojtech Pavlik wrote:
> On Tue, Feb 16, 2010 at 02:56:02PM -0800, Dmitry Torokhov wrote:
> > Now if I only did not forget to CC Vojtech first time around...
> > 
> > On Tue, Feb 16, 2010 at 02:54:49PM -0800, Dmitry Torokhov wrote:
> > > On Tue, Feb 16, 2010 at 09:17:14PM +0000, Matthew Garrett wrote:
> > > > Many tablet PCs have a button to indicate that the screen should be 
> > > > rotated from landscape to portrait mode. There's currently no 
> > > > standardisation here - a couple of drivers seem to be using 
> > > > KEY_DIRECTION, and others are just being mapped to arbitrary F keys. So:
> > > > 
> > > > 1) What is KEY_DIRECTION supposed to be for?
> > > 
> > > Hmm, that is the good question. It looks like it's been introduced with
> > > the first patch for input events that Vojtech brought in 2.3 kernels and
> > > I do not see any users for it in mainline.
> > > 
> > > Vojtech, do you remember by any chance what you intended it to be used
> > > for?
> > > 
> > > > 2) If it's not suitable, do we still have space for a KEY_ROTATE?
> > > > 
> > > 
> > > We still have a few slots available but I'd lean towards KEY_DIRECTION
> > > (with better name maybe).
> 
> This is way too long ago, sorry. I suppose it was a key on one of the
> early extended AT keyboards, not really related to tablet computing.

Indeed, it was the case - it got in together with KEY_CYCLEWINDOWS,
KEY_MSDOS, KEY_WWW, and the (in)famous KEY_COFFEE.

> Now, if it's not used anywhere, it makes good sense to reuse it.

-- 
Vojtech Pavlik
Director SuSE Labs
