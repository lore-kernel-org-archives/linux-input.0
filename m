From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [RFC PATCH] Input: tm2-touchkey - add hardware dependency
Date: Wed, 3 May 2017 10:31:10 +0200
Message-ID: <20170503103110.748c306a@endymion>
References: <CGME20170424074240epcas3p2f90e0507afab25e9bfa48fe564936198@epcas3p2.samsung.com>
        <20170424094231.435f82de@endymion>
        <20170425022817.kee4h4wje3dzeilq@gangnam.samsung>
        <20170425115500.6d5c8bee@endymion>
        <20170425110056.5aw5ce6b74z6txl2@gangnam.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752550AbdECIbO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 3 May 2017 04:31:14 -0400
In-Reply-To: <20170425110056.5aw5ce6b74z6txl2@gangnam.samsung>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: linux-input@vger.kernel.org, Jaechul Lee <jcsing.lee@samsung.com>, Beomho Seo <beomho.seo@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi Andi,

On Tue, 25 Apr 2017 20:00:56 +0900, Andi Shyti wrote:
> > > On Mon, Apr 24, 2017 at 09:42:31AM +0200, Jean Delvare wrote:
> > So it really boils down to this question: is that chip a generic part
> > from Cypress, and if so, what is the real part number? Or was is
> > designed privately by Cypress specifically for Samsung for this one
> > board (and possibly others to come)?
> 
> I knew that the naming was bringing confusion and we had a
> previous discussion about it with Chanwoo [1].
>
> This is indeed a generic device from Cypress. The driver has been
> ported from Android's Kernel [2]; it says that the device
> part is cy8cmbr3xxx, but the datasheet [3] doesn't have any
> connection with what the TM2 board has (i.e. the registers don't
> match). That's why we suspected that (as you said) this might be
> a touch key sensor specifically designed for the TM2 board.

Thanks for the pointers, it helps.

> Cypress was not that helpful.

I've been there before with other manufacturers. Chipsets designed
specifically for one hardware vendor are the hardest to support for this
reason.

> The alternative was to not provide support, but it didn't look
> right.

I agree, you did the right thing by getting the driver upstream. But it
doesn't mean this driver must be enabled in all distribution kernels.

-- 
Jean Delvare
SUSE L3 Support
