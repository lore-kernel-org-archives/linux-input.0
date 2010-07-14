From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: switch to input_abs_*() access functions
Date: Wed, 14 Jul 2010 01:09:39 -0700
Message-ID: <20100714080939.GB2712@core.coreip.homeip.net>
References: <1274289757-2723-1-git-send-email-daniel@caiaq.de>
 <1274289757-2723-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39770 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752267Ab0GNIJq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jul 2010 04:09:46 -0400
Content-Disposition: inline
In-Reply-To: <1274289757-2723-4-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Daniel,

On Wed, May 19, 2010 at 07:22:36PM +0200, Daniel Mack wrote:
>  		joydev->corr[i].type = JS_CORR_BROKEN;
> -		joydev->corr[i].prec = dev->absfuzz[j];
> -		joydev->corr[i].coef[0] =
> -			(dev->absmax[j] + dev->absmin[j]) / 2 - dev->absflat[j];
> -		joydev->corr[i].coef[1] =
> -			(dev->absmax[j] + dev->absmin[j]) / 2 + dev->absflat[j];
> +		joydev->corr[i].prec = input_abs_fuzz(dev, j);
> +
> +		t = (input_abs_max(dev, j) + input_abs_min(dev, j)) / 2
> +			- input_abs_flat(dev, j);
> +		joydev->corr[i].coef[0] = t;
> +		joydev->corr[i].coef[1] = t;

FYI: this is not equivalent transformation - note that original code
either added or subtracted flat from the average to get coefficient.

> @@ -128,17 +129,20 @@ static void mousedev_touchpad_event(struct input_dev *dev,
>  				    struct mousedev *mousedev,
>  				    unsigned int code, int value)
>  {
> -	int size, tmp;
>  	enum { FRACTION_DENOM = 128 };
> +	int tmp;
> +
> +	/* use X size for ABS_Y to keep the same scale */
> +	int size = input_abs_max(dev, ABS_X) - input_abs_min(dev, ABS_X);
> +
> +	if (size == 0)
> +		size = 256 * 2;
>  
>  	switch (code) {
>  
>  	case ABS_X:
>  		fx(0) = value;
>  		if (mousedev->touch && mousedev->pkt_count >= 2) {
> -			size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
> -			if (size == 0)
> -				size = 256 * 2;
>  			tmp = ((value - fx(2)) * 256 * FRACTION_DENOM) / size;
>  			tmp += mousedev->frac_dx;
>  			mousedev->packet.dx = tmp / FRACTION_DENOM;
> @@ -150,10 +154,6 @@ static void mousedev_touchpad_event(struct input_dev *dev,
>  	case ABS_Y:
>  		fy(0) = value;
>  		if (mousedev->touch && mousedev->pkt_count >= 2) {
> -			/* use X size to keep the same scale */
> -			size = dev->absmax[ABS_X] - dev->absmin[ABS_X];
> -			if (size == 0)
> -				size = 256 * 2;

The reason we had the repeating code blocks is that we don't do
calculations for events we are not interested in. This especially
important for multitouch devices generating lots of data.

I think I will keep it the way it was.

No need to resubmit, I am working on the patches...

Thanks.

-- 
Dmitry
