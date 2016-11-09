From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: melfas_mip4 - add product ID reporting
Date: Tue, 8 Nov 2016 16:24:40 -0800
Message-ID: <20161109002440.GE8719@dtor-ws>
References: <1477990392-7606-1-git-send-email-jeesw@melfas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35506 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbcKIAYn (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 19:24:43 -0500
Received: by mail-pf0-f196.google.com with SMTP id i88so21286891pfk.2
        for <linux-input@vger.kernel.org>; Tue, 08 Nov 2016 16:24:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1477990392-7606-1-git-send-email-jeesw@melfas.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sangwon Jee <jeesw@melfas.com>
Cc: linux-input@vger.kernel.org

On Tue, Nov 01, 2016 at 05:53:12PM +0900, Sangwon Jee wrote:
> Add reporting product ID through input_id.
> 
> Signed-off-by: Sangwon Jee <jeesw@melfas.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/melfas_mip4.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/melfas_mip4.c b/drivers/input/touchscreen/melfas_mip4.c
> index 0f2230a..f160390 100644
> --- a/drivers/input/touchscreen/melfas_mip4.c
> +++ b/drivers/input/touchscreen/melfas_mip4.c
> @@ -1477,6 +1477,7 @@ static int mip4_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	input->id.bustype = BUS_I2C;
>  	input->id.vendor = 0x13c5;
> +	input->id.product = ts->product_id;
>  
>  	input->open = mip4_input_open;
>  	input->close = mip4_input_close;
> @@ -1614,6 +1615,6 @@ static struct i2c_driver mip4_driver = {
>  module_i2c_driver(mip4_driver);
>  
>  MODULE_DESCRIPTION("MELFAS MIP4 Touchscreen");
> -MODULE_VERSION("2016.10.24");
> +MODULE_VERSION("2016.10.31");
>  MODULE_AUTHOR("Sangwon Jee <jeesw@melfas.com>");
>  MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 

-- 
Dmitry
