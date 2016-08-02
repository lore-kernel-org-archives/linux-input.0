From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0293/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 10:34:11 -0700
Message-ID: <20160802173411.GB5012@dtor-ws>
References: <20160802105731.907-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160802105731.907-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org, standby24x7@gmail.com, jkosina@suse.com, chuansheng.liu@intel.com
List-Id: linux-input@vger.kernel.org

On Tue, Aug 02, 2016 at 06:57:31PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/input/touchscreen/ili210x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
> index ddf694b..a8a7089 100644
> --- a/drivers/input/touchscreen/ili210x.c
> +++ b/drivers/input/touchscreen/ili210x.c
> @@ -169,7 +169,7 @@ static ssize_t ili210x_calibrate(struct device *dev,
>  
>  	return count;
>  }
> -static DEVICE_ATTR(calibrate, 0644, NULL, ili210x_calibrate);
> +static DEVICE_ATTR(calibrate, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, NULL, ili210x_calibrate);

Here was a bug in the driver that you helpfully carried over. Since we
do not provide "show" method the permissions should be 0200 or S_IWUSR).

Thanks.

-- 
Dmitry
