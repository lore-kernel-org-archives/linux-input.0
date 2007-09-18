From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] sony-laptop/thinkpad-acpi: fix build error
Date: Tue, 18 Sep 2007 12:49:14 -0400
Message-ID: <200709181249.14909.lenb@kernel.org>
References: <20070917205434.GA22458@devil>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070917205434.GA22458@devil>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Andreas Herrmann <aherrman@arcor.de>
Cc: Len Brown <len.brown@intel.com>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Monday 17 September 2007 16:54, Andreas Herrmann wrote:
> sony-laptop and thinkpad-acpi make use of input-core functions.
> Hence you get link errors if those drivers are built but CONFIG_INPUT
> is not set. Attached patch fixes this minor issue.
> 
> 
> Regards,
> 
> Andreas
> 
> --
> Build errors if CONFIG_SONY_LAPTOP && !INPUT or
> if CONFIG_THINKPAD_ACPI && !INPUT:
> 
>  LD      vmlinux
>     ...
> drivers/built-in.o: In function `sony_laptop_remove_input':
> sony-laptop.c:(.text+0x768fb): undefined reference to `input_unregister_device'
>     ...
> drivers/built-in.o: In function `thinkpad_acpi_module_exit':
> thinkpad_acpi.c:(.text+0x78c1b): undefined reference to `input_free_device'
>     ...
> 
> I suggest to auto-select CONFIG_INPUT for both drivers.


I'd prefer to use "depends on" here, as "select" is sort
of a last resort, given its inherent disfunctionalty
(is that a word?:-)

yes, I wish "select" worked the way programmers want it to,
but it doesn't.  Indeed, the only reason using it here is technically
correct is that both these invocations depends on X86 and that
avoids the conflict with !s390 INPUT.

Also, the reality is that all configs that want these drivers
will have INPUT set already -- something that probably could
not be said of BACKLIGHT_CLASS_DEVICE etc. -- so this patch
is really just to please randconfig.

Unless you object, I'll just change this to "depends on" when i apply it.

thanks,
-Len


> Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
> ---
>  drivers/misc/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 73e248f..c077df8 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -134,6 +134,7 @@ config SONY_LAPTOP
>  	tristate "Sony Laptop Extras"
>  	depends on X86 && ACPI
>  	select BACKLIGHT_CLASS_DEVICE
> +	select INPUT
>  	  ---help---
>  	  This mini-driver drives the SNC and SPIC devices present in the ACPI
>  	  BIOS of the Sony Vaio laptops.
> @@ -156,6 +157,7 @@ config THINKPAD_ACPI
>  	select BACKLIGHT_CLASS_DEVICE
>  	select HWMON
>  	select NVRAM
> +	select INPUT
>  	---help---
>  	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
>  	  support for Fn-Fx key combinations, Bluetooth control, video
