From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v7 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
Date: Fri, 11 Oct 2019 15:31:22 +0000
Message-ID: <20191011153122.GR16384@42.do-not-panic.com>
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-5-hdegoede@redhat.com>
 <20191004231733.GF22365@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191004231733.GF22365@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org, platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 04, 2019 at 04:17:33PM -0700, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Fri, Oct 04, 2019 at 04:50:52PM +0200, Hans de Goede wrote:
> > In some cases the platform's main firmware (e.g. the UEFI fw) may contain
> > an embedded copy of device firmware which needs to be (re)loaded into the
> > peripheral. Normally such firmware would be part of linux-firmware, but in
> > some cases this is not feasible, for 2 reasons:
> > 
> > 1) The firmware is customized for a specific use-case of the chipset / use
> > with a specific hardware model, so we cannot have a single firmware file
> > for the chipset. E.g. touchscreen controller firmwares are compiled
> > specifically for the hardware model they are used with, as they are
> > calibrated for a specific model digitizer.
> > 
> > 2) Despite repeated attempts we have failed to get permission to
> > redistribute the firmware. This is especially a problem with customized
> > firmwares, these get created by the chip vendor for a specific ODM and the
> > copyright may partially belong with the ODM, so the chip vendor cannot
> > give a blanket permission to distribute these.
> > 
> > This commit adds a new platform fallback mechanism to the firmware loader
> > which will try to lookup a device fw copy embedded in the platform's main
> > firmware if direct filesystem lookup fails.
> > 
> > Drivers which need such embedded fw copies can enable this fallback
> > mechanism by using the new firmware_request_platform() function.
> 
> Why would drivers not want to fetch firmware from system firmware if it
> is not present on disk? I would say let driver to opt-out of this
> fallback, but default request_firmware() should do it by default.

It is the otherw way around, this looks first for the file on disk, and
if not present it looks for the firmware sprinked on EFI firmware, if
the driver was expected this fallback option for the device.

  Luis
