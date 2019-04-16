From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/4] mfd: ioc3: Add driver for SGI IOC3 chip
Date: Tue, 16 Apr 2019 15:16:19 +0200
Message-ID: <20190416131619.GE7406@kroah.com>
References: <20190409154610.6735-1-tbogendoerfer@suse.de>
 <20190409154610.6735-3-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190409154610.6735-3-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 09, 2019 at 05:46:06PM +0200, Thomas Bogendoerfer wrote:
> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
> 
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/include/asm/sn/ioc3.h       |  345 +++---
>  arch/mips/sgi-ip27/ip27-timer.c       |   20 -
>  drivers/mfd/Kconfig                   |   13 +
>  drivers/mfd/Makefile                  |    1 +
>  drivers/mfd/ioc3.c                    |  802 ++++++++++++++
>  drivers/net/ethernet/sgi/Kconfig      |    4 +-
>  drivers/net/ethernet/sgi/ioc3-eth.c   | 1867 ++++++++++++---------------------
>  drivers/tty/serial/8250/8250_ioc3.c   |   98 ++
>  drivers/tty/serial/8250/Kconfig       |   11 +
>  drivers/tty/serial/8250/Makefile      |    1 +
>  include/linux/platform_data/ioc3eth.h |   15 +
>  11 files changed, 1762 insertions(+), 1415 deletions(-)
>  create mode 100644 drivers/mfd/ioc3.c
>  create mode 100644 drivers/tty/serial/8250/8250_ioc3.c
>  create mode 100644 include/linux/platform_data/ioc3eth.h

Serial portion:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
