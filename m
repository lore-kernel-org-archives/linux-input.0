From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: touchscreen: s3c2410: Add ABS_PRESSURE event
 sending.
Date: Tue, 9 Nov 2010 07:54:55 -0800
Message-ID: <20101109155455.GA3682@core.coreip.homeip.net>
References: <1289307616-10336-1-git-send-email-marek.belisko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37105 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab0KIPzL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Nov 2010 10:55:11 -0500
Content-Disposition: inline
In-Reply-To: <1289307616-10336-1-git-send-email-marek.belisko@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Belisko <marek.belisko@gmail.com>
Cc: Vincent Sanders <support@simtec.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 09, 2010 at 02:00:16PM +0100, Marek Belisko wrote:
> This patch add sending of event ABS_PRESSURE for
> s3c24xx touchscreen.
> 
> Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
> ---
>  drivers/input/touchscreen/s3c2410_ts.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
> index 8feb7f3..a937105 100644
> --- a/drivers/input/touchscreen/s3c2410_ts.c
> +++ b/drivers/input/touchscreen/s3c2410_ts.c
> @@ -126,6 +126,7 @@ static void touch_timer_fire(unsigned long data)
>  			input_report_abs(ts.input, ABS_Y, ts.yp);
>  
>  			input_report_key(ts.input, BTN_TOUCH, 1);
> +			input_report_abs(ts.input, ABS_PRESSURE, 1);

No, if device does not provide true pressure readings it should not send
ABS_PRESSURE events. Please fix your userspace.

Thanks.

-- 
Dmitry
