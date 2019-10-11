From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v7 3/8] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
Date: Fri, 11 Oct 2019 15:02:27 +0000
Message-ID: <20191011150227.GO16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-4-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Scott Branden <scott.branden@broadcom.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 04, 2019 at 04:50:51PM +0200, Hans de Goede wrote:
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index 62ee90b4db56..665b350419cb 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -606,7 +606,7 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
>  		return false;
>  	}
>  
> -	if ((opt_flags & FW_OPT_NOFALLBACK))
> +	if ((opt_flags & FW_OPT_NOFALLBACK_SYSFS))
>  		return false;
>  
>  	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
> @@ -630,10 +630,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
>   * interface. Userspace is in charge of loading the firmware through the sysfs
>   * loading interface. This sysfs fallback mechanism may be disabled completely
>   * on a system by setting the proc sysctl value ignore_sysfs_fallback to true.
> - * If this false we check if the internal API caller set the @FW_OPT_NOFALLBACK
> - * flag, if so it would also disable the fallback mechanism. A system may want
> - * to enfoce the sysfs fallback mechanism at all times, it can do this by
> - * setting ignore_sysfs_fallback to false and force_sysfs_fallback to true.
> + * If this false we check if the internal API caller set the
         ignore_sysfs_fallback set to true or force_sysfs_fallback is
	 set to false

Otherwise looks good. You can add:

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
