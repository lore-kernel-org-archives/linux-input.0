From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/5] input: misc: AD714x: Fix up input configuration.
Date: Wed, 11 May 2011 14:19:05 -0700
Message-ID: <20110511211905.GC11178@core.coreip.homeip.net>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
 <1305027309-17637-2-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44936 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755683Ab1EKVTM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2011 17:19:12 -0400
Received: by pzk9 with SMTP id 9so421358pzk.19
        for <linux-input@vger.kernel.org>; Wed, 11 May 2011 14:19:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305027309-17637-2-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org

On Tue, May 10, 2011 at 01:35:06PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Add missing input name, phys and parent dev.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/input/misc/ad714x.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
> index eb352fb..9d95397 100644
> --- a/drivers/input/misc/ad714x.c
> +++ b/drivers/input/misc/ad714x.c
> @@ -151,6 +151,7 @@ struct ad714x_chip {
>  
>  	unsigned product;
>  	unsigned version;
> +	char phys[32];
>  };
>  
>  static void ad714x_use_com_int(struct ad714x_chip *ad714x,
> @@ -1130,6 +1131,8 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
>  	 * Allocate and register AD714X input device
>  	 */
>  	alloc_idx = 0;
> +	snprintf(ad714x->phys, sizeof(ad714x->phys), "%s/input0",
> +		 dev_name(dev));
>  
>  	/* a slider uses one input_dev instance */
>  	if (ad714x->hw->slider_num > 0) {
> @@ -1152,6 +1155,10 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
>  			input[alloc_idx]->id.bustype = bus_type;
>  			input[alloc_idx]->id.product = ad714x->product;
>  			input[alloc_idx]->id.version = ad714x->version;
> +			input[alloc_idx]->name = "ad714x_captouch_slider";
> +			input[alloc_idx]->phys = ad714x->phys;
> +			input[alloc_idx]->dev.parent = dev;
> +
>  
>  			error = input_register_device(input[alloc_idx]);
>  			if (error)
> @@ -1182,6 +1189,9 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
>  			input[alloc_idx]->id.bustype = bus_type;
>  			input[alloc_idx]->id.product = ad714x->product;
>  			input[alloc_idx]->id.version = ad714x->version;
> +			input[alloc_idx]->name = "ad714x_captouch_wheel";
> +			input[alloc_idx]->phys = ad714x->phys;
> +			input[alloc_idx]->dev.parent = dev;
>  
>  			error = input_register_device(input[alloc_idx]);
>  			if (error)
> @@ -1215,6 +1225,9 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
>  			input[alloc_idx]->id.bustype = bus_type;
>  			input[alloc_idx]->id.product = ad714x->product;
>  			input[alloc_idx]->id.version = ad714x->version;
> +			input[alloc_idx]->name = "ad714x_captouch_pad";
> +			input[alloc_idx]->phys = ad714x->phys;
> +			input[alloc_idx]->dev.parent = dev;
>  
>  			error = input_register_device(input[alloc_idx]);
>  			if (error)
> @@ -1243,6 +1256,9 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
>  		input[alloc_idx]->id.bustype = bus_type;
>  		input[alloc_idx]->id.product = ad714x->product;
>  		input[alloc_idx]->id.version = ad714x->version;
> +		input[alloc_idx]->name = "ad714x_captouch_button";
> +		input[alloc_idx]->phys = ad714x->phys;

Now you have 3 devices with the same 'phys' and 'phys' is supposed to be
unique. You could change the code so phys would end with input0, input1
and input2 respectively, but I'd just left phys as NULL though.

Thanks.

-- 
Dmitry
