From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input/mouse: elan_i2c_core: Add ELAN061E ID
Date: Mon, 3 Dec 2018 11:28:54 -0800
Message-ID: <20181203192854.GE257010@dtor-ws>
References: <20181118165901.31689-1-harsh@prjkt.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181118165901.31689-1-harsh@prjkt.io>
Sender: stable-owner@vger.kernel.org
To: Harsh Shandilya <harsh@prjkt.io>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Harsh,

On Sun, Nov 18, 2018 at 10:29:01PM +0530, Harsh Shandilya wrote:
> Trackpad found in the Lenovo IdeaPad 330-15ARR U SKU
> 
> Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
> Cc: stable@vger.kernel.org

Sorry, I noticed similar patch by Noah Westervelt first.

> ---
>  drivers/input/mouse/elan_i2c_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index fb8806c1a39a..5a27944fb8de 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1371,6 +1371,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0618", 0 },
>  	{ "ELAN061C", 0 },
>  	{ "ELAN061D", 0 },
> +	{ "ELAN061E", 0 },
>  	{ "ELAN0622", 0 },
>  	{ "ELAN1000", 0 },
>  	{ }
> -- 
> 2.20.0.rc0
> 

-- 
Dmitry
