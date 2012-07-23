From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v9] Touchscreen driver for FT5x06 based EDT displays
Date: Mon, 23 Jul 2012 19:45:25 +0200
Message-ID: <20120723174525.GA13023@polaris.bitmath.org>
References: <1341763522-14374-1-git-send-email-simon.budig@kernelconcepts.de>
 <1342969339-18619-1-git-send-email-simon.budig@kernelconcepts.de>
 <20120723165400.GC26577@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:48265 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158Ab2GWRn4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Jul 2012 13:43:56 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 95B7DC9F2
	for <linux-input@vger.kernel.org>; Mon, 23 Jul 2012 19:43:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120723165400.GC26577@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: simon.budig@kernelconcepts.de, linux-input@vger.kernel.org, olivier@sobrie.be, agust@denx.de, yanok@emcraft.com

Hi Dmitry,

On Mon, Jul 23, 2012 at 09:54:00AM -0700, Dmitry Torokhov wrote:
> On Sun, Jul 22, 2012 at 05:02:19PM +0200, simon.budig@kernelconcepts.de wrote:
> > From: Simon Budig <simon.budig@kernelconcepts.de>
> > 
> > This is a driver for the EDT "Polytouch" family of touch controllers
> > based on the FocalTech FT5x06 line of chips.
> > 
> > Signed-off-by: Simon Budig <simon.budig@kernelconcepts.de>
> > ---
> > 
> > This is a new iteration of the driver for the edt ft5x06 based
> > polytouch series of touchscreens.
> > 
> > This incorporates the changes from Dmitry (Thanks!) as well as the
> > remaining suggestions from Henrik: The default parameter stuff has
> > been factored out to a macro and the accessors for the touch data
> > has been made a bit less confusing...  :)
> > 
> > I have tested it on real hardware (with a slighty older kernel) and
> > everything seems to work properly.
> > 
> > There is a lot of stuff from Dmitry in here, so his Signed-off-by line
> > probably is required as well.
> > 
> > Thanks for helping to improving this driver.
> > 
> 
> Henrik,
> 
> Are you OK with the driver in the current form? I think it is in good
> shape and should be applied; any additional improvements could go on top
> a separate patches.

It looks all good to me,

    Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thanks, Simon, for all your work.

Henrik
