From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] hid: usbhid: Return -ENOMEM instead of -1 for memory
 allocation failure
Date: Mon, 26 Nov 2012 10:05:30 -0800
Message-ID: <20121126180530.GE14623@core.coreip.homeip.net>
References: <1353478830-23788-1-git-send-email-sachin.kamat@linaro.org>
 <alpine.LNX.2.00.1211222202530.4609@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63106 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409Ab2KZSFf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Nov 2012 13:05:35 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so5236920pad.19
        for <linux-input@vger.kernel.org>; Mon, 26 Nov 2012 10:05:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1211222202530.4609@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-input@vger.kernel.org, jic23@kernel.org, patches@linaro.org

On Thu, Nov 22, 2012 at 10:03:44PM +0100, Jiri Kosina wrote:
> On Wed, 21 Nov 2012, Sachin Kamat wrote:
> 
> > Silences the following smatch warning:
> > drivers/hid/usbhid/hiddev.c:897 hiddev_connect() warn:
> > returning -1 instead of -ENOMEM is sloppy
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/hid/usbhid/hiddev.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
> > index 14599e2..50e2ab8 100644
> > --- a/drivers/hid/usbhid/hiddev.c
> > +++ b/drivers/hid/usbhid/hiddev.c
> > @@ -894,7 +894,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
> >  	}
> >  
> >  	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
> > -		return -1;
> > +		return -ENOMEM;
> >  
> >  	init_waitqueue_head(&hiddev->wait);
> >  	INIT_LIST_HEAD(&hiddev->list);
> 
> Well, this would make sense only if the callers would be actualling doing 
> something useful with that return value. But the only check we are 
> performing at callsites is non-zero test ...

It is chicken and egg problem - callers can't use the result unless it
is meaningful and callee's do not bother to send anything meaningful
because nobody uses it...

If someone takes time to convert to proper return codes I think it would
be a good thing.

Thanks.

-- 
Dmitry
