From: Dan Carpenter <error27@gmail.com>
Subject: Re: [Bug 15893] Alps: No edge-scrolling since 2.6.34-rc5
Date: Tue, 4 May 2010 08:36:40 +0200
Message-ID: <20100504063640.GQ29093@bicker>
References: <bug-15893-5697@https.bugzilla.kernel.org/> <201005032116.o43LGcXi010308@demeter.kernel.org> <20100503220606.GP29093@bicker> <k2y40ec3ea41005031627sd356674di491a2c4f92d7ad92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38621 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab0EDGhE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 May 2010 02:37:04 -0400
Received: by fxm10 with SMTP id 10so2861790fxm.19
        for <linux-input@vger.kernel.org>; Mon, 03 May 2010 23:37:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <k2y40ec3ea41005031627sd356674di491a2c4f92d7ad92@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, f.zweig@yahoo.de, Dmitry Torokhov <dtor@mail.ru>

On Mon, May 03, 2010 at 07:27:31PM -0400, Chase Douglas wrote:
> Hi Dan,
> 
> On Mon, May 3, 2010 at 6:06 PM, Dan Carpenter <error27@gmail.com> wrote:
> > It looks like the "Acer Aspire One 532h" and the "HP Pavilion dm3"
> > have the same signature but they behave differently.
> >
> > As a result commit 5e28d8eb68 "Input: ALPS - add signature for HP
> > Pavilion dm3 laptops" fixes things for dm3 but breaks the Acer Aspire
> > One 532h which was working (with a userspace driver maybe??).
> 
> There were issues with this change, so it was reverted in the input
> tree. Specifically, it seems that these devices operate under a
> different protocol that the Linux driver does not understand yet.
> 

OK.  Is there any info we need from Felix Zweig about the Acer so that
we don't run into this next time when we add support for the HP again?

It might be good to leave a comment in the source that these two conflict.

Anyway, thanks for the info.

regards,
dan carpenter


