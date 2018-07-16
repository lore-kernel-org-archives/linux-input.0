From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Add antoher ACPI ID for Lenovo Ideapad
 330-15AST
Date: Mon, 16 Jul 2018 12:20:05 +0000
Message-ID: <20180716122005.5c5p3sitbfilt4hs@penguin>
References: <1531740389-4040-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531740389-4040-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ulrik.debie-os@e2big.org, anantshende@gmail.com
List-Id: linux-input@vger.kernel.org

On Mon, Jul 16, 2018 at 07:26:29PM +0800, KT Liao wrote:
> Add ELAN0622 in ACPI mapping table to support Ideapad 330-15AST ELAN touchpad
> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> Reported-by: Anant Shende <anantshende@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 2690a4b..f7e75f0 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1344,6 +1344,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN060B", 0 },
>  	{ "ELAN060C", 0 },
>  	{ "ELAN0611", 0 },
> +	{ "ELAN0622", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };
> -- 
> 2.7.4
> 

-- 
Dmitry
