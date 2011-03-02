From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] uinput: allow events per packet to be specified
Date: Wed, 2 Mar 2011 16:06:21 +0000
Message-ID: <20110302160621.41ca3da9@lxorguk.ukuu.org.uk>
References: <20110301154722.32433.45006.stgit@bob.linux.org.uk>
	<20110302141305.GA1708@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:58538 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751384Ab1CBQGf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Mar 2011 11:06:35 -0500
In-Reply-To: <20110302141305.GA1708@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: aris@cathedrallabs.org, linux-input@vger.kernel.org

On Wed, 2 Mar 2011 15:13:05 +0100
"Henrik Rydberg" <rydberg@euromail.se> wrote:

> Hi Alan,
> 
> > Implement an events per packet interface configuration. We do this by
> > adding a new ioctl that must be called before creation and follows the
> > pattern of the existing API.
> > 
> > The behaviour is:
> > 	Not set:	input default or value computed by the uinput driver
> > 	Set:		value used in preference if larger than computed
> > 			value
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> > ---
> 
> I agree that adding this ioctl is symmetrical from the a device
> emulation standpoint, but I was imagining eventually replacing the eep
> with an automatic scheme, or at least with a more realtime-oriented
> parameter. Fixating the interface as you propose will make such a
> transition much harder.

This is something we actually need rather than are having future
visions about, so imaginings for the future don't really help here
unfortunately. I'd obviously rather have a standard API than get into the
situation where more and more devices and distros simply won't run an
upstream kernel.

If the long term theoretical transition is a concern then we could simply
make the "set" behaviour

Set:	value is used as a hint to the uinput driver and input layer
	that a given amount of buffering may be required. It may be
	ignored by the input layer.

and if the long term imagining ever happens the interface cannot be an
implediment. It won't cause any problems because if the automatic
interfaces work then the hint isn't needed, and if  they never get
implemented or it turns out they never to work for all cases (most
likely I suspect) then you'll still need the hint.

Does that work ?

Alan
