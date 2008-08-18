From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Autocentering support for Logitech MOMO Racing Wheel
	(force feedback)
Date: Mon, 18 Aug 2008 11:24:18 -0400
Message-ID: <20080818110815.ZZRA012@mailhub.coreip.homeip.net>
References: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.229]:19027 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbYHRPYZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Aug 2008 11:24:25 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2119102wri.5
        for <linux-input@vger.kernel.org>; Mon, 18 Aug 2008 08:24:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bb829a0b0808180217t2bd3ed49q4cf5734dcc756311@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ???????????? ?????????????? <sergey.belyashov@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Sergey,

On Mon, Aug 18, 2008 at 01:17:48PM +0400, ???????????? ?????????????? wrote:
> Hello.
>   Current kernel has no support for autocentering for Logitech wheels.
> By default autocentering enabled in wheel and constant effect does not
> work properly. Using USB sniffer I found command which change
> autocentering settings: 0xFE, 0x0D, 0x0R, 0x0L, 0x80, 0x00, 0x00,
> where R - clockwise force, L - counter-clockwise (0x0-0xF, 0xC =
> 100%). I write patch for my current kernel (2.6.25), but I think git
> version also supported, because I do not found any changes in it.
> Currently kernel interface has no support for separate autocenter
> control and so I do not implement it.
>   And some interesting command 0xF3 (or 0xF5 - I do not understand
> difference) which makes wheel very easy to rotate (a-la wheel booster
> - no any resistance). Effect of that command can be disabled by
> setting any (zero too) autocentering strength. I do not found in
> kernel interface any standart command for this feature.

This could probably implemented via a sysfs device knob...

> 
>  	error = input_ff_create_memless(dev, NULL, hid_lgff_play);
>  	if (error)
>  		return error;
> 
> +	if (autocenter && dev->ff && (!dev->ff->set_autocenter))
> +		dev->ff->set_autocenter = hid_lgff_set_autocenter;
> +

You can just do "if (test_bit(FF_AUTOCENTER, dev->ffbit))" and you
won't need a temp variable. Also why do you need the rest of the check?

-- 
Dmitry
