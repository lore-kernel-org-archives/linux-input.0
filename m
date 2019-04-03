From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 00/11] mfd: add support for max77650 PMIC
Date: Wed, 3 Apr 2019 08:37:10 +0100
Message-ID: <20190403073710.GA11301@dell>
References: <20190326173208.30614-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190326173208.30614-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Tue, 26 Mar 2019, Bartosz Golaszewski wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series adds support for max77650 ultra low-power PMIC. It provides
> the core mfd driver and a set of five sub-drivers for the regulator,
> power supply, gpio, leds and input subsystems.
> 
> Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_devices().
> Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for this
> device.

My review carries forward to this version.

Please apply Acks, make changes and resubmit.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
