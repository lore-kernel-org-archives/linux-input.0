From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [-next, 1/2] Input: synaptics-rmi4 - add support for F55 sensor
 tuning
Date: Fri, 21 Oct 2016 15:03:24 -0700
Message-ID: <20161021220324.GA3269@roeck-us.net>
References: <1475292168-20961-1-git-send-email-linux@roeck-us.net>
 <20161017213008.GA20263@roeck-us.net>
 <20161020225107.GA13204@lava.h.shmanahar.org>
 <1477006119.5714.46.camel@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59362 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933808AbcJUWEH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 21 Oct 2016 18:04:07 -0400
Content-Disposition: inline
In-Reply-To: <1477006119.5714.46.camel@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Healy <cphealy@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Oct 20, 2016 at 04:28:39PM -0700, Christopher Heiny wrote:
> On Thu, 2016-10-20 at 23:51 +0100, Nick Dyer wrote:
> > On Mon, Oct 17, 2016 at 02:30:08PM -0700, Guenter Roeck wrote:
> > > 
> > > On Fri, Sep 30, 2016 at 08:22:47PM -0700, Guenter Roeck wrote:
> > > > 
> > > > Sensor tuning support is needed to determine the number of
> > > > enabled
> > > > tx and rx electrodes for use in F54 functions.
> > > > 
> > > > The number of enabled electrodes is not identical to the total
> > > > number
> > > > of electrodes as reported with F55:Query0 and F55:Query1. It has
> > > > to be
> > > > calculated by analyzing F55:Ctrl1 (sensor receiver assignment)
> > > > and
> > > > F55:Ctrl2 (sensor transmitter assignment).
> > > > 
> > > > Support for additional sensor tuning functions may be added
> > > > later.
> > > > 
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > Ping ... any comments on this patch and on
> > > https://patchwork.kernel.org/patch/9359061/ ?
> > > 
> > > Both patches now apply to mainline.
> > > 
> > > Thanks,
> > > Guenter
> > 
> > Hi Guenter-
> > 
> > I've reviewed and tested (on S7300 and S7813) both these patches now
> > - you can add my sign-off.
> > 
> > However, on the S7813 firmware, F55 is on PDT page 3, and nothing
> > on page 2, so the default behaviour of the mainline driver means it
> > is
> > not initialised.
> > 
> > So I think we need to revert this change in mainline:
> > https://patchwork.kernel.org/patch/3796971/
> > 
> > See below the PDT scan with it reverted and some debug added.
> > 
> > Christopher/Andrew: is there a better heuristic than scanning all 255
> > pages, given that some firmwares contain gaps?
> 
> It's difficult to say.  It is against the RMI4 spec for there to be
> gaps in the pages - you're supposed to be able to scan until you hit a
> page with an empty PDT, and then stop.
> 
> Since F55 is hardcoded to page 3 for this firmware, it may be a
> customer specific deviation.  This may have been done to accommodate a
> customer-written driver that did not scan the PDT, but instead always
> looked for F55 on page 3.  This idea is supported by the existence of
> the F51 custom function on page 4, since F51 almost always requires
> customer driver code to handle it.
> 
> In my opinion, the Non-standard bit should have been set in the PDT to
> indicate that special handling was required, but that wasn't done in
> this case.
> 
> Anyway, given that this sort of thing has escaped into the wild, I'm
> unsure what to advise.  Just off the top of my head, one possibility is
> to have a "keep-going" option to scan the first 128 pages (0x00 through
> 0x7F), regardless of whether an empty page is encountered.  This could
> be triggered either by a product ID on the "known goofy list", or by a
> boot/load time flag.  I'm sure there are other possibilities, though.
> 

Maybe introduce quirks if the problematic device and/or problematic firmware
version can be identified ? Not sure if scanning 128 pages would be necessary,
though - requiring two empty pages to stop scanning might be sufficient.

Guenter
