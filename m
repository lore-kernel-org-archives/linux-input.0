From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: marix-keymap - automatically allocate memory for
 keymap
Date: Wed, 14 Nov 2012 08:37:07 -0800
Message-ID: <20121114163707.GB29131@core.coreip.homeip.net>
References: <20121108164519.GA9334@core.coreip.homeip.net>
 <20121114104059.7442d460@avionic-0020.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38311 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820Ab2KNQhM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 11:37:12 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so481546pbc.19
        for <linux-input@vger.kernel.org>; Wed, 14 Nov 2012 08:37:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121114104059.7442d460@avionic-0020.adnet.avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alban Bedel <alban.bedel@avionic-design.de>
Cc: linux-input@vger.kernel.org

Hi Alban,

On Wed, Nov 14, 2012 at 10:40:59AM +0100, Alban Bedel wrote:
> On Thu, 8 Nov 2012 08:45:21 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > +	if (!keymap) {
> > +		keymap = devm_kzalloc(input_dev->dev.parent,
> > +				      max_keys * sizeof(*keymap),
> > +				      GFP_KERNEL);
> 
> In my tree GFP_KERNEL isn't defined at that point. Is an include
> missing in this patch or is my tree (3.6+some next cherry picks)
> missing a commit?

No, I apparetnly had an older tree when I created a patch, i have since
added include/linux/gfp.h

> 
> > +		if (!keymap) {
> > +			dev_err(input_dev->dev.parent,
> > +				"Unable to allocate memory for keymap");
> > +			return -ENOMEM;
> > +		}
> > +	}
> > +
> >  	input_dev->keycode = keymap;
> >  	input_dev->keycodesize = sizeof(*keymap);
> > -	input_dev->keycodemax = rows << row_shift;
> > +	input_dev->keycodemax = max_keys;
> >  
> >  	__set_bit(EV_KEY, input_dev->evbit);
> >  
> 
> Otherwise that look good to me.

Great, I am putting you down as reviewed-by then.

Thanks.

-- 
Dmitry
