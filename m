From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 06/12] Input: synaptics - fuzz position if touchpad reports
 reduced filtering
Date: Tue, 05 Jul 2011 10:49:59 -0700
Message-ID: <4E134EC7.7050001@canonical.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org> <1309324042-22943-7-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309324042-22943-7-git-send-email-djkurtz@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
> 
> Synaptics touchpads indicate via a capability bit when they perform
> reduced filtering on position data.
> In such a case, use a non-zero fuzz value.
> Fuzz = 8 was chosen empirically by observing the raw position data
> reported by a clickpad indicating it had reduced filtering.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Seems reasonable to me.

Acked-by: Chase Douglas <chase.douglas@canonical.com>

> ---
>  drivers/input/mouse/synaptics.c |   17 ++++++++++-------
>  drivers/input/mouse/synaptics.h |    3 +++
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 74b1222..dc54675 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -687,23 +687,27 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
>  static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
>  {
>  	int i;
> +	int fuzz = 0;
>  
>  	__set_bit(INPUT_PROP_POINTER, dev->propbit);
>  
> +	if (SYN_CAP_REDUCED_FILTERING(priv->ext_cap_0c))
> +		fuzz = SYN_REDUCED_FILTER_FUZZ;
> +
>  	__set_bit(EV_ABS, dev->evbit);
> -	input_set_abs_params(dev, ABS_X,
> -			     XMIN_NOMINAL, priv->x_max ?: XMAX_NOMINAL, 0, 0);
> -	input_set_abs_params(dev, ABS_Y,
> -			     YMIN_NOMINAL, priv->y_max ?: YMAX_NOMINAL, 0, 0);
> +	input_set_abs_params(dev, ABS_X, XMIN_NOMINAL,
> +			     priv->x_max ?: XMAX_NOMINAL, fuzz, 0);
> +	input_set_abs_params(dev, ABS_Y, YMIN_NOMINAL,
> +			     priv->y_max ?: YMAX_NOMINAL, fuzz, 0);
>  	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
>  
>  	if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
>  		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
>  		input_mt_init_slots(dev, 2);
>  		input_set_abs_params(dev, ABS_MT_POSITION_X, XMIN_NOMINAL,
> -				     priv->x_max ?: XMAX_NOMINAL, 0, 0);
> +				     priv->x_max ?: XMAX_NOMINAL, fuzz, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y, YMIN_NOMINAL,
> -				     priv->y_max ?: YMAX_NOMINAL, 0, 0);
> +				     priv->y_max ?: YMAX_NOMINAL, fuzz, 0);
>  
>  		input_abs_set_res(dev, ABS_MT_POSITION_X, priv->x_res);
>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, priv->y_res);
> @@ -977,4 +981,3 @@ bool synaptics_supported(void)
>  }
>  
>  #endif /* CONFIG_MOUSE_PS2_SYNAPTICS */
> -
> diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
> index 34bedde..8a68e66 100644
> --- a/drivers/input/mouse/synaptics.h
> +++ b/drivers/input/mouse/synaptics.h
> @@ -110,6 +110,9 @@
>  #define SYN_NEWABS_RELAXED		2
>  #define SYN_OLDABS			3
>  
> +/* amount to fuzz position data when touchpad reports reduced filtering */
> +#define SYN_REDUCED_FILTER_FUZZ		8
> +
>  /*
>   * A structure to describe the state of the touchpad hardware (buttons and pad)
>   */
