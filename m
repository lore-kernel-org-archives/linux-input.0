From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Added acpi device id ELAN0611 to support lenovo ideapad
 520 touchpad
Date: Tue, 24 Oct 2017 11:12:18 -0700
Message-ID: <20171024181218.24xoh2jx7oqbfe7g@dtor-ws>
References: <20171021191903.24752-1-idoad123@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:56471 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdJXSMW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 14:12:22 -0400
Content-Disposition: inline
In-Reply-To: <20171021191903.24752-1-idoad123@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ido Adiv <idoad123@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Ido,

On Sat, Oct 21, 2017 at 10:19:03PM +0300, Ido Adiv wrote:
> Signed-off-by: Ido Adiv <idoad123@gmail.com>

Sorry, I already had a patch from Kai-Heng Feng in my queue adding the
same ACPI ID.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 0e761d07..6d6b092e 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1258,6 +1258,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0605", 0 },
>  	{ "ELAN0609", 0 },
>  	{ "ELAN060B", 0 },
> +	{ "ELAN0611", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.14.1
> 

-- 
Dmitry
