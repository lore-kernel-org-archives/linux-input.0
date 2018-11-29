From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad
 330-15ARR
Date: Thu, 29 Nov 2018 10:29:10 -0800
Message-ID: <20181129182910.GC54791@dtor-ws>
References: <SN1PR0601MB1965466215E6FD2D9A54515EBBD70@SN1PR0601MB1965.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <SN1PR0601MB1965466215E6FD2D9A54515EBBD70@SN1PR0601MB1965.namprd06.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Noah Westervelt <nwestervelt@outlook.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Noah,

On Mon, Nov 26, 2018 at 10:52:16PM +0000, Noah Westervelt wrote:
> Add ELAN061E to the ACPI table to support Elan touchpad found in Lenovo
> IdeaPad 330-15ARR.
> 
> Signed-off-by: Noah Westervelt <nwestervelt@outlook.com><mailto:nwestervelt@outlook.com>
> Cc: stable@vger.kernel.org<mailto:stable@vger.kernel.org>

I untangled it from HTML/attacjment mess that outlook made and applied,
but please next time use git-send-email for patches: it allows out
scripts to pick up patches more easily.

Thanks!

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)

> --- /home/noah/input/drivers/input/mouse/elan_i2c_core.c.orig	2018-11-26 16:23:39.378342074 -0600
> +++ /home/noah/input/drivers/input/mouse/elan_i2c_core.c	2018-11-26 16:26:20.283458731 -0600
> @@ -1344,6 +1344,7 @@ static const struct acpi_device_id elan_
>  	{ "ELAN060B", 0 },
>  	{ "ELAN060C", 0 },
>  	{ "ELAN0611", 0 },
> +	{ "ELAN061E", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
>  };


-- 
Dmitry
