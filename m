From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621
 touchpad.
Date: Thu, 29 Nov 2018 10:06:27 -0800
Message-ID: <20181129180627.GA54791@dtor-ws>
References: <20181129173824.7980-1-adam@adamwong.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181129173824.7980-1-adam@adamwong.me>
Sender: linux-kernel-owner@vger.kernel.org
To: adam@adamwong.me
Cc: benjamin.tissoires@redhat.com, kt.liao@emc.com.tw, dshanty@protonmail.com, robh@kernel.org, jackxviichaos@gmail.com, ben.hutchings@codethink.co.uk, gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 29, 2018 at 12:38:24PM -0500, adam@adamwong.me wrote:
> From: Adam Wong <adam@adamwong.me>
> 
> Added the ability to detect the ELAN0621 touchpad found in some Lenovo
> laptops.
> 
> Signed-off-by: Adam Wong <adam@adamwong.me>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index b0f9d19b3410..a84362d0c99d 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1348,6 +1348,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0618", 0 },
>  	{ "ELAN061C", 0 },
>  	{ "ELAN061D", 0 },
> +	{ "ELAN0621", 0 },
>  	{ "ELAN0622", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
> -- 
> 2.17.1
> 

-- 
Dmitry
