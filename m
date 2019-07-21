From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: applespi: fix warnings detected by sparse
Date: Sun, 21 Jul 2019 15:27:54 +0300
Message-ID: <20190721122754.GA757@penguin>
References: <20190721081040.26197-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190721081040.26197-1-ronald@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc: Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
List-Id: linux-input@vger.kernel.org

On Sun, Jul 21, 2019 at 01:10:40AM -0700, Ronald Tschalär wrote:
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>

Applied, thank you.

> ---
> Changes in v2:
>   replaced min_t/max_t with plain min/max since both arguments are now
>   int's and don't need further casting
> 
>  drivers/input/keyboard/applespi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index d5defdefbc34..cd140a92e731 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -998,10 +998,14 @@ static inline int le16_to_int(__le16 x)
>  static void applespi_debug_update_dimensions(struct applespi_data *applespi,
>  					     const struct tp_finger *f)
>  {
> -	applespi->tp_dim_min_x = min_t(int, applespi->tp_dim_min_x, f->abs_x);
> -	applespi->tp_dim_max_x = max_t(int, applespi->tp_dim_max_x, f->abs_x);
> -	applespi->tp_dim_min_y = min_t(int, applespi->tp_dim_min_y, f->abs_y);
> -	applespi->tp_dim_max_y = max_t(int, applespi->tp_dim_max_y, f->abs_y);
> +	applespi->tp_dim_min_x = min(applespi->tp_dim_min_x,
> +				     le16_to_int(f->abs_x));
> +	applespi->tp_dim_max_x = max(applespi->tp_dim_max_x,
> +				     le16_to_int(f->abs_x));
> +	applespi->tp_dim_min_y = min(applespi->tp_dim_min_y,
> +				     le16_to_int(f->abs_y));
> +	applespi->tp_dim_max_y = max(applespi->tp_dim_max_y,
> +				     le16_to_int(f->abs_y));
>  }
>  
>  static int applespi_tp_dim_open(struct inode *inode, struct file *file)
> @@ -1653,8 +1657,8 @@ static void applespi_save_bl_level(struct applespi_data *applespi,
>  	efi_attr = EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
>  		   EFI_VARIABLE_RUNTIME_ACCESS;
>  
> -	sts = efivar_entry_set_safe(EFI_BL_LEVEL_NAME, efi_guid, efi_attr, true,
> -				    efi_data_len, &efi_data);
> +	sts = efivar_entry_set_safe((efi_char16_t *)EFI_BL_LEVEL_NAME, efi_guid,
> +				    efi_attr, true, efi_data_len, &efi_data);
>  	if (sts)
>  		dev_warn(&applespi->spi->dev,
>  			 "Error saving backlight level to EFI vars: %d\n", sts);
> @@ -2027,7 +2031,7 @@ static const struct acpi_device_id applespi_acpi_match[] = {
>  };
>  MODULE_DEVICE_TABLE(acpi, applespi_acpi_match);
>  
> -const struct dev_pm_ops applespi_pm_ops = {
> +static const struct dev_pm_ops applespi_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(applespi_suspend, applespi_resume)
>  	.poweroff_late	= applespi_poweroff_late,
>  };
> -- 
> 2.21.0
> 

-- 
Dmitry
