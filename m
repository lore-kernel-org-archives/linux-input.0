From: Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v3 2/2] input: rotary encoder: Add wake up support
Date: Fri, 13 Feb 2015 11:43:17 +0800
Message-ID: <20150213034317.GB1924@localhost>
References: <1423755638-9294-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423755638-9294-3-git-send-email-sylvain.rochet@finsecur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:63337 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbBMDlY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Feb 2015 22:41:24 -0500
Received: by mail-pa0-f48.google.com with SMTP id eu11so15929287pac.7
        for <linux-input@vger.kernel.org>; Thu, 12 Feb 2015 19:41:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1423755638-9294-3-git-send-email-sylvain.rochet@finsecur.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Johan Hovold <jhovold@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Thu, Feb 12, 2015 at 04:40:38PM +0100, Sylvain Rochet wrote:
> This patch adds wake up support for rotary encoders.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> ---
>  Documentation/input/rotary-encoder.txt |  1 +
>  drivers/input/misc/rotary_encoder.c    | 37 ++++++++++++++++++++++++++++++++++
>  include/linux/rotary_encoder.h         |  1 +
>  3 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
> index 92e68bc..ed158d3 100644
> --- a/Documentation/input/rotary-encoder.txt
> +++ b/Documentation/input/rotary-encoder.txt
> @@ -109,6 +109,7 @@ static struct rotary_encoder_platform_data my_rotary_encoder_info = {
>  	.inverted_a	= 0,
>  	.inverted_b	= 0,
>  	.half_period	= false,
> +	.wakeup_source	= false,
>  };

This should have been part of PATCH 1/2 as well.

Johan
