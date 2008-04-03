From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch]convert away from urb->status in xpad driver
Date: Thu, 3 Apr 2008 15:41:54 -0400
Message-ID: <20080403153901.ZZRA012@mailhub.coreip.homeip.net>
References: <200804031326.00717.oliver@neukum.org> <Pine.LNX.4.64.0804031748330.32130@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from el-out-1112.google.com ([209.85.162.176]:41467 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762374AbYDCTmD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 15:42:03 -0400
Received: by el-out-1112.google.com with SMTP id v27so1790607ele.17
        for <linux-input@vger.kernel.org>; Thu, 03 Apr 2008 12:41:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804031748330.32130@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, jikos@suse.cz, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Jan Kratochvil <honza@jikos.cz>

On Thu, Apr 03, 2008 at 05:49:54PM +0200, Jiri Kosina wrote:
> [ added Dmitry ]
> 
> On Thu, 3 Apr 2008, Oliver Neukum wrote:
> 
> > USB is moving to transfering status as a parameter. To ease the transition
> > urb->status is to be touched only once in a function. The xpad driver has
> > been overlooked.
> > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> 
> FWIW
> 
> Acked-by: Jiri Kosina <jkosina@suse.cz>
> 

I think it would be better if this patch come through USB tree so there
are no merge dependencies. I will carry a local copy of this patch so
I don't merge something that may screw it up.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

-- 
Dmitry
