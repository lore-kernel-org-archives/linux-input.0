From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] ARM: ep93xx: move pinctrl interfaces into include/linux/soc
Date: Tue, 23 Apr 2019 12:41:00 +0200
Message-ID: <CACRpkdaVYZf5y3gn-DFsDCutovtw+3-qyo7oKw3UABdfXDRYsw@mail.gmail.com>
References: <20190415192734.935387-1-arnd@arndb.de> <20190415192734.935387-3-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415192734.935387-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Mark Brown <broonie@kernel.org>, Olof Johansson <olof@lixom.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, linux-pwm@vger.kernel.org, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 15, 2019 at 9:30 PM Arnd Bergmann <arnd@arndb.de> wrote:

> ep93xx does not have a proper pinctrl driver, but does things
> ad-hoc through mach/platform.h, which is also used for setting
> up the boards.
>
> To avoid using mach/*.h headers completely, let's move the interfaces
> into include/linux/soc/. This is far from great, but gets the job
> done here, without the need for a proper pinctrl driver.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
