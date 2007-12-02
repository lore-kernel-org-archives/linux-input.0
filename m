From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: REGRESSION: 2.6.24:  false double-clicks from USB mouse
Date: Sun, 2 Dec 2007 09:07:55 -0800
Message-ID: <20071202090755.342280f6@laptopd505.fenrus.org>
References: <4752DB8C.50608@rtr.ca>
	<4752E432.10504@rtr.ca>
	<4752E5AD.40905@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:48181 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbXLBRJZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Dec 2007 12:09:25 -0500
In-Reply-To: <4752E5AD.40905@rtr.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: dmitry.torokhov@gmail.com, rubini@ipvvis.unipv.it, linux-input@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, jkosina@suse.cz, linux-usb@vger.kernel.org

On Sun, 02 Dec 2007 12:04:45 -0500
Mark Lord <lkml@rtr.ca> wrote:

> Mark Lord wrote:
> > Mark Lord wrote:
> >> I've only just recently tried running 2.6.24 on my main machine.
> >> And it appears that I'll have to go back to 2.6.23,
> >> because the USB mouse is not working correctly.
> >>
> >> Single-clicking on things with 2.6.24 very frequently gives a 
> >> "double-click".
> >> This does not happen with 2.6.23.8.
> >>
> >> I wonder what broke it?
> >>
> >> I've grabbed mousedev.c from 2.6.23 and inserted that in place
> >> of the updated 2.6.24 source, but no change.  So it's not that
> >> file.
> > ...
> > 
> > Mmm.. reverting the entire drivers/hid directory to that from 2.6.23
> > seems to have fixed the problem, so we now know it's in there
> > somewhere.
> > 


just making sure.. this is while running an untainted kernel without
something like vmware loaded, right?


-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
