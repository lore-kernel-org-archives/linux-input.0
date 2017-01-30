From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/3] acpi: lpss: call pwm_add_table() for bsw pwm device
Date: Tue, 31 Jan 2017 00:21:33 +0200
Message-ID: <CAHp75VdqUhcW2ufJk5yPHYJv=Kb5-7EiC6FxZ7T+7jTaubhbbg@mail.gmail.com>
References: <20170122152415.10374-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170122152415.10374-1-hdegoede@redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Darren Hart <dvhart@infradead.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input <linux-input@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Jan 22, 2017 at 5:24 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On x86 we do not have devicetree to link the pwm controller and
> the display controller together. So someone needs to call
> pwm_add_table() to create the link, so that the i915 driver's
> pwm_get(dev, "pwm_backlight") call returns the lpss' pwm0.
>
> The pwm subsystem does not want to have pwm_add_table() calls
> directly in pwm drivers (this leads to probe ordering issues),
> so lets do it here since the acpi-lpss code is always builtin.

Hans, just to be sure, the device you have is using LPSS pwm for backlight.
Since I just recall that on some (Baytrail) models we have PMIC
(Crystal Cove) that responsible for PWM for backlight.
And we have no PMIC driver in kernel for CherryTrail (Dollar Cove).

-- 
With Best Regards,
Andy Shevchenko
