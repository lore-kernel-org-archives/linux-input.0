From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] input: soc_button_array for newer surface devices
Date: Tue, 16 Jul 2019 22:18:07 +0200
Message-ID: <20190716201807.GA584@penguin>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-3-luzmaximilian@gmail.com>
 <20190716072135.GA806@penguin>
 <92e13b01-7353-1430-fb38-b5098d509da2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <92e13b01-7353-1430-fb38-b5098d509da2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jul 16, 2019 at 08:19:04PM +0200, Maximilian Luz wrote:
> 
> Hi,
> 
> On 7/16/19 9:21 AM, Dmitry Torokhov wrote:
> > When you are saying that Pro 4 and later models use different
> > notifications, does this mean that Pro 4 does not define any GPIOs?
> 
> Unfortunately, at least the Surface Book (first generation, buttons are
> handled the same way as on the Pro 4) has GPIOs defined in MSHW0040, but
> they are for different use. Specifically: They can detect if the
> clipboard (screen part of the device, the device basically has two parts
> that can be separated: clipboard and base) is being removed. Relying on
> the GPIOs was my first idea too, but that has been reported to shut down
> the Book 1 when the clipboard is detached.
> 
> As far as I know, the OEM platform revision check is the easiest way to
> differentiate between those devices.

OK, fair enough. By the way, I see you are adding some #ifdef
CONFIG_ACPI and stubbing out new functions, but the driver does not
really work without ACPI (acpi_match_device() will fail in this case I
would think and that will cause probe() to abort). So maybe we just add
depends on ACPI to the driver's Kconfig entry?

Thanks.

-- 
Dmitry
