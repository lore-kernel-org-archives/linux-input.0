From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: mcs5000 - Add MCS5000 touchkey support
Date: Thu, 20 May 2010 00:06:55 -0700
Message-ID: <20100520070655.GA8080@core.coreip.homeip.net>
References: <4BF4DA4D.1090407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42878 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0ETHHD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 03:07:03 -0400
Received: by pva18 with SMTP id 18so1378533pva.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 00:07:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BF4DA4D.1090407@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: riverful.kim@samsung.com, kyungmin.park@samsung.com, linux-input@vger.kernel.org

Hi Joonyoung,

On Thu, May 20, 2010 at 03:44:29PM +0900, Joonyoung Shim wrote:
> The MELPAS MCS5000 can use to touchkey controller. This is patch to
> support touchkey at original MCS5000 touchscreen driver.
> 

Not much of the touchscreen code ends up being reused it seems. Would
not creating a separate keypad driver make more sense?

Also, please amke sure that driver allows remapping the keymap (by
setting keycode, kmeycodemax, keycodesize in input device).

> +
> +	key_val = val & 0x7f;
> +	pressed = val >> 7;
> +
> +	if (pressed) {
> +		for (i = 0; i < pdata->keymap_size; i++) {
> +			if (MCS5000_KEY_VAL(pdata->keymap[i]) == key_val) {
> +				key_code = MCS5000_KEY_CODE(pdata->keymap[i]);
> +				data->key_code = key_code;
> +				break;
> +			}
> +		}
> +	} else
> +		key_code = data->key_code;

Does that mean that controller does not report code of released key?
And we can't have several keys being pressed at once?

> +
> +	input_report_key(input, key_code, pressed ? 1 : 0);
> +	input_sync(input);

Please also report EV_MSC/MSC_SCAN.

Thanks.

-- 
Dmitry
