From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0218/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:22:33 +0200
Message-ID: <20160802122233.GB23544@kroah.com>
References: <20160802105039.28287-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160802105039.28287-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, thellstrom@vmware.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, alexander.deucher@amd.com, ville.syrjala@linux.intel.com
List-Id: linux-input@vger.kernel.org

On Tue, Aug 02, 2016 at 06:50:39PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/hid/hid-corsair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
> index 717704e..5353847 100644
> --- a/drivers/hid/hid-corsair.c
> +++ b/drivers/hid/hid-corsair.c
> @@ -370,8 +370,8 @@ static ssize_t k90_store_current_profile(struct device *dev,
>  	return count;
>  }
>  
> -static DEVICE_ATTR(macro_mode, 0644, k90_show_macro_mode, k90_store_macro_mode);
> -static DEVICE_ATTR(current_profile, 0644, k90_show_current_profile,
> +static DEVICE_ATTR(macro_mode, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, k90_show_macro_mode, k90_store_macro_mode);
> +static DEVICE_ATTR(current_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, k90_show_current_profile,
>  		   k90_store_current_profile);

DEVICE_ATTR_RW() please.
