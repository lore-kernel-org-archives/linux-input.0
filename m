From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ASUS EeeBook X205TA special
 touchpad fw
Date: Mon, 6 Mar 2017 11:54:42 -0800
Message-ID: <20170306195442.GC30488@dtor-ws>
References: <1488679982-9825-1-git-send-email-matjaz.hegedic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1488679982-9825-1-git-send-email-matjaz.hegedic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matjaz Hegedic <matjaz.hegedic@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sun, Mar 05, 2017 at 03:13:02AM +0100, Matjaz Hegedic wrote:
> EeeBook X205TA is yet another ASUS device with a special touchpad
> firmware that needs to be accounted for during initialization, or
> else the touchpad will go into an invalid state upon suspend/resume.
> Adding the appropriate ic_type and product_id check fixes the problem.

KT, does this look reasonable? Are there more ASUS models that need such
handling?

> 
> Signed-off-by: Matjaz Hegedic <matjaz.hegedic@gmail.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 2c7d287..dde3ad7 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -218,17 +218,19 @@ static int elan_query_product(struct elan_tp_data *data)
>  
>  static int elan_check_ASUS_special_fw(struct elan_tp_data *data)
>  {
> -	if (data->ic_type != 0x0E)
> -		return false;
> -
> -	switch (data->product_id) {
> -	case 0x05 ... 0x07:
> -	case 0x09:
> -	case 0x13:
> -		return true;
> -	default:
> -		return false;
> +	if (data->ic_type == 0x0E) {
> +		switch (data->product_id) {
> +		case 0x05 ... 0x07:
> +		case 0x09:
> +		case 0x13:
> +			return true;
> +		}
>  	}
> +	/* ASUS EeeBook X205TA */
> +	else if (data->ic_type == 0x8 && data->product_id == 0x26)
> +		return true;
> +
> +	return false;
>  }
>  
>  static int __elan_initialize(struct elan_tp_data *data)
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
