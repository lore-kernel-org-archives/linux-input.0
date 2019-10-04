From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 0/8] efi/firmware/platform-x86: Add EFI embedded fw support
Date: Fri,  4 Oct 2019 16:50:48 +0200
Message-ID: <20191004145056.43267-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi All,

Here is v7 of my patch-set to add support for EFI embedded fw to the kernel.

v6 was posted a long time ago, around the 4.18 days. The long wait was for
a suitable secure-hash for checking the firmware we find embedded in the EFI
is the one we expect.

With 5.4-rc1 we finally have a standalone sha256 lib, so that hurdle for
this patch-set is now gone.

I've tried to address all review-remarks against v6 in this new version:

Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes into
  2 patches
- Use new, standalone, lib/crypto/sha256.c code
- Address kdoc comments from Randy Dunlap
- Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
  _request_firmware() wrapper, as requested by Luis R. Rodriguez
- Stop using "efi-embedded-firmware" device-property, now that drivers need to
  use the new firmware_request_platform() to enable fallback to a device fw
  copy embedded in the platform's main firmware, we no longer need a property
  on the device to trigger this behavior
- Use security_kernel_load_data instead of calling
  security_kernel_read_file with a NULL file pointer argument
- Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rst
- Document the new firmware_request_platform() function in
  Documentation/driver-api/firmware/request_firmware.rst
- Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
  to use the new firmware_request_platform() method
- Rebased on top of 5.4-rc1

I guess this will probably need another round (ot two) of review + fixing,
but eventually this can hopefully be merged. Since this touches a bunch
of different subsystems the question is how to merge this? Most of the
touched files outside of the firmware-loader code do not see a lot of
churn, so my proposal would be to merge patches 1-6 through the tree
which carries firmware-loader changes; and then provide an immutable
branch for the platform/x86 maintainers to merge and then they can merge
the last 2 patches (as the touchscreen_dmi.c file does see quite a bit
of changes every release).

Regards,

Hans
