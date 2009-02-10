From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 0/2] Make the touchpad on the MSI Wind netbook work
Date: Tue, 10 Feb 2009 15:06:43 -0800
Message-ID: <20090210150643.45278cf1@infradead.org>
References: <20090204191540.2d6abd87@infradead.org>
	<20090210202558.GH1382@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:38408 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755995AbZBJXGx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2009 18:06:53 -0500
In-Reply-To: <20090210202558.GH1382@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Tue, 10 Feb 2009 21:25:58 +0100
Pavel Machek <pavel@suse.cz> wrote:

> On Wed 2009-02-04 19:15:40, Arjan van de Ven wrote:
> > Hi,
> > 
> > A MSI Wind (100) netbook landed on my desk with the comment
> > "touchpad doesn't work in Linux but works in XP". 
> > 
> > It turns out that there are a 2 separate issues with this netbook
> > that needed fixing 
> > 
> > 1) The touchpad requires the equivalent of "i8042.reset", which
> > resets the controller before probing. (This is done via a DMI quirk
> > in patch 2/2)
> > 
> > 2) About half the time, the reset will fail the first time. In the
> > current code, this is fatal and then also disables the keyboard in
> > addition to the touchpad. Ungood. Patch 1 makes the kernel retry the
> > reset upto five times before giving up (it seems the 2nd or 3rd time
> > succeed for me), and also adds an option to not make such a failure
> > fatal to the keyboard.
> > 
> > I don't think this is a regression, but it is pretty nasty behavior
> > (the machine is useless without) so it could be a 2.6.29
> > candidate...
> 
> Well, that beast was selling with linux preloaded, no? Or was it
> another msi wind? In such case I'd expect old kernel to work... or
> maybe some reasonable workaround somewhere...

afaik the newer ones have a different touchpad


> 


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
