From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw
 support
Date: Mon, 7 Oct 2019 16:19:56 +0200
Message-ID: <20191007141956.GA25347@gmail.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004145056.43267-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> Hi All,
> 
> Here is v7 of my patch-set to add support for EFI embedded fw to the kernel.
> 
> v6 was posted a long time ago, around the 4.18 days. The long wait was for
> a suitable secure-hash for checking the firmware we find embedded in the EFI
> is the one we expect.
> 
> With 5.4-rc1 we finally have a standalone sha256 lib, so that hurdle for
> this patch-set is now gone.
> 
> I've tried to address all review-remarks against v6 in this new version:
> 
> Changes in v7:
> - Split drivers/firmware/efi and drivers/base/firmware_loader changes into
>   2 patches
> - Use new, standalone, lib/crypto/sha256.c code
> - Address kdoc comments from Randy Dunlap
> - Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
>   _request_firmware() wrapper, as requested by Luis R. Rodriguez
> - Stop using "efi-embedded-firmware" device-property, now that drivers need to
>   use the new firmware_request_platform() to enable fallback to a device fw
>   copy embedded in the platform's main firmware, we no longer need a property
>   on the device to trigger this behavior
> - Use security_kernel_load_data instead of calling
>   security_kernel_read_file with a NULL file pointer argument
> - Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
> - Document the new firmware_request_platform() function in
>   Documentation/driver-api/firmware/request_firmware.rst
> - Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
>   to use the new firmware_request_platform() method
> - Rebased on top of 5.4-rc1
> 
> I guess this will probably need another round (ot two) of review + fixing,
> but eventually this can hopefully be merged. Since this touches a bunch
> of different subsystems the question is how to merge this? Most of the
> touched files outside of the firmware-loader code do not see a lot of
> churn, so my proposal would be to merge patches 1-6 through the tree
> which carries firmware-loader changes; and then provide an immutable
> branch for the platform/x86 maintainers to merge and then they can merge
> the last 2 patches (as the touchscreen_dmi.c file does see quite a bit
> of changes every release).

So I was looking for a high level 0/ boilerplate description of this 
series, to explain what "EFI embedded fw" is, what problems it solves and 
how it helps the kernel in general - and found this in 2/8:

>> Just like with PCI options ROMs, which we save in the setup_efi_pci*
>> functions from arch/x86/boot/compressed/eboot.c, the EFI code / ROM itself
>> sometimes may contain data which is useful/necessary for peripheral drivers
>> to have access to.
>>
>> Specifically the EFI code may contain an embedded copy of firmware which
>> needs to be (re)loaded into the peripheral. Normally such firmware would be
>> part of linux-firmware, but in some cases this is not feasible, for 2
>> reasons:
>>
>> 1) The firmware is customized for a specific use-case of the chipset / use
>> with a specific hardware model, so we cannot have a single firmware file
>> for the chipset. E.g. touchscreen controller firmwares are compiled
>> specifically for the hardware model they are used with, as they are
>> calibrated for a specific model digitizer.
>>
>> 2) Despite repeated attempts we have failed to get permission to
>> redistribute the firmware. This is especially a problem with customized
>> firmwares, these get created by the chip vendor for a specific ODM and the
>> copyright may partially belong with the ODM, so the chip vendor cannot
>> give a blanket permission to distribute these.
>>
>> This commit adds support for finding peripheral firmware embedded in the
>> EFI code and makes the found firmware available through the new
>> efi_get_embedded_fw() function.
>>
>> Support for loading these firmwares through the standard firmware loading
>> mechanism is added in a follow-up commit in this patch-series.
>>
>> Note we check the EFI_BOOT_SERVICES_CODE for embedded firmware near the end
>> of start_kernel(), just before calling rest_init(), this is on purpose
>> because the typical EFI_BOOT_SERVICES_CODE memory-segment is too large for
>> early_memremap(), so the check must be done after mm_init(). This relies
>> on EFI_BOOT_SERVICES_CODE not being free-ed until efi_free_boot_services()
>> is called, which means that this will only work on x86 for now.
>>
>> Reported-by: Dave Olsthoorn <dave@bewaar.me>
>> Suggested-by: Peter Jones <pjones@redhat.com>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

There's also patch #3, which explains how this is used:

>> This commit adds a new platform fallback mechanism to the firmware loader
>> which will try to lookup a device fw copy embedded in the platform's main
>> firmware if direct filesystem lookup fails.
>>
>> Drivers which need such embedded fw copies can enable this fallback
>> mechanism by using the new firmware_request_platform() function.
>>
>> Note that for now this is only supported on EFI platforms and even on
>> these platforms firmware_fallback_platform() only works if
>> CONFIG_EFI_EMBEDDED_FIRMWARE is enabled (this gets selected by drivers
>> which need this), in all other cases firmware_fallback_platform() simply
>> always returns -ENOENT.

Plus there's 3 patches that opt in three drivers to this new EFI-firmware 
loading mechanism, right?

A couple of high level questions:

- How common are these kinds of firmware files that should be loaded into 
  the device by the OS device driver? Common? Or 1% of systems? 0.1% of 
  systems? 0.0001%?

- Can there be a situation where linux-firmware already includes an older 
  copy of the firmware, and the EFI firmware has a newer version? If this 
  can plausibly happen, shouldn't the fallback mechanism do some sort of 
  version check (if that's possible), and load the newer version?

- I'm worried about the explicit opt-in nature of these firmware files - 
  the OS driver has to be explicitly aware of this possibility. Shouldn't 
  we at minimum have some sort of boot time check to see whether a device 
  has an embedded fw blob, and warn the user if we don't actually load 
  it? Which would generate some gentle pressure to fix our drivers?

- I think the config option should be default-y, because AFAICS this 
  mechanism makes broken drivers/devices work.

- Finally, is there any question of trust or a potential for other 
  security pitfalls here, where we'd trust linux-firmware over what the 
  EFI firmware says is the proper firmware for a device? My default 
  assumption would be that we are exposed to the EFI firmware anyway, and 
  it comes with the hardware just like the devices come with the 
  hardware, so we can generally trust it. But I might be missing 
  something. If there's any plausible question of trust (for example can 
  attackers hide rooted firmware in the EFI image, without triggering 
  filesystem integrity checks on the regular filesystem side?) then it 
  might make sense to offer a boot parameter to disable this, beyond the 
  config parameter.

Thanks,

	Ingo
