From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid/hid-sony: Apply sixaxis quirks only to sixaxis
Date: Thu, 2 Sep 2010 09:41:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009020941120.26813@pobox.suse.cz>
References: <1272917756-31098-1-git-send-email-ospite@studenti.unina.it> <1272917756-31098-2-git-send-email-ospite@studenti.unina.it> <1283357615.2361.20.camel@localhost.localdomain> <20100901192055.2f23c8c7.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:35680 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab0IBHlb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Sep 2010 03:41:31 -0400
In-Reply-To: <20100901192055.2f23c8c7.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, cbe-oss-dev@lists.ozlabs.org

On Wed, 1 Sep 2010, Antonio Ospite wrote:

> > > Be more explicit and avoid calling sony_set_operational_usb() when we
> > > have USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE.
> > > 
> > > While at it, rename the sony_set_operational routines to
> > > sixaxis_set_operational as they are sixaxis specific.
> > > 
> > > This is also in preparation for the sysfs interface to set and get bdaddr
> > > over usb and for some other Sixaxis report fixup.
> > > 
> > > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
> > 
> > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> >
> 
> Thanks Bastien for bringing this up again, I was going to repost
> this patch sometime this month.
> 
> Added Jiri to CC as I forgot to do that back then.

Thanks, I have missed that one on linux-input@.

Applied now.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
