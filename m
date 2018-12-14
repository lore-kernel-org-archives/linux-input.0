From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Date: Fri, 14 Dec 2018 12:53:21 +0100
Message-ID: <43cc07bf-331b-e1c2-61d1-84f7d7d6a324@collabora.com>
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Lars
List-Id: linux-input@vger.kernel.org



On 14/12/18 12:48, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> for iio parts.

Ok, I resend the patch too quickly and I forget to remove the `for iio parts`.I
will wait a bit more for if I receive more acks and send a v4 to fix this.

> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>
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
> @@ -3629,6 +3629,14 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git
>  F:	drivers/platform/chrome/
>  
> +CHROMEOS EC SUBDRIVERS
> +M:	Benson Leung <bleung@chromium.org>
> +M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
> +R:	Guenter Roeck <groeck@chromium.org>
> +S:	Maintained
> +N:	cros[-_]ec
> +F:	drivers/power/supply/cros_usbpd-charger.c
> +
>  CIRRUS LOGIC AUDIO CODEC DRIVERS
>  M:	Brian Austin <brian.austin@cirrus.com>
>  M:	Paul Handrigan <Paul.Handrigan@cirrus.com>
> 
