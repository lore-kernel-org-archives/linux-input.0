From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH 04/12] Input: synaptics - set resolution for MT_POSITION_X/Y
 axes
Date: Tue, 05 Jul 2011 10:44:52 -0700
Message-ID: <4E134D94.60604@canonical.com>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org> <1309324042-22943-5-git-send-email-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:39561 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1GERo6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 13:44:58 -0400
In-Reply-To: <1309324042-22943-5-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: djkurtz@chromium.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

On 06/28/2011 10:07 PM, djkurtz@chromium.org wrote:
> From: Daniel Kurtz <djkurtz@chromium.org>
> 
> Set resolution for MT_POSITION_X and MT_POSITION_Y to match ABS_X and
> ABS_Y, respectively.
> 
> Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>

Acked-by: Chase Douglas <chase.douglas@canonical.com>

> ---
>  drivers/input/mouse/synaptics.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index a4b7801..1ce47b7 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -703,6 +703,9 @@ static void set_input_params(struct input_dev *dev, struct synaptics_data *priv)
>  				     priv->x_max ?: XMAX_NOMINAL, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y, YMIN_NOMINAL,
>  				     priv->y_max ?: YMAX_NOMINAL, 0, 0);
> +
> +		input_abs_set_res(dev, ABS_MT_POSITION_X, priv->x_res);
> +		input_abs_set_res(dev, ABS_MT_POSITION_Y, priv->y_res);
>  	}
>  
>  	if (SYN_CAP_PALMDETECT(priv->capabilities))

