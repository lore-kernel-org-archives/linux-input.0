From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Another ALPS touchpad
Date: Sun, 5 Jan 2014 15:47:23 -0800
Message-ID: <20140105234723.GA32292@core.coreip.homeip.net>
References: <20140103045915.GB30008@whitehail.bostoncoop.net>
 <5612072.Tm4gq8bhLq@dtor-d630.eng.vmware.com>
 <CA+F6ckPRj0NrerBC7j41QOE6ZsV7tPQ35gZEfk8cFZws7sT1vg@mail.gmail.com>
 <20140104133108.GA7296@whitehail.bostoncoop.net>
 <CA+F6ckMzRnP2E--nimZA+-cfR_wmbsN4hPvr4AONt4J_c_X4kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:44362 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaAEXr1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Jan 2014 18:47:27 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so17811845pbc.20
        for <linux-input@vger.kernel.org>; Sun, 05 Jan 2014 15:47:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+F6ckMzRnP2E--nimZA+-cfR_wmbsN4hPvr4AONt4J_c_X4kw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tommy Will <tommywill2011@gmail.com>
Cc: Dylan Paul Thurston <dpthurst@indiana.edu>, Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org

On Sun, Jan 05, 2014 at 10:53:52AM +0800, Tommy Will wrote:
> 2014/1/4 Dylan Paul Thurston <dpthurst@indiana.edu>:
> >
> > I didn't quite follow this or the following discussion. One thing I
> > wanted to look into was whether it was possible to have a middle mouse
> > click in addition to the left and right clicks.
> 
> Normally, clickpad only supports Left/Right click. I'm afraid middle
> click would not be supported as standard.

On devices that lack middle button middle click is usually emulated by
pressing both left and right buttons. Also, since this is multi-touch
device quite often middle click is mapped on 2- or 3-finger tap. All of
that is done in X driver and not in kernel.

Thanks.

-- 
Dmitry
