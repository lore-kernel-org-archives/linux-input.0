From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 2/3] input: appletouch: implement sensor data smoothing
Date: Thu, 27 Mar 2014 11:26:06 -0700
Message-ID: <20140327182606.GA8902@core.coreip.homeip.net>
References: <52D9DE7A.7040509@gmail.com>
 <5320EA03.2040206@gmail.com>
 <5320EAC5.5000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:37368 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755798AbaC0S0L (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Mar 2014 14:26:11 -0400
Received: by mail-pa0-f54.google.com with SMTP id lf10so3883541pab.27
        for <linux-input@vger.kernel.org>; Thu, 27 Mar 2014 11:26:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5320EAC5.5000506@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clinton Sprain <clintonsprain@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

Hi Clinton,

On Wed, Mar 12, 2014 at 06:16:21PM -0500, Clinton Sprain wrote:
> input: appletouch: implement sensor data smoothing
> 
> Use smoothed version of sensor array data to calculate movement and add weight
> to prior values when calculating average. This gives more granular and more
> predictable movement.
> 
> Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
> ---
>  drivers/input/mouse/appletouch.c |   72 ++++++++++++++++++++++++++++----------
>  1 file changed, 53 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index 2745832..e00f126 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -332,7 +332,11 @@ static void atp_reinit(struct work_struct *work)
>  static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>  			     int *z, int *fingers)
>  {
> -	int i;
> +	int i, k;
> +	int smooth[nb_sensors + 8];
> +	int smooth_tmp[nb_sensors + 8];

This unfortunately introduces variable-length arraus on stack which
makes sparse unhappy. Can we add these scratch buffers to the device
structure instead?

> +	int scale = 12;

Probably better use a define rather than a variable.

> +
>  	/* values to calculate mean */
>  	int pcum = 0, psum = 0;
>  	int is_increasing = 0;
> @@ -344,9 +348,6 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>  			if (is_increasing)
>  				is_increasing = 0;
>  
> -			continue;
> -		}
> -
>  		/*
>  		 * Makes the finger detection more versatile.  For example,
>  		 * two fingers with no gap will be detected.  Also, my
> @@ -361,27 +362,60 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
>  		 *
>  		 * - Jason Parekh <jasonparekh@gmail.com>
>  		 */
> -		if (i < 1 ||
> +
> +		} else if (i < 1 ||
>  		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
>  			(*fingers)++;
>  			is_increasing = 1;
>  		} else if (i > 0 && (xy_sensors[i - 1] - xy_sensors[i] > threshold)) {
>  			is_increasing = 0;
>  		}
> +	}
>  
> -		/*
> -		 * Subtracts threshold so a high sensor that just passes the
> -		 * threshold won't skew the calculated absolute coordinate.
> -		 * Fixes an issue where slowly moving the mouse would
> -		 * occasionally jump a number of pixels (slowly moving the
> -		 * finger makes this issue most apparent.)
> -		 */
> -		pcum += (xy_sensors[i] - threshold) * i;
> -		psum += (xy_sensors[i] - threshold);
> +	/*
> +	 * Use a smoothed version of sensor data for movement calculations, to
> +	 * combat noise without needing to rely so heavily on a threshold.
> +	 * This improves tracking.
> +	 *
> +	 * The smoothed array is bigger than the original so that the smoothing
> +	 * doesn't result in edge values being truncated.
> +	 */
> +
> +	for (i = 0; i < 4; i++)
> +		smooth[i] = 0;

memset might be better?

> +	for (i = nb_sensors + 4; i < nb_sensors + 8; i++)
> +		smooth[i] = 0;

And here as well.

Thanks.

-- 
Dmitry
