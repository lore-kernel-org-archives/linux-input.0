From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hp_sdc_rtc: Fix test in hp_sdc_rtc_read_rt()
Date: Sun, 18 Oct 2009 00:19:33 -0700
Message-ID: <20091018071933.GD3935@core.coreip.homeip.net>
References: <4AD89B77.6070303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64697 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbZJRHTc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 Oct 2009 03:19:32 -0400
Received: by pwj1 with SMTP id 1so432363pwj.21
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2009 00:19:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AD89B77.6070303@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Fri, Oct 16, 2009 at 06:12:39PM +0200, Roel Kluin wrote:
> If left unsigned the hp_sdc_rtc_read_i8042timer() return value will not
> be checked correctly.
> 

Applied, thank you Roel.

> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/input/misc/hp_sdc_rtc.c b/drivers/input/misc/hp_sdc_rtc.c
> index 216a559..ea821b5 100644
> --- a/drivers/input/misc/hp_sdc_rtc.c
> +++ b/drivers/input/misc/hp_sdc_rtc.c
> @@ -209,7 +209,7 @@ static inline int hp_sdc_rtc_read_rt(struct timeval *res) {
>  
>  /* Read the i8042 fast handshake timer */
>  static inline int hp_sdc_rtc_read_fhs(struct timeval *res) {
> -	uint64_t raw;
> +	int64_t raw;
>  	unsigned int tenms;
>  
>  	raw = hp_sdc_rtc_read_i8042timer(HP_SDC_CMD_LOAD_FHS, 2);

-- 
Dmitry
