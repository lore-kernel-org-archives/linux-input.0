From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH 01/12] Input: ad7897 - use managed devm_device_add_group
Date: Fri, 27 Oct 2017 15:11:07 +0900
Message-ID: <20171027061107.GC29398@gangnam>
References: <20170929203839.7010-1-andi@etezian.org>
        <20170929203839.7010-2-andi@etezian.org>
        <CGME20170929233218epcas5p2b27950ed7f0765f864ec181ad0c67db9@epcas5p2.samsung.com>
        <20170929233212.GB14362@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:17563 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdJ0GKl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 27 Oct 2017 02:10:41 -0400
Content-disposition: inline
In-reply-to: <20170929233212.GB14362@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi@etezian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

Hi Dmitry,

> > Commit 57b8ff070f98 ("driver core: add devm_device_add_group()
> > and friends") has added the the managed version for creating
> > sysfs group files.
> > 
> > Use devm_device_add_group instead of sysfs_create_group and
> > remove the relative sysfs_remove_group and goto label.
> > 
> > CC: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Andi Shyti <andi@etezian.org>
> > ---
> >  drivers/input/touchscreen/ad7877.c | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> > index 9c250ae780d9..677ba38b4d1c 100644
> > --- a/drivers/input/touchscreen/ad7877.c
> > +++ b/drivers/input/touchscreen/ad7877.c
> > @@ -783,18 +783,16 @@ static int ad7877_probe(struct spi_device *spi)
> >  		goto err_free_mem;
> >  	}
> >  
> > -	err = sysfs_create_group(&spi->dev.kobj, &ad7877_attr_group);
> > +	err = devm_device_add_group(&spi->dev, &ad7877_attr_group);
> 
> This changes order of operations and ultimately may cause use-after-free
> as memory for ad7877 structure will be freed before we remove
> attributes.

yes, right... sorry... was too fast at making these patches :)
I'll send a second version over the weekend.

Andi
