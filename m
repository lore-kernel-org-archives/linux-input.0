From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Subject: Re: [PATCH] Input: fix cobalt_btns loadable keymaps support
Date: Sat, 16 Feb 2008 18:37:39 +0900
Message-ID: <20080216183739.2d2ce005.yoichi_yuasa@tripeaks.co.jp>
References: <20080211215404.1c924c12.yoichi_yuasa@tripeaks.co.jp>
	<20080211105835.ZZRA012@mailhub.coreip.homeip.net>
	<20080211120409.ZZRA012@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo32.po.2iij.net ([210.128.50.17]:13078 "EHLO mo32.po.2iij.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbYBPJhq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Feb 2008 04:37:46 -0500
In-Reply-To: <20080211120409.ZZRA012@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-input@vger.kernel.org

Hi,

On Mon, 11 Feb 2008 12:04:42 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Mon, Feb 11, 2008 at 11:00:27AM -0500, Dmitry Torokhov wrote:
> > Hi Yoichi,
> > 
> > On Mon, Feb 11, 2008 at 09:54:04PM +0900, Yoichi Yuasa wrote:
> > > Fix cobalt_btns loadable keymaps support.
> > > 
> > 
> > Thank you for the patch.
> > 
> > >  	input_set_capability(input, EV_MSC, MSC_SCAN);
> > >  	__set_bit(EV_KEY, input->evbit);
> > > -	for (i = 0; i < ARRAY_SIZE(buttons_map); i++)
> > > -		__set_bit(input->keycode[i], input->keybit);
> > > +	for (i = 0; i < ARRAY_SIZE(cobalt_map); i++)
> > > +		__set_bit(bdev->keymap[i], input->keybit);
> > 
> > This part is not strictly necessary since input->keycode points to
> > bdev->keymap. I will apply the rest of the patch.
> > 
> 
> Oh, I see now... The controlling condition is the loop was incorrect.

Exactly yes.

Thanks,

Yoichi
