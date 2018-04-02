From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [v3,4/4] watchdog: add Gateworks System Controller support
Date: Mon, 2 Apr 2018 18:32:42 +0200
Message-ID: <20180402163242.GC14165@lunn.ch>
References: <1522250043-8065-5-git-send-email-tharvey@gateworks.com>
 <20180330010757.GA12896@roeck-us.net>
 <CAJ+vNU3ARKLK5AcssEP-_P8AmwnAnS8VtAEO1ppwum2jpCqAYQ@mail.gmail.com>
 <20180330181954.GA17580@roeck-us.net>
 <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ+vNU1f+SH16hs3heMA_A2KcbzbXXmJtPxi0uiL4+4tNWgYoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Harvey <tharvey@gateworks.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Wim Van Sebroeck <wim@iguana.be>, Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

> The 'use case' we have been using this in for a couple years is that
> users who want to use this watchdog will enable it externally (we have
> a command in the bootloader) and if enabled the kernel driver (that
> I'm proposing here which we've been using out-of-tree) will register
> the watchdog device and the userspace watchdog process can open the
> device and start tickling it. If the watchdog is never enabled (or
> disabled via the bootloader command) the kernel driver fails to probe
> and the SoC's watchdog can be used.

Hi Tim

Is there any reason not to give the user the choice to use both
watchdogs? Normally you write drivers to expose the hardware, and then
let the users choice if they want to use it.

	Andrew
