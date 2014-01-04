From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Another ALPS touchpad
Date: Fri, 3 Jan 2014 22:18:15 -0800
Message-ID: <20140104061815.GC20272@core.coreip.homeip.net>
References: <20140103045915.GB30008@whitehail.bostoncoop.net>
 <5612072.Tm4gq8bhLq@dtor-d630.eng.vmware.com>
 <CA+F6ckPRj0NrerBC7j41QOE6ZsV7tPQ35gZEfk8cFZws7sT1vg@mail.gmail.com>
 <20140104054021.GB32576@core.coreip.homeip.net>
 <CA+F6ckNPxxmGHqHuPoRNMzgyS=kNYc5NZhqOYuMsaReqaimffQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:65169 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbaADGSS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 01:18:18 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so16490788pbc.20
        for <linux-input@vger.kernel.org>; Fri, 03 Jan 2014 22:18:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+F6ckNPxxmGHqHuPoRNMzgyS=kNYc5NZhqOYuMsaReqaimffQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Dylan Paul Thurston <dpthurst@indiana.edu>, linux-input@vger.kernel.org

On Sat, Jan 04, 2014 at 02:08:26PM +0800, Tommy Will wrote:
> 2014/1/4 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Thursday, January 02, 2014 11:59:15 PM Dylan Paul Thurston wrote:
> 
> >> Yes, it's an ALPS device and we're now preparing the patch for this new one.
> >> BTW, since it's a ClickPad without seperate buttons, simple resting
> >> finger logic would be added.
> >
> > Hmm, what finger resting logic? We already properly support clickpads in
> > X driver (as long as the kernel tells userspace that the device is a
> > clickpad) so what is missing?
> >
> 
> I remember in previous kernel version, I tried to register the device
> as clickpad but only left/right button click can be recognized by
> X-Server. When putting 1finger still in button area and moving another
> finger in normal area, X-Server would not consider it as 1finger
> cursoring.
> 
> Looks like this:
> 
> http://ubuntuforums.org/showthread.php?t=1991841
> 
> Does X-server have already supported this feature? (I'm sorry I did
> not try the latest X-Server)

It should as far as I know (I do not have any clickpad devices).

Thanks.

-- 
Dmitry
