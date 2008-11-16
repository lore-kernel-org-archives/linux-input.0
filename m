From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Sun, 16 Nov 2008 13:35:27 +0100
Message-ID: <200811161335.28354.rjw@sisk.pl>
References: <20081111084132.GE3810@one.firstfloor.org> <200811160058.14747.rjw@sisk.pl> <alpine.LNX.1.10.0811160053580.19853@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:42075 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbYKPMaw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Nov 2008 07:30:52 -0500
In-Reply-To: <alpine.LNX.1.10.0811160053580.19853@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Sunday, 16 of November 2008, Jiri Kosina wrote:
> On Sun, 16 Nov 2008, Rafael J. Wysocki wrote:
> 
> > > Ok, but it worked in all kernels before. Why has that changed?
> > > Looks like a regression to me. Rafael, can you please add it to the list?
> > Done.
> 
> I already have a (verified) fix in my tree (not sent to Linus yet, will 
> happen in a day or two hopefully).

OK, thanks for the info.

Jiri has added the patch link to the Bugzilla entry already.

Best,
Rafael



-- 
Everyone knows that debugging is twice as hard as writing a program
in the first place.  So if you're as clever as you can be when you write it,
how will you ever debug it? --- Brian Kernighan
