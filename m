From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v7 1/8] efi: Export boot-services code and data as
 debugfs-blobs
Date: Mon, 14 Oct 2019 09:11:33 +0000
Message-ID: <20191014091133.GY16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-2-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:49PM +0200, Hans de Goede wrote:
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 8d3e778e988b..abba49c4c46d 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -314,6 +315,55 @@ static __init int efivar_ssdt_load(void)
>  static inline int efivar_ssdt_load(void) { return 0; }
>  #endif
>  
> +#ifdef CONFIG_DEBUG_FS
> +
> +#define EFI_DEBUGFS_MAX_BLOBS 32
> +
> +static struct debugfs_blob_wrapper debugfs_blob[EFI_DEBUGFS_MAX_BLOBS];
> +
> +static void __init efi_debugfs_init(void)
> +{
> +	struct dentry *efi_debugfs;
> +	efi_memory_desc_t *md;
> +	char name[32];
> +	int type_count[EFI_BOOT_SERVICES_DATA + 1] = {};
> +	int i = 0;
> +
> +	efi_debugfs = debugfs_create_dir("efi", NULL);
> +	if (IS_ERR_OR_NULL(efi_debugfs))
> +		return;
> +
> +	for_each_efi_memory_desc(md) {
> +		switch (md->type) {
> +		case EFI_BOOT_SERVICES_CODE:
> +			snprintf(name, sizeof(name), "boot_services_code%d",
> +				 type_count[md->type]++);
> +			break;
> +		case EFI_BOOT_SERVICES_DATA:
> +			snprintf(name, sizeof(name), "boot_services_data%d",
> +				 type_count[md->type]++);
> +			break;
> +		default:
> +			continue;
> +		}
> +
> +		debugfs_blob[i].size = md->num_pages << EFI_PAGE_SHIFT;
> +		debugfs_blob[i].data = memremap(md->phys_addr,
> +						debugfs_blob[i].size,
> +						MEMREMAP_WB);
> +		if (!debugfs_blob[i].data)
> +			continue;
> +
> +		debugfs_create_blob(name, 0400, efi_debugfs, &debugfs_blob[i]);
> +		i++;
> +		if (i == EFI_DEBUGFS_MAX_BLOBS)
> +			break;

Why do we silently ignore more entries ? And could documentation be
added for ways in which this could be used in practice?

  Luis
