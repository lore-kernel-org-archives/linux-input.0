From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Skip matrix size check
Date: Fri, 4 Feb 2011 00:59:06 -0800
Message-ID: <20110204085906.GF13046@core.coreip.homeip.net>
References: <4D3DAE3C.6060806@atmel.com>
 <20110124170756.GB31066@core.coreip.homeip.net>
 <4D3EA7DD.6000601@atmel.com>
 <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com>
 <20110203074318.GA5814@core.coreip.homeip.net>
 <4D4AB605.4080106@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:63044 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1BDI7N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Feb 2011 03:59:13 -0500
Received: by pva4 with SMTP id 4so367907pva.19
        for <linux-input@vger.kernel.org>; Fri, 04 Feb 2011 00:59:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D4AB605.4080106@atmel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Iiro Valkonen <iiro.valkonen@atmel.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

On Thu, Feb 03, 2011 at 04:04:53PM +0200, Iiro Valkonen wrote:
> Input: qt602240_ts - Skip matrix size check
> 
> From: Iiro Valkonen <iiro.valkonen@atmel.com>
> 
> Skip the mxt224-specific matrix size check
> 
> Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
> ---
>  drivers/input/touchscreen/qt602240_ts.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
> index 6ef8290..a88ec93 100644
> --- a/drivers/input/touchscreen/qt602240_ts.c
> +++ b/drivers/input/touchscreen/qt602240_ts.c
> @@ -862,10 +862,17 @@ static int mxt_initialize(struct mxt_data *data)
>  	if (error)
>  		return error;
>  
> +      /*
> +       * Skip this and trust what's on the chip, as the current check
> +       * is not compatible with mXT1386. Revisit and fix.
> +       */
>  	/* Check X/Y matrix size */
> +
> +	/*
>  	error = mxt_check_matrix_size(data);
>  	if (error)
>  		return error;
> +	*/

No, this is not really acceptable for mainline... Please revisit now ;)

Thanks.

-- 
Dmitry
