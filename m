From: "davor emard" <davoremard@gmail.com>
Subject: Re: uinput oopses and bugs
Date: Fri, 28 Mar 2008 01:55:19 +0100
Message-ID: <beee72200803271755u468f5d0djd10d282593644a7d@mail.gmail.com>
References: <beee72200803260141y59b96c56n9fccfda6c72d1783@mail.gmail.com>
	 <20080326132844.GC25854@cathedrallabs.org>
	 <beee72200803260709p7239ae8etb4e00b608bbfb6bc@mail.gmail.com>
	 <20080326182314.GF25854@cathedrallabs.org>
	 <beee72200803270115v72eb1cd3s38ae90a4efd6acd1@mail.gmail.com>
	 <20080327202245.GK25854@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.182]:13881 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbYC1AzV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2008 20:55:21 -0400
Received: by py-out-1112.google.com with SMTP id u52so11749pyb.10
        for <linux-input@vger.kernel.org>; Thu, 27 Mar 2008 17:55:20 -0700 (PDT)
In-Reply-To: <20080327202245.GK25854@cathedrallabs.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aristeu Rozanski <aris@cathedrallabs.org>
Cc: linux-input@vger.kernel.org

HI Aristeu

> first, please keep the mailing list on Cc. two reasons: first, I may not
> be able to answer other questions; second, other people may have the
> same problems you do and this discussion can be useful for them.

Last time the mail from the list bounced again although I've explicitely
subscribed to linux-input@vger.kernel.org but nevermind

>
> > Still the EV_FF makes EV_LED and EV_SND not working.
> will work on that next.

Hope the reproducer works for you, it's a bit clumsy written
but I hope it's useful to track this LED and SND disabling by
FF

> > There is also a still issue with segfault and unkillable driver.
> > I upload custom FF effect, driver segfaults but doesn't exit
> > and becomes zombie
> please test the attached patch

The patch now avoids the zombie lockup coming from segmentation
fault.  Thanks a lot, that is great step forward!

However it's still not clear to me why do I get this segmentation
fault when I try to upload a block of FF_CUSTOM sample data.
I made my code mainly from looking at the kernel source without
having any example - anyone on the list can point link to some small
code example?

in uinput-zombie, I've prepared the data in application, ioctl'ed them
to uinput event device and the uinput driver segfaults when
it tries to read the portion of  FF_CUSTOM data.

Best regards, Davor
