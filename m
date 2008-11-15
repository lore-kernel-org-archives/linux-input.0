From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: USB hid blocks USB port in 2.6.28rc3
Date: Sun, 16 Nov 2008 00:54:28 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811160053580.19853@jikos.suse.cz>
References: <20081111084132.GE3810@one.firstfloor.org> <Pine.LNX.4.44L0.0811111143050.29125-100000@netrider.rowland.org> <20081111210705.GG3810@one.firstfloor.org> <200811160058.14747.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:35005 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751685AbYKOXy3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Nov 2008 18:54:29 -0500
In-Reply-To: <200811160058.14747.rjw@sisk.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andi Kleen <andi@firstfloor.org>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Sun, 16 Nov 2008, Rafael J. Wysocki wrote:

> > Ok, but it worked in all kernels before. Why has that changed?
> > Looks like a regression to me. Rafael, can you please add it to the list?
> Done.

I already have a (verified) fix in my tree (not sent to Linus yet, will 
happen in a day or two hopefully).

-- 
Jiri Kosina
SUSE Labs
