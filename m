From: Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH v2 2/2] input: soc_button_array for newer surface devices
Date: Tue, 16 Jul 2019 20:19:04 +0200
Message-ID: <92e13b01-7353-1430-fb38-b5098d509da2@gmail.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-3-luzmaximilian@gmail.com>
 <20190716072135.GA806@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190716072135.GA806@penguin>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen Yu <yu.c.chen@intel.com>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org


Hi,

On 7/16/19 9:21 AM, Dmitry Torokhov wrote:
> When you are saying that Pro 4 and later models use different
> notifications, does this mean that Pro 4 does not define any GPIOs?

Unfortunately, at least the Surface Book (first generation, buttons are
handled the same way as on the Pro 4) has GPIOs defined in MSHW0040, but
they are for different use. Specifically: They can detect if the
clipboard (screen part of the device, the device basically has two parts
that can be separated: clipboard and base) is being removed. Relying on
the GPIOs was my first idea too, but that has been reported to shut down
the Book 1 when the clipboard is detached.

As far as I know, the OEM platform revision check is the easiest way to
differentiate between those devices.

> I do not believe -EAGAIN has any special meaning in the driver core;

I think I got the -EAGAIN from an outdated LWN article when I first
started working on this, thanks for confirming.

> also when the GPIO controller is not ready gpiod_get() will return
> -EPROBE_DEFER, which is the prober way if signalling that some resource
> is not yet available and probe should be retries at a later time.
>
> Moreover, I do not believe that gpiod_count() needs GPIO controller to
> be ready, the count is taken from board firmware or static board file
> definition, so if gpiod_count() returns 0 it should be clear indication
> that the driver should not be used with the device.

Thank you for this insight, I will update the patch accordingly.

Maximilian
