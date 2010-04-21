From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC/RFT] Synaptics -
Date: Wed, 21 Apr 2010 10:24:20 -0700
Message-ID: <20100421172420.GE10566@core.coreip.homeip.net>
References: <20100421061116.GF4364@core.coreip.homeip.net>
 <s5hiq7khqbf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:45236 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab0DURYZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 13:24:25 -0400
Received: by qyk9 with SMTP id 9so9629139qyk.1
        for <linux-input@vger.kernel.org>; Wed, 21 Apr 2010 10:24:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hiq7khqbf.wl%tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org

On Wed, Apr 21, 2010 at 03:45:40PM +0200, Takashi Iwai wrote:
> At Tue, 20 Apr 2010 23:11:17 -0700,
> Dmitry Torokhov wrote:
> > 
> > Newer Synaptics firmware allows to quesry maximim dimensions reported by
> > device, let's use this data.
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> > ---
> > 
> > Takashi,
> > 
> > I would appreciate if you could give this patch a try.
> 
> The bit definition seems wrong:
> 
> > @@ -51,6 +52,7 @@
> >  #define SYN_CAP_MULTI_BUTTON_NO(ec)	(((ec) & 0x00f000) >> 12)
> >  #define SYN_CAP_PRODUCT_ID(ec)		(((ec) & 0xff0000) >> 16)
> >  #define SYN_CAP_CLICKPAD(ex0c)		((ex0c) & 0x100100)
> > +#define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x02)
> 
> This should be
> 
> 	#define SYN_CAP_MAX_DIMENSIONS(ex0c)	((ex0c) & 0x020000)
> 

You are right. I forgot we shift the bytes around...

> After changing this, it seems working fine.
> The area is detected as 5584 x 4618.
> 

Great! Thank you.

-- 
Dmitry
