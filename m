From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0228/1285] Replace numeric parameter like 0444 with macro
Date: Tue, 2 Aug 2016 14:23:08 +0200
Message-ID: <20160802122308.GC23544@kroah.com>
References: <20160802105126.28947-1-baolex.ni@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160802105126.28947-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baole Ni <baolex.ni@intel.com>
Cc: erazor_de@users.sourceforge.net, jikos@kernel.org, benjamin.tissoires@redhat.com, airlied@linux.ie, kgene@kernel.org, k.kozlowski@samsung.com, dougthompson@xmission.com, bp@alien8.de, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, alexander.deucher@amd.com, ville.syrjala@linux.intel.com
List-Id: linux-input@vger.kernel.org

On Tue, Aug 02, 2016 at 06:51:26PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.
> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/hid/hid-roccat-koneplus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-roccat-koneplus.c b/drivers/hid/hid-roccat-koneplus.c
> index 09e8fc7..4ce8c6d 100644
> --- a/drivers/hid/hid-roccat-koneplus.c
> +++ b/drivers/hid/hid-roccat-koneplus.c
> @@ -291,10 +291,10 @@ static ssize_t koneplus_sysfs_set_actual_profile(struct device *dev,
>  
>  	return size;
>  }
> -static DEVICE_ATTR(actual_profile, 0660,
> +static DEVICE_ATTR(actual_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
>  		   koneplus_sysfs_show_actual_profile,
>  		   koneplus_sysfs_set_actual_profile);
> -static DEVICE_ATTR(startup_profile, 0660,
> +static DEVICE_ATTR(startup_profile, S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
>  		   koneplus_sysfs_show_actual_profile,
>  		   koneplus_sysfs_set_actual_profile);
>  
> @@ -316,7 +316,7 @@ static ssize_t koneplus_sysfs_show_firmware_version(struct device *dev,
>  
>  	return snprintf(buf, PAGE_SIZE, "%d\n", info.firmware_version);
>  }
> -static DEVICE_ATTR(firmware_version, 0440,
> +static DEVICE_ATTR(firmware_version, S_IRUSR | S_IRGRP,
>  		   koneplus_sysfs_show_firmware_version, NULL);

DEVICE_ATTR_RO or DEVICE_ATTR_RW as needed please.
