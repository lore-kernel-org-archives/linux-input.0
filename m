From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH 3/3] Input: keyboard: Fix ChromeOS EC keyboard help message.
Date: Mon, 2 Jul 2018 07:43:30 -0700
Message-ID: <CABXOdTfLS-x_sPWBi2mmjkUTtN0Spd9ObEy5fYtEB-hoLJTPEg@mail.gmail.com>
References: <20180702102201.13461-1-enric.balletbo@collabora.com> <20180702102201.13461-4-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702102201.13461-4-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, kgene@kernel.org, krzk@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>, Gwendal Grignou <gwendal@chromium.org>, linux-samsung-soc@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, chen.zhong@mediatek.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 2, 2018 at 3:22 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> The cros-ec I2C and SPI transport drivers have been moved from MFD
> subsystem to platform/chrome, at the same time, the config symbol
> has been renamed and lost the MFD_ prefix So, update the help message
> accordingly.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 6bd97ffee761..4713957b0cbb 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -721,7 +721,7 @@ config KEYBOARD_CROS_EC
>         help
>           Say Y here to enable the matrix keyboard used by ChromeOS devices
>           and implemented on the ChromeOS EC. You must enable one bus option
> -         (MFD_CROS_EC_I2C or MFD_CROS_EC_SPI) to use this.
> +         (CROS_EC_I2C or CROS_EC_SPI) to use this.
>
>           To compile this driver as a module, choose M here: the
>           module will be called cros_ec_keyb.
> --
> 2.18.0
>
