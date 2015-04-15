From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/5] Input: elan_i2c - Correct the x and y trace number.
Date: Wed, 15 Apr 2015 10:47:52 -0700
Message-ID: <20150415174752.GC27779@dtor-ws>
References: <000401d0771f$4b7f9b90$e27ed2b0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34695 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbDORr5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 13:47:57 -0400
Content-Disposition: inline
In-Reply-To: <000401d0771f$4b7f9b90$e27ed2b0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: DusonLin <dusonlin@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?utf-8?B?J+m7g+S4lum1rCc=?= <phoenix@emc.com.tw>

On Wed, Apr 15, 2015 at 09:55:43AM +0800, DusonLin wrote:
> The trace number does not need to subtract 1 now.

Could you provide a bit more of background for this change? Why don't we
need to decrement the number returned by the firmware anymore? We have
been running with the old numbers for many years...

Thanks!

> 
> Signed-off-by: Duson Lin <dusonlin@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_i2c.c   |    4 ++--
>  drivers/input/mouse/elan_i2c_smbus.c |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_i2c.c
> b/drivers/input/mouse/elan_i2c_i2c.c
> index 029941f..550f905 100644
> --- a/drivers/input/mouse/elan_i2c_i2c.c
> +++ b/drivers/input/mouse/elan_i2c_i2c.c
> @@ -356,8 +356,8 @@ static int elan_i2c_get_num_traces(struct i2c_client
> *client,
>  		return error;
>  	}
>  
> -	*x_traces = val[0] - 1;
> -	*y_traces = val[1] - 1;
> +	*x_traces = val[0];
> +	*y_traces = val[1];
>  
>  	return 0;
>  }
> diff --git a/drivers/input/mouse/elan_i2c_smbus.c
> b/drivers/input/mouse/elan_i2c_smbus.c
> index 06a2bcd..0b04151 100644
> --- a/drivers/input/mouse/elan_i2c_smbus.c
> +++ b/drivers/input/mouse/elan_i2c_smbus.c
> @@ -268,8 +268,8 @@ static int elan_smbus_get_num_traces(struct i2c_client
> *client,
>  		return error;
>  	}
>  
> -	*x_traces = val[1] - 1;
> -	*y_traces = val[2] - 1;
> +	*x_traces = val[1];
> +	*y_traces = val[2];
>  
>  	return 0;
>  }
> 

-- 
Dmitry
