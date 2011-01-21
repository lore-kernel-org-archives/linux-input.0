From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: EVIOC mechanism for MT slots
Date: Fri, 21 Jan 2011 01:22:01 -0800
Message-ID: <20110121092200.GA24214@core.coreip.homeip.net>
References: <4D38A4B7.7060901@seas.upenn.edu>
 <AANLkTi=mwmpV-db5evGsWe3eyNJER5DOH3V326Jf74us@mail.gmail.com>
 <AANLkTikksBMW0vcmJOGg8=VPWS3FB6HQQL46R7VotyON@mail.gmail.com>
 <AANLkTinDoDm=XqEveR0j9z9bxdPdNtT4JzuXcVrYxAxK@mail.gmail.com>
 <20110121091519.GA13565@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54615 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab1AUJWI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 04:22:08 -0500
Received: by iyj18 with SMTP id 18so1472498iyj.19
        for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 01:22:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110121091519.GA13565@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Chris Bagwell <chris@cnpbagwell.com>, Ping Cheng <pinglinux@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input <linux-input@vger.kernel.org>, Stephane Chatty <chatty@lii-enac.fr>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>

On Fri, Jan 21, 2011 at 10:15:19AM +0100, Henrik Rydberg wrote:
> > This is really problematic when launching applications that rely on
> > evdev to work:
> > you click with the mouse emulation on your icon to launch the program
> > (one finger), and you start using your application with one finger
> > only (opening of a file for instance) -> you are in an unstable case
> > as the app does not know the slot state until you put another finger
> > on the screen.
> > 
> > So I'm in favor of applying this patch Henrik submitted last May.
> 
> Great, so there seems to be sufficient interest to warrant revisiting
> this. If you can find the patches, I will queue them in my tree. ;-)
> 
> And if Dmitry concurs, perhaps we can even aim at 2.6.38.
> 

The reason I objected in the first place is that the patch was a "nice
to have for completeness". Now that there are actual users needing this
data I have no issues with adding ioctl to retrieve this data.

Thanks.

-- 
Dmitry
