From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: elan_i2c - remove duplicate ELAN0605 id
Date: Thu, 21 Sep 2017 16:34:34 -0700
Message-ID: <20170921233434.GD15858@dtor-ws>
References: <20170916215930.9539-1-nikolas@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34680 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbdIUXeh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 21 Sep 2017 19:34:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id u18so4224401pgo.1
        for <linux-input@vger.kernel.org>; Thu, 21 Sep 2017 16:34:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170916215930.9539-1-nikolas@gnu.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nik Nyby <nikolas@gnu.org>
Cc: linux-input@vger.kernel.org

On Sat, Sep 16, 2017 at 05:59:30PM -0400, Nik Nyby wrote:
> ELAN0605 appears twice here.
> 
> Signed-off-by: Nik Nyby <nikolas@gnu.org>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 0e761d079dc4..a2d2077303cb 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1255,7 +1255,6 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0602", 0 },
>  	{ "ELAN0605", 0 },
>  	{ "ELAN0608", 0 },
> -	{ "ELAN0605", 0 },
>  	{ "ELAN0609", 0 },
>  	{ "ELAN060B", 0 },
>  	{ "ELAN1000", 0 },
> -- 
> 2.14.1
> 

-- 
Dmitry
