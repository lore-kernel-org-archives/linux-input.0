From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 11/20] power_supply: Change ownership from driver to
 core
Date: Thu, 26 Feb 2015 08:24:37 +0000
Message-ID: <20150226082437.GH6688@x1>
References: <1424692061-30624-1-git-send-email-k.kozlowski@samsung.com>
 <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1424692061-30624-12-git-send-email-k.kozlowski@samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@googlemail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Support Opensource <support.opensource@diasemi.com>, Milo Kim <milo.kim@ti.com>, Julian Andres Klode <jak@jak-linux.org>, Marc Dietrich <marvin24@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.wolfsonmicro.com, ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, devel@driverdev.osuosl.org, Linus Walleij <linus.walleij@linaro.org>, Samuel
List-Id: linux-input@vger.kernel.org

On Mon, 23 Feb 2015, Krzysztof Kozlowski wrote:

> Change the ownership of power_supply structure from each driver
> implementing the class to the power supply core.
>=20
> The patch changes power_supply_register() function thus all drivers
> implementing power supply class are adjusted.
>=20
> Each driver provides the implementation of power supply. However it
> should not be the owner of power supply class instance because it is
> exposed by core to other subsystems with power_supply_get_by_name().
> These other subsystems have no knowledge when the driver will unregis=
ter
> the power supply. This leads to several issues when driver is unbound=
 -
> mostly because user of power supply accesses freed memory.
>=20
> Instead let the core own the instance of struct 'power_supply'.  Othe=
r
> users of this power supply will still access valid memory because it
> will be freed when device reference count reaches 0. Currently this
> means "it will leak" but power_supply_put() call in next patches will
> solve it.
>=20
> This solves invalid memory references in following race condition
> scenario:
>=20
> Thread 1: charger manager
> Thread 2: power supply driver, used by charger manager
>=20
> THREAD 1 (charger manager)         THREAD 2 (power supply driver)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D         =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> psy =3D power_supply_get_by_name()
>                                    Driver unbind, .remove
>                                      power_supply_unregister()
>                                      Device fully removed

[...]

>  include/linux/mfd/abx500/ux500_chargalg.h |  11 +-
>  include/linux/mfd/rt5033.h                |   2 +-
>  include/linux/mfd/wm8350/supply.h         |   6 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
