From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [2/2] input: wacom - Pass touch resolution to clients through
 input_absinfo
Date: Mon, 24 Jan 2011 15:40:17 +0100
Message-ID: <20110124144017.GA4367@polaris.bitmath.org>
References: <1295825201-12567-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out21.han.skanova.net ([195.67.226.208]:56029 "EHLO
	smtp-out21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751369Ab1AXOpq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Jan 2011 09:45:46 -0500
Content-Disposition: inline
In-Reply-To: <1295825201-12567-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Hi Ping,

> @@ -1228,8 +1228,13 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  	case TABLETPC:
>  		if (features->device_type == BTN_TOOL_DOUBLETAP ||
>  		    features->device_type == BTN_TOOL_TRIPLETAP) {
> -			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
> -			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
> +			/* set touch resolution in points/mm */
> +			res = features->x_phy/100;
> +			input_abs_set_res(input_dev, ABS_X,
> +					    features->x_max/res);

It seems to me the construction above looses precision twice for no
apparent reason. How about instead use "100 * features->x_max /
features->x_phy"? Besides, it is a bit unfortunate that "res" is short
for both result and resolution. Finally, are the physical dimensions
actually presented in 100ths of millimeters?

Thanks,
Henrik
