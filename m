From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: stmfts,s6sy671 - add SPDX identifier
Date: Fri, 5 Jan 2018 08:49:58 -0800
Message-ID: <20180105164958.csojn6vhy72bwoac@dtor-ws>
References: <CGME20171212074156epcas2p4fefff65c3316ec1aa9b3d7797aaca550@epcas2p4.samsung.com>
 <20171212074149.7844-1-andi.shyti@samsung.com>
 <20180105095715.GA6679@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180105095715.GA6679@gangnam.samsung>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

Hi Andi,

On Fri, Jan 05, 2018 at 06:57:15PM +0900, Andi Shyti wrote:
> Hi Dmitry,
> 
> this is a kind ping, would you also mind giving me a feedback to

Yes, sorry. Could you please split the patch for each driver
individually? Also, until we have an update to the CodingStyle doc
mandating the C++ style comments, I'd prefer keeping the original style
of comments. So // for the SPDX line and /* */ for the rest.

Thanks!

> all the previous patches I sent?

Could you tell me what reviews I owe you? My mailbox keeps growing :(

> 
> Thanks,
> Andi
> 
> On Tue, Dec 12, 2017 at 04:41:49PM +0900, Andi Shyti wrote:
> > Replace the original license statement with the SPDX identifier.
> > 
> > Update also the copyright owner adding myself as co-owner of the
> > copyright.
> > 
> > Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> > ---
> >  drivers/input/touchscreen/s6sy761.c | 15 +++++----------
> >  drivers/input/touchscreen/stmfts.c  | 15 +++++----------
> >  2 files changed, 10 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
> > index 26b1cb8a88ec..675efa93d444 100644
> > --- a/drivers/input/touchscreen/s6sy761.c
> > +++ b/drivers/input/touchscreen/s6sy761.c
> > @@ -1,13 +1,8 @@
> > -/*
> > - * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> > - * Author: Andi Shyti <andi.shyti@samsung.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> > - * Samsung S6SY761 Touchscreen device driver
> > - */
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Samsung S6SY761 Touchscreen device driver
> > +//
> > +// Copyright (c) 2017 Samsung Electronics Co., Ltd.
> > +// Copyright (c) 2017 Andi Shyti <andi.shyti@samsung.com>
> >  
> >  #include <asm/unaligned.h>
> >  #include <linux/delay.h>
> > diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
> > index c12d01899939..2a123e20a42e 100644
> > --- a/drivers/input/touchscreen/stmfts.c
> > +++ b/drivers/input/touchscreen/stmfts.c
> > @@ -1,13 +1,8 @@
> > -/*
> > - * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> > - * Author: Andi Shyti <andi.shyti@samsung.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> > - * STMicroelectronics FTS Touchscreen device driver
> > - */
> > +// SPDX-License-Identifier: GPL-2.0
> > +// STMicroelectronics FTS Touchscreen device driver
> > +//
> > +// Copyright (c) 2017 Samsung Electronics Co., Ltd.
> > +// Copyright (c) 2017 Andi Shyti <andi.shyti@samsung.com>
> >  
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> > -- 
> > 2.15.1
> > 

-- 
Dmitry
