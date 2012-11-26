From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid: usbhid: Return -ENOMEM instead of -1 for memory
 allocation failure
Date: Mon, 26 Nov 2012 23:09:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211262308230.15521@pobox.suse.cz>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org> <alpine.LNX.2.00.1211222202530.4609@pobox.suse.cz> <20121126180530.GE14623@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45535 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755818Ab2KZWJL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 17:09:11 -0500
In-Reply-To: <20121126180530.GE14623@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, jic23@kernel.org, patches@linaro.org

On Mon, 26 Nov 2012, Dmitry Torokhov wrote:

> > > Silences the following smatch warning:
> > > drivers/hid/usbhid/hiddev.c:897 hiddev_connect() warn:
> > > returning -1 instead of -ENOMEM is sloppy
> > > 
> > > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > > ---
> > >  drivers/hid/usbhid/hiddev.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> > > index 14599e2..50e2ab8 100644
> > > --- a/drivers/hid/usbhid/hiddev.c
> > > +++ b/drivers/hid/usbhid/hiddev.c
> > > @@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
> > >  	}
> > >  
> > >  	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
> > > -		return -1;
> > > +		return -ENOMEM;
> > >  
> > >  	init_waitqueue_head(&hiddev->wait);
> > >  	INIT_LIST_HEAD(&hiddev->list);
> > 
> > Well, this would make sense only if the callers would be actualling doing 
> > something useful with that return value. But the only check we are 
> > performing at callsites is non-zero test ...
> 
> It is chicken and egg problem - callers can't use the result unless it
> is meaningful and callee's do not bother to send anything meaningful
> because nobody uses it...
> 
> If someone takes time to convert to proper return codes I think it would
> be a good thing.

Fully agree with you.

But I'd like to have both sides changed together once someone starts 
taking care of fixing it.

Thanks,

-- 
Jiri Kosina
SUSE Labs
