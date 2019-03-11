From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: hid-asus: select CONFIG_POWER_SUPPLY
Date: Mon, 11 Mar 2019 15:57:14 +0100
Message-ID: <CAO-hwJLRq-0dXyAS+gg8yasqQuvR82EOeLPb+duj22tpBstKNw@mail.gmail.com>
References: <20190304195536.1019650-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190304195536.1019650-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>, NOGUCHI Hiroshi <drvlabo@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Mar 4, 2019 at 8:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly added power supply code fails to link when the power supply core
> code is disabled:
>
> drivers/hid/hid-asus.o: In function `asus_battery_get_property':
> hid-asus.c:(.text+0x11de): undefined reference to `power_supply_get_drvdata'
> drivers/hid/hid-asus.o: In function `asus_probe':
> hid-asus.c:(.text+0x170c): undefined reference to `devm_power_supply_register'
> hid-asus.c:(.text+0x1734): undefined reference to `power_supply_powers'
> drivers/hid/hid-asus.o: In function `asus_raw_event':
> hid-asus.c:(.text+0x1914): undefined reference to `power_supply_changed'
>
> Select the subsystem from Kconfig as we do for other hid drivers already.
>
> Fixes: 6311d329e12a ("HID: hid-asus: Add BT keyboard dock battery monitoring support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to for-5.1/upstream-fixes

Cheers,
Benjamin

>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 6ca8d322b487..4ca0cdfa6b33 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -150,6 +150,7 @@ config HID_ASUS
>         tristate "Asus"
>         depends on LEDS_CLASS
>         depends on ASUS_WMI || ASUS_WMI=n
> +       select POWER_SUPPLY
>         ---help---
>         Support for Asus notebook built-in keyboard and touchpad via i2c, and
>         the Asus Republic of Gamers laptop keyboard special keys.
> --
> 2.20.0
>
