From: Andi Shyti <andi@etezian.org>
Subject: Re: [PATCH v2 1/3] Input: ad7897 - use managed allocated resources
Date: Thu, 9 Nov 2017 00:36:15 +0900
Message-ID: <20171108153615.yy4gdsmc3ahr5uqu@jack.zhora.eu>
References: <20171108140403.727-1-andi@etezian.org>
 <20171108140403.727-2-andi@etezian.org>
 <dda00dd7-5174-4aef-1824-1c1fda0688f6@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 12.mo3.mail-out.ovh.net ([188.165.41.191]:38509 "EHLO
        12.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdKHPg3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Nov 2017 10:36:29 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3FE3916CA14
        for <linux-input@vger.kernel.org>; Wed,  8 Nov 2017 16:36:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <dda00dd7-5174-4aef-1824-1c1fda0688f6@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Andi Shyti <andi@etezian.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

> > -	ts = kzalloc(sizeof(struct ad7877), GFP_KERNEL);
> > -	input_dev = input_allocate_device();
> > -	if (!ts || !input_dev) {
> > -		err = -ENOMEM;
> > -		goto err_free_mem;
> > -	}
> > +	ts = devm_kzalloc(&spi->dev, sizeof(struct ad7877), GFP_KERNEL);
> > +	input_dev = devm_input_allocate_device(&spi->dev);
> > +	if (!input_dev)
> 
> You removed the check for 'ts' here and only added it back in patch 3.

Oh yes, because I squashed the 5 patches I sent earlier and I
forgot about this.

Thanks!

Andi
