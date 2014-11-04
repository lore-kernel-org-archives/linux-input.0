From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: stmpe: bias keypad columns properly
Date: Mon, 3 Nov 2014 17:57:21 -0800
Message-ID: <20141104015721.GA21814@dtor-ws>
References: <1413636999-3326-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:65032 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbaKDB50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2014 20:57:26 -0500
Content-Disposition: inline
In-Reply-To: <1413636999-3326-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

On Sat, Oct 18, 2014 at 02:56:39PM +0200, Linus Walleij wrote:
> +	if (variant->set_pullup) {
> +		u8 val;
> +
> +		ret = stmpe_reg_read(stmpe, pureg);
> +		if (ret)
> +			return ret;
> +
> +		/* Do not touch unused pins, may be used for GPIO */
> +		val = ret & ~pu_pins;
> +		val |= pu_pins;
> +
> +		ret = stmpe_reg_write(stmpe, pureg, val);

Don't we need
		if (ret) {
			dev_err(...);
			return ret;
		}

here?

-- 
Dmitry
