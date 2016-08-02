From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0290/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 10:27:56 -0700
Message-ID: <20160802172756.GA5012@dtor-ws>
References: <20160802105711.703-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160802105711.703-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, haibo.chen@freescale.com, andrey.gelman@compulab.co.il, broonie@kernel.org, afd@ti.com, javier@osg.samsung.com, chuansheng.liu@intel.com
List-Id: linux-input@vger.kernel.org

On Tue, Aug 02, 2016 at 06:57:11PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/input/touchscreen/ads7846.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index a61b215..0f882cb 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -591,7 +591,7 @@ static ssize_t ads7846_disable_store(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(disable, 0664, ads7846_disable_show, ads7846_disable_store);
> +static DEVICE_ATTR(disable, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH, ads7846_disable_show, ads7846_disable_store);

No, this does not improve neither robustness nor readability.

Thanks.

-- 
Dmitry
