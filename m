From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Input: aiptek: fix crash on detecting device without
 endpoints
Date: Fri, 27 Nov 2015 16:54:07 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1511271650030.17118-100000@netrider.rowland.org>
References: <1953763158.25062502.1448621410440.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:32935 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755246AbbK0VyJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2015 16:54:09 -0500
In-Reply-To: <1953763158.25062502.1448621410440.JavaMail.zimbra@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vladis Dronov <vdronov@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, 27 Nov 2015, Vladis Dronov wrote:

> Hello,
> 
> > > Hmm, I see quite a few drivers assuming that endpoint 0 will be present.
> > > I wonder if that should not be solved at USB level.
> >
> > Every USB device always has endpoint 0.  If one didn't, the kernel 
> > wouldn't be able to initialize and enumerate it.
> 
> Yes for the normal USB device. This case is a weird USB device (with no
> endpoints) specially designed to be weird. My point here is that even a
> weird device probing should not crash a kernel by a NULL-deref.

True.  However, a weird device that didn't have any endpoint 0 would
not crash the kernel, because the kernel wouldn't be able to
communicate with it at all.

> > > Alan, does it make sense to have drivers probe interface if it does not
> > > have any endpoints?
> >
> > Yes; in theory an interface can do everything it needs using only 
> > endpoint 0.  Driver shouldn't assume anything about the endpoints in 
> > the interfaces they problem.
> 
> The current kernel code in drivers/usb/core/config.c accepts an interface
> with no endpoints in one of its configurations, and I could not find a
> direct ban for that in USB standard. So, I currently believe, it is a driver
> job to check if the endpoint 0 exist, otherwise we must change the kernel
> USB detection code.

Drivers do not have to check whether endpoint 0 exists; it always does.  
But they do have to check any other endpoint they use.

> btw, indeed, this is not the only driver with this problem, I've met 2 more.

In fact, there's no way to check whether endpoint 0 exists.  Where 
would you look to find out?  There isn't any endpoint descriptor for 
it.

Alan Stern

