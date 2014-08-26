From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: misc: drv260x remove defines not used
Date: Tue, 26 Aug 2014 15:46:04 -0700
Message-ID: <20140826224604.GC8377@core.coreip.homeip.net>
References: <1408716675-1093-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33245 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755673AbaHZWqI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Aug 2014 18:46:08 -0400
Content-Disposition: inline
In-Reply-To: <1408716675-1093-1-git-send-email-dmurphy@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Aug 22, 2014 at 09:11:15AM -0500, Dan Murphy wrote:
> Removing some #defines that are not and should
> never be used pertaining to I2C.
> 
> Removing:
> define DRV260X_ALLOWED_R_BYTES	25
> define DRV260X_ALLOWED_W_BYTES	2
> define DRV260X_MAX_RW_RETRIES	5
> define DRV260X_I2C_RETRY_DELAY 10
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied, thank you.

> ---
>  drivers/input/misc/drv260x.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index e90e3b8..a7a19e6 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -66,11 +66,6 @@
>  #define DRV260X_LRA_RES_PERIOD	0x22
>  #define DRV260X_MAX_REG			0x23
>  
> -#define DRV260X_ALLOWED_R_BYTES	25
> -#define DRV260X_ALLOWED_W_BYTES	2
> -#define DRV260X_MAX_RW_RETRIES	5
> -#define DRV260X_I2C_RETRY_DELAY 10
> -
>  #define DRV260X_GO_BIT				0x01
>  
>  /* Library Selection */
> -- 
> 1.7.9.5
> 

-- 
Dmitry
