From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: fix cobalt_btns loadable keymaps support
Date: Mon, 11 Feb 2008 11:00:27 -0500
Message-ID: <20080211105835.ZZRA012@mailhub.coreip.homeip.net>
References: <20080211215404.1c924c12.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:24075 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbYBKQAd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2008 11:00:33 -0500
Received: by py-out-1112.google.com with SMTP id u52so6878287pyb.10
        for <linux-input@vger.kernel.org>; Mon, 11 Feb 2008 08:00:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20080211215404.1c924c12.yoichi_yuasa@tripeaks.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc: linux-input@vger.kernel.org

Hi Yoichi,

On Mon, Feb 11, 2008 at 09:54:04PM +0900, Yoichi Yuasa wrote:
> Fix cobalt_btns loadable keymaps support.
> 

Thank you for the patch.

>  	input_set_capability(input, EV_MSC, MSC_SCAN);
>  	__set_bit(EV_KEY, input->evbit);
> -	for (i = 0; i < ARRAY_SIZE(buttons_map); i++)
> -		__set_bit(input->keycode[i], input->keybit);
> +	for (i = 0; i < ARRAY_SIZE(cobalt_map); i++)
> +		__set_bit(bdev->keymap[i], input->keybit);

This part is not strictly necessary since input->keycode points to
bdev->keymap. I will apply the rest of the patch.


-- 
Dmitry
