From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/6] Staging: mrst_touchscreen: clean up input side
Date: Wed, 25 Aug 2010 07:46:24 -0700
Message-ID: <20100825144624.GC5752@core.coreip.homeip.net>
References: <20100723134852.19151.6999.stgit@localhost.localdomain>
 <20100723135151.19151.73344.stgit@localhost.localdomain>
 <20100727181831.GA29281@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42215 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002Ab0HYOq3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Aug 2010 10:46:29 -0400
Received: by pzk9 with SMTP id 9so202621pzk.19
        for <linux-input@vger.kernel.org>; Wed, 25 Aug 2010 07:46:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100727181831.GA29281@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org

On Tue, Jul 27, 2010 at 11:18:31AM -0700, Greg KH wrote:
> On Fri, Jul 23, 2010 at 02:51:52PM +0100, Alan Cox wrote:
> > Fix most of the stuff that Dmitry pointed out. This leaves the mutex in IRQ
> > and misuse of SPI to sort out.
> > 
> > Also fix the build bits so it actually builds in staging - whoops.
> > 
> > Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> This doesn't apply for some reason.  Care to resend all 6 of these so I
> can apply them?
> 

*ping* Do not see anything in linux-next/mainline... And the
driver/patches looked good to me.

-- 
Dmitry
