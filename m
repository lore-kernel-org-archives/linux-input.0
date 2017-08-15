From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sensor: constify platform_device_id
Date: Tue, 15 Aug 2017 11:01:20 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708151100350.30597@cbobk.fhfr.pm>
References: <2ae0f9137a673466f09a9d5169c9ef13bbe66a30.1502617403.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2ae0f9137a673466f09a9d5169c9ef13bbe66a30.1502617403.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jic23@kernel.org, srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 13 Aug 2017, Arvind Yadav wrote:

> platform_device_id are not supposed to change at runtime. All functions
> working with platform_device_id provided by <linux/platform_device.h>
> work with const platform_device_id. So mark the non-const structs as
> const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 3a84aaf..5ad39fd 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -823,7 +823,7 @@ static int hid_sensor_custom_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_device_id hid_sensor_custom_ids[] = {
> +static const struct platform_device_id hid_sensor_custom_ids[] = {
>  	{
>  		.name = "HID-SENSOR-2000e1",
>  	},

Applied to for-4.14/ish.

-- 
Jiri Kosina
SUSE Labs
