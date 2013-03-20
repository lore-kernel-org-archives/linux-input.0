From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] drivers: misc: use module_platform_driver_probe()
Date: Wed, 20 Mar 2013 10:20:14 +0000
Message-ID: <201303201020.14654.arnd@arndb.de>
References: <1363266691-15757-1-git-send-email-fabio.porcedda@gmail.com> <201303191759.27762.arnd@arndb.de> <CAHkwnC-3_dDM3JO8y3yeNFz7=fpP=MtZ9D-3cMH8rNF9C1NZBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <CAHkwnC-3_dDM3JO8y3yeNFz7=fpP=MtZ9D-3cMH8rNF9C1NZBA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, H Hartley Sweeten <hartleys@visionengravers.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Grant Likely <grant.likely@secretlab.ca>
List-Id: linux-input@vger.kernel.org

On Wednesday 20 March 2013, Fabio Porcedda wrote:
> I think we can check inside the  deferred_probe_work_func()
> if the dev->probe function pointer is equal to platform_drv_probe_fail().

I think it's too late by then, because that would only warn if we try to probe
it again, but when platform_driver_probe() does not succeed immediately, it
unregisters the driver again, so we never get there.

	Arnd
