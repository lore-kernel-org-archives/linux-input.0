From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: usb mouse not responding after resume
Date: Fri, 10 Jul 2009 10:56:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0907101052500.2906-100000@iolanthe.rowland.org>
References: <E1MPCb9-0007w0-BK@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:43817 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752032AbZGJO4n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2009 10:56:43 -0400
In-Reply-To: <E1MPCb9-0007w0-BK@pomaz-ex.szeredi.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 10 Jul 2009, Miklos Szeredi wrote:

> Sometimes after resume the usb mouse plugged into my T60 notebook
> isn't working.  Unplugging and replugging it fixes the problem.  A
> keyboard is also plugged in, which works normally every time.
> 
> This has been happening on and off from about 2.6.30-rc* but in
> 2.6.31-rc* seems to be getting more frequent.

Looks like something is wrong with the mouse itself.

> Here's the suspend-resume-replug part of the dmesg.  Not sure if it is
> enough, I'd be happy to provide more info.

The log showed that the mouse disconnected itself during the suspend.  
But then after the resume it reconnected -- presumably this log shows a
cycle where the mouse _was_ working afterward.

Can you provide a similar log for a cycle where the mouse _didn't_ 
respond afterward?  It might not help much, however; most likely it 
will show that the mouse disconnects itself during the suspend and then 
doesn't reconnect.

Have you tried plugging the mouse into a different USB port?  It might 
help.

Alan Stern

