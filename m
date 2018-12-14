From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3] MAINTAINERS: add maintainers for ChromeOS EC
 sub-drivers
Date: Fri, 14 Dec 2018 09:24:12 -0800
Message-ID: <461e2531e3979e89923b66966d4fb243a6113280.camel@perches.com>
References: <20181214114858.21231-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214114858.21231-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, groeck@chromium.org, kernel@collabora.com, linux-rtc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Benson Leung <bleung@chromium.org>, Sebastian Reichel <sre@kernel.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devicetree@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Lee Jones <lee.jones@linaro.org>, Hartmut Knaack <knaack.h@gmx.de>, Rob Herring <robh+dt@kernel.org>, Lars
List-Id: linux-input@vger.kernel.org

On Fri, 2018-12-14 at 12:48 +0100, Enric Balletbo i Serra wrote:
> There are multiple ChromeOS EC sub-drivers spread in different
> subsystems, as all of them are related to the Chrome stuff add
> Benson and myself as a maintainers for all these sub-drivers.

[]
> Changes in v3:
> - Use a cros[-_]ec pattern instead of list all the files.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
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

For linux scripts/, it is unconventional to use a hyphen first
in a character class pattern so perhaps this is clearer using
two N: patterns

N:	cros_
N:	cros-
