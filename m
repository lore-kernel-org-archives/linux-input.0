From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] Input: pxa27x_keypad - remove an unneeded NULL check
Date: Wed, 11 Feb 2015 09:36:34 -0800
Message-ID: <20150211173634.GA29440@dtor-ws>
References: <20150211102802.GD18515@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37123 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbbBKRgj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2015 12:36:39 -0500
Content-Disposition: inline
In-Reply-To: <20150211102802.GD18515@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Chao Xie <chao.xie@marvell.com>, Rob Herring <robh@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Pramod Gurav <pramod.gurav@smartplayin.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Feb 11, 2015 at 01:28:02PM +0300, Dan Carpenter wrote:
> Static checkers complain about this NULL check because we dereference it
> without checking a couple lines later.  This function is only called
> when "keypad->pdata" is non-NULL so we can just delete the NULL test.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied in a modified form - removed the temp altogether.

> 
> diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
> index a89488a..385abf8 100644
> --- a/drivers/input/keyboard/pxa27x_keypad.c
> +++ b/drivers/input/keyboard/pxa27x_keypad.c
> @@ -346,7 +346,7 @@ static int pxa27x_keypad_build_keycode(struct pxa27x_keypad *keypad)
>  	const struct pxa27x_keypad_platform_data *pdata = keypad->pdata;
>  	struct input_dev *input_dev = keypad->input_dev;
>  	const struct matrix_keymap_data *keymap_data =
> -				pdata ? pdata->matrix_keymap_data : NULL;
> +						pdata->matrix_keymap_data;
>  	unsigned short keycode;
>  	int i;
>  	int error;

Thanks.

-- 
Dmitry
