From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: qt1070: Why IRQF_TRIGGER_NONE?
Date: Fri, 4 May 2012 00:56:06 -0700
Message-ID: <20120504075606.GA4675@core.coreip.homeip.net>
References: <CACKLOr1XE+tJ92jbfOHdDQVVsXhsNASrHgENEbiuR+8aBE11cw@mail.gmail.com>
 <4FA1E237.2070404@atmel.com>
 <ABFEDD1A8D2AAF42A54E3C074D49DC720F627464@penmbx02>
 <20120503081449.065a8232@endymion.delvare>
 <ABFEDD1A8D2AAF42A54E3C074D49DC720F6279BE@penmbx02>
 <CACKLOr1hJ5HMfN12ukrNMa3NB_d8u7-VAyJ_D4d6jOb=mB4n_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45634 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039Ab2EDH4N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 May 2012 03:56:13 -0400
Received: by pbbrp8 with SMTP id rp8so3518083pbb.19
        for <linux-input@vger.kernel.org>; Fri, 04 May 2012 00:56:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACKLOr1hJ5HMfN12ukrNMa3NB_d8u7-VAyJ_D4d6jOb=mB4n_w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: "Shen, Voice" <Voice.Shen@atmel.com>, Jean Delvare <khali@linux-fr.org>, "Wu, Josh" <Josh.wu@atmel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Wolfram Sang <w.sang@pengutronix.de>, Axel Lin <axel.lin@gmail.com>

Hi Javier,

On Fri, May 04, 2012 at 09:06:16AM +0200, javier Martin wrote:
> Hi all,
> thank you for your comments.
> 
> On 4 May 2012 04:07, Shen, Voice <Voice.Shen@atmel.com> wrote:
> > Hi Jean,
> >  Thank you for your information. Although the irq_flag can not be added into "struct i2c_board_info" till now, I will try to find other solution.
> >
> >  Thanks again.
> >
> > Hi Javier,
> >  As to the IRQ flag depends on SOC. We try to find other solution. Please describe you issue in detail. And what's the mode does your SOC support.
> 
> As I stated, with the current 'IRQF_TRIGGER_NONE' flag, this driver
> doesn't work in i.MX27. Furthermore, I don't think it works on any
> platform since as you previously pointed according to the datasheet of
> qt1070, we can use either IRQF_TRIGGER_FALLING or IRQF_TRIGGER_LOW.
> But I don't know what is the sense of using 'IRQF_TRIGGER_NONE' here.

IRQF_TRIGGER_NONE == 0, i.e. "use whatever method board code set up".

-- 
Dmitry
