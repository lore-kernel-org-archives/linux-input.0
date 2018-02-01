From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 7/8] Input: mms114 - add SPDX identifier
Date: Thu, 01 Feb 2018 09:49:18 +0900
Message-ID: <20180201004918.GE7575@gangnam.samsung>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
        <CGME20180129113331epcas2p193a0a99f660793fbfcf2ec825fac0e2c@epcas2p1.samsung.com>
        <20180129113323.18961-8-andi.shyti@samsung.com>
        <20180129194659.df7nlhwx4demk6o6@dtor-ws>
        <20180131060726.GB7575@gangnam.samsung> <20180131073138.GA1499@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:19331 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932161AbeBAAtW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 Jan 2018 19:49:22 -0500
Content-disposition: inline
In-reply-to: <20180131073138.GA1499@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, jeesw@melfas.com

Hi Marcus,

> > > > - * Copyright (C) 2012 Samsung Electronics Co.Ltd
> > > > - * Author: Joonyoung Shim <jy0922.shim@samsung.com>
> > > > - *
> > > > - * This program is free software; you can redistribute it and/or modify
> > > > - * it under the terms of the GNU General Public License version 2 as
> > > > - * published by the Free Software Foundation.
> > > > - */
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +// Samsung S6SY761 Touchscreen device driver
> > 
> > I'm very sorry, but my distrcation will kill me one day.
> 
> More coffee or sleep - your choice ;-)

I see that beer is not working, indeed :)

> > Is it possible to revert this patch or do you want me to send a
> > fix?
> 
> When you are on it;
> 
> Change
> MODULE_LICENSE("GPL");
> 
> to 
> MODULE_LICENSE("GPL v2");
> To match the former license text and SPDX-identifier.
> 
> See include/linux/module.h:
>  *	"GPL"				[GNU Public License v2 or later]
>  *	"GPL v2"			[GNU Public License v2]

I haven't noticed that. I will fix it in a separate patch.

Thanks,
Andi
