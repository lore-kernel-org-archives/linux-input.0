From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: da9052_tsi: remove unused mutex
Date: Mon, 22 Jan 2018 09:28:44 -0800
Message-ID: <20180122172844.e3on5yqyw67gbh7u@dtor-ws>
References: <20180122155254.9255-1-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35465 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeAVR2r (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 Jan 2018 12:28:47 -0500
Content-Disposition: inline
In-Reply-To: <20180122155254.9255-1-marcus.folkesson@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 04:52:53PM +0100, Marcus Folkesson wrote:
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/da9052_tsi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
> index 5a013bb7bcad..b5dfd5944cc3 100644
> --- a/drivers/input/touchscreen/da9052_tsi.c
> +++ b/drivers/input/touchscreen/da9052_tsi.c
> @@ -26,7 +26,6 @@ struct da9052_tsi {
>  	struct da9052 *da9052;
>  	struct input_dev *dev;
>  	struct delayed_work ts_pen_work;
> -	struct mutex mutex;
>  	bool stopped;
>  	bool adc_on;
>  };
> -- 
> 2.15.1
> 

-- 
Dmitry
