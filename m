From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 3/6] hid: add backlight support to PicoLCD device
Date: Mon, 22 Mar 2010 09:59:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003220957390.18642@pobox.suse.cz>
References: <20100320170014.440959a8@neptune.home> <20100320170619.4ae99546@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100320170619.4ae99546@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>, Richard Purdie <rpurdie@rpsys.net>
List-Id: linux-input@vger.kernel.org

On Sat, 20 Mar 2010, Bruno Pr=C3=A9mont wrote:

> Add backlight support to PicoLCD device.
>=20
> Backlight support depends on backlight class and is only being
> compiled if backlight class has been selected.
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> ---
>  drivers/hid/Kconfig       |    2 +-
>  drivers/hid/hid-picolcd.c |  134 +++++++++++++++++++++++++++++++++++=
+++++++++-
>  2 files changed, 134 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index a474bcd..5ec3cb7 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -243,8 +243,8 @@ config HID_PICOLCD
>  	  - Keypad
>  	  - Switching between Firmware and Flash mode
>  	  - Framebuffer for monochrome 256x64 display
> +	  - Backlight control    (needs CONFIG_BACKLIGHT_CLASS_DEVICE)

Wouldn't it be better to have Kconfig rules actually resolve the=20
dependency?

I don't see any issue with HID_PICOLCD directly selecting=20
BACKLIGHT_CLASS_DEVICE. Or you can do a separate sub-option for that, i=
f=20
you really want to avoid the direct dependency of the whole driver.

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
