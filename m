From: Jens Taprogge <jens.taprogge@taprogge.org>
Subject: Re: Regression: commit e696c68363740d3a8fe495e353de3ff26b86257a
 prevents Linux 3.13 from booting on Lenovo X1 Carbon.
Date: Tue, 21 Jan 2014 01:20:11 +0100
Message-ID: <20140121002011.GB5815@weetamoe.luzern.taprogge.wh>
References: <20140120232652.GA5815@weetamoe.luzern.taprogge.wh>
 <20140120235358.GC5012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shamrock.taprogge.org ([213.146.117.139]:50321 "EHLO
	shamrock.taprogge.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbaAUAUQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 19:20:16 -0500
Content-Disposition: inline
In-Reply-To: <20140120235358.GC5012@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Mon, Jan 20, 2014 at 03:53:58PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Jan 21, 2014 at 12:26:52AM +0100, Jens Taprogge wrote:
> > Hello,
> > 
> > I have bisected the boot failure of a Lenovo Thinkpad X1 Carbon to the
> > merge ea4ebd1cb093c8ec5d7f4bf9070dc444184c3971.  What I call "boot
> > failure" refers to the fact that no console is shown, the machine only
> > reads from the disc for a very short time, and the machine does not
> > respond to Ctrl-Alt-Del, etc.
> > 
> > As it turns out reverting e696c68363740d3a8fe495e353de3ff26b86257a
> > (Input: serio - fix sysfs layout) on top of v3.13 makes the machine boot
> > again.  So far I have now clue how this commit can affect early boot
> > / showing of the console.
> > 
> > Does it ring any bells for you?
> 
> No, not at all, I don't see how that patch could prevent booting,
> especially as it is fixing a regression (i.e. putting things back the
> way they originally were.)
> 
> very odd.
> 
> greg k-h

I agree.  This machine had some very weird boot issues a while ago.
I was starting to suspect it had some alignment issue of some vector
that the EFI firmware uses when handing over control to the kernel.
(Note that I know very little about EFI.)  Does that make any sense?

See this thread http://www.spinics.net/lists/stable/msg09886.html for
the old discussion.  Back then, the problem disappeared with later
version of the kernel / compiler.

Best Regards,
Jens
