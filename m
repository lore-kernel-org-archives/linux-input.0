From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v5] staging: ste_rmi4: Convert to Type-B support
Date: Mon, 12 Nov 2012 18:20:56 +0100
Message-ID: <20121112172056.GA1400@polaris.bitmath.org>
References: <20121103013623.0f3a1b28168a9a42881b0b00@tw.synaptics.com>
 <20121108150529.b16707c1c84e6fd862e58b6a@tw.synaptics.com>
 <20121109192604.GA16972@polaris.bitmath.org>
 <CC51EC7B5B7F984AA566DC102237848896F622A3@hkdcw-mail1.synaptics-inc.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:34764 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795Ab2KLROn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 12:14:43 -0500
Content-Disposition: inline
In-Reply-To: <CC51EC7B5B7F984AA566DC102237848896F622A3@hkdcw-mail1.synaptics-inc.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexandra Chin <alexandra.chin@tw.synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Mahesh Srinivasan <msrinivasan@synaptics.com>, Alex Chang <alex.chang@tw.synaptics.com>, Scott Lin <scott.lin@tw.synaptics.com>, Christopher Heiny <Cheiny@synaptics.com>

On Mon, Nov 12, 2012 at 04:40:34PM +0000, Alexandra Chin wrote:
> Hi Henrik,
> 
> >> Convert to MT-B because Synaptics touch devices are capable
> >> of tracking identifiable fingers.
> >>
> >> Signed-off-by: Alexandra Chin <alexandra.chin@tw.synaptics.com>
> >> ---
> >> Changes from v5:
> >>         - Incorporated Henrik's review comments
> >>           *rollback to v3 from v4
> >>           *fix odd line break in v3
> >>         - Include Alexandra in the list of authors
> >
> > I am seeing _new_ irrelevant changes in this version... There is no
> > need to revert to v3. Just remove the synaptics_rmi4_query_function()
> > changes and other uneeded cruft from the v4 patch. No new changes,
> > please, and make sure the final patch is tested.
> 
> Those changes are intended to fix line over 80 characters in v3.
> The code has been optimized and the logic does not change.

I would still prefer if the trivial non-functional changes were
deferred to later patches. I realize that the change from 'TOUCHPAD'
to 'TOUCHSCREEN' created some problems, but those changes were not
called for in the first place. How about leaving those lines be for
now, and then change to something more generic in a later patch? The
code will obviously work equally well for both touchpad and
touchscreen settings, so the defines could be better named anyways.

> Patch v5 has been verified with pandaboard.

Thank you.

Henrik
