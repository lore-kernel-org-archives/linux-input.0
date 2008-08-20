From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: evdev.c(EVIOCGBIT): Suspicious buffer size 511,
Date: Wed, 20 Aug 2008 09:31:57 -0400
Message-ID: <20080820092806.ZZRA012@mailhub.coreip.homeip.net>
References: <dd18b0c30808172310u7cf7836ai15e19485908ae0ce@mail.gmail.com> <20080820000040.55015b48.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:61843 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbYHTNcD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Aug 2008 09:32:03 -0400
Received: by gxk9 with SMTP id 9so137638gxk.13
        for <linux-input@vger.kernel.org>; Wed, 20 Aug 2008 06:32:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080820000040.55015b48.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Justin Mattock <justinmattock@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Wed, Aug 20, 2008 at 12:00:40AM -0700, Andrew Morton wrote:
> On Sun, 17 Aug 2008 23:10:54 -0700 "Justin Mattock" <justinmattock@gmail.com> wrote:
> 
> > I'm noticing:
> > evdev.c(EVIOCGBIT): Suspicious buffer size 511, limiting output to 64
> > bytes. See http://userweb.kernel.org/~dtor/eviocgbit-bug.html
> > with rc-3 not with rc2.
> > Did the patch to synaptics, seems
> > my xorg is not reading /usr/X11R6/lib/modules/input/synaptics_drv.o
> > only /usr/lib/xorg/modules/input/synaptics_drv.so
> > is there any easy fix, or do I have to recompile xorg?
> > regards;
> > 
> 
> (cc's added)
> 

You can just copy the updated file manually into
/usr/lib/xorg/modules/input/.

I tried rebuilding synaptics from here:

git://anongit.freedesktop.org/git/xorg/driver/xf86-input-synaptics

but unfortunately it fails with some automake crap that I don't have
time to trace through at the moment.

-- 
Dmitry
