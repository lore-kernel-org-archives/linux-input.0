From: Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 0/4] MMS114 touchscreen patches
Date: Fri, 26 Jan 2018 00:01:59 +1100
Message-ID: <20180125130159.GA26726@lineageos.org>
References: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180124193804.155654-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi.shyti@samsung.com>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for the extra fixes!

On Wed, Jan 24, 2018 at 11:38:00AM -0800, Dmitry Torokhov wrote:
> Hi,
> 
> This is a combination of couple of my patches + Simons patches dropping
> support for platform data and adding support for mms152, slightly reworked.
> 
> Andi, because patches changed a bit I did not add your reviewed-by or
> tested-by, please take another look.
> 
> Thanks!
> 
> Dmitry Torokhov (2):
>   Input: mms114 - do not clobber interrupt trigger
>   Input: mms114 - mark as direct input device
> 
> Simon Shields (2):
>   Input: mms114 - drop platform data and use generic APIs
>   Input: mms114 - add support for mms152
> 
>  .../bindings/input/touchscreen/mms114.txt          |  35 ++--
>  drivers/input/touchscreen/mms114.c                 | 229 ++++++++++++---------
>  include/linux/platform_data/mms114.h               |  24 ---
>  3 files changed, 151 insertions(+), 137 deletions(-)
>  delete mode 100644 include/linux/platform_data/mms114.h
> 
> -- 
> Dmitry
> 

All looks good to me. Tested on MMS114 and MMS152.

Reviewed-by: Simon Shields <simon@lineageos.org>
Tested-by: Simon Shields <simon@lineageos.org>

Cheers,
Simon
