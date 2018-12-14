From: Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC sub-drivers
Date: Fri, 14 Dec 2018 06:29:19 -0800
Message-ID: <CABXOdTdDNaPgBK74dcTgRDy5mJKztZ9GTGRiXDv=ZXOwauO-2A@mail.gmail.com>
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, alexandre.belloni@bootlin.com, linux-i2c@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linar>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 14, 2018 at 3:49 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v3:
> - Add collected acks
> - Use a cros[-_]ec pattern instead of list all the files.
> - Add Guenter as a reviewer.
>
> Changes in v2:
> - Fix typo in Benson email address.
>
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e7260191301b..437e036435d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3629,6 +3629,14 @@ S:       Maintained
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:     drivers/platform/chrome/
>
> +CHROMEOS EC SUBDRIVERS
> +M:     Benson Leung <bleung@chromium.org>
> +M:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:     Guenter Roeck <groeck@chromium.org>
> +S:     Maintained
> +N:     cros[-_]ec
> +F:     drivers/power/supply/cros_usbpd-charger.c
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:     Brian Austin <brian.austin@cirrus.com>
>  M:     Paul Handrigan <Paul.Handrigan@cirrus.com>
> --
> 2.19.2
>
