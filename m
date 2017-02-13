From: IHARA Hiroka <ihara_h@live.jp>
Subject: Re: [PATCH] Input: elan_i2c: add ELAN0605 to the ACPI table
Date: Mon, 13 Feb 2017 02:05:20 +0000
Message-ID: <PS1PR0401MB19610C71530ABC7E1AA75D099C590@PS1PR0401MB1961.apcprd04.prod.outlook.com>
References: <PS1PR0401MB1961607122C29ADFF8F54A539C460@PS1PR0401MB1961.apcprd04.prod.outlook.com>,<20170212224230.GB15928@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bay004-omc1s10.hotmail.com ([65.54.190.21]:58913 "EHLO
        BAY004-OMC1S10.hotmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751346AbdBMCKe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 12 Feb 2017 21:10:34 -0500
In-Reply-To: <20170212224230.GB15928@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Dear Dmitry,

I am sorry I did not supply that information.
There is currently only one laptop reported to contain the device, that is Lenovo ideapad 310s (80U4000).
ELAN0605 has the same Vendor/Product ID as ELAN0600 (04F3:0400).

My patch has been tested on this device.
 --
Hiroka

From: dmitry.torokhov@gmail.com <dmitry.torokhov@gmail.com>
Sent: Monday, February 13, 2017 7:42
To: IHARA Hiroka
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: elan_i2c: add ELAN0605 to the ACPI table
    
Hi Hiroka,

On Sun, Feb 12, 2017 at 07:55:23AM +0000, IHARA Hiroka wrote:
> ELAN0605 has been confirmed to be a variant of ELAN0600,
> which is blacklisted in the hid-core to be managed by elan_i2c.

Would you mind telling me what device(s) use ELAN0605?

Thanks!

> 
> Signed-off-by: Hiroka IHARA <ihara_h@live.jp>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fa598f7..1e1d0ad 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1231,6 +1231,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>        { "ELAN0000", 0 },
>        { "ELAN0100", 0 },
>        { "ELAN0600", 0 },
> +     { "ELAN0605", 0 },
>        { "ELAN1000", 0 },
>        { }
>  };
> -- 
> 2.9.3
> 

-- 
Dmitry
    