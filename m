From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 06/10] mfd / platform: cros_ec: Reorganize platform and
 mfd includes
Date: Tue, 11 Jun 2019 10:10:30 -0700
Message-ID: <20190611171030.GC143729@dtor-ws>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-7-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604152019.16100-7-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, gwendal@chromium.org, Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee.jones@linaro.org>, kernel@collabora.com, dtor@chromium.org, Mauro Carvalho Chehab <mchehab@kernel.org>, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, linux-iio@vger.kernel.org, Fabien Lahoudere <fabien.lahoudere@collabora.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-i2c@vger.kernel.org, linux-rtc@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, Chanwoo Choi <cw00.choi@samsung.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Sebastian Reichel <sre@kernel.org>, Rushikesh
List-Id: linux-input@vger.kernel.org

On Tue, Jun 04, 2019 at 05:20:15PM +0200, Enric Balletbo i Serra wrote:
> There is a bit of mess between cros-ec mfd includes and platform
> includes. For example, we have a linux/mfd/cros_ec.h include that
> exports the interface implemented in platform/chrome/cros_ec_proto.c. Or
> we have a linux/mfd/cros_ec_commands.h file that is non related to the
> multifunction device (in the sense that is not exporting any function of
> the mfd device). This causes crossed includes between mfd and
> platform/chrome subsystems and makes the code difficult to read, apart
> from creating 'curious' situations where a platform/chrome driver includes
> a linux/mfd/cros_ec.h file just to get the exported functions that are
> implemented in another platform/chrome driver.
> 
> In order to have a better separation on what the cros-ec multifunction
> driver does and what the cros-ec core provides move and rework the
> affected includes doing:
> 
>  - Move cros_ec_commands.h to include/linux/platform_data/cros_ec_commands.h
>  - Get rid of the parts that are implemented in the platform/chrome/cros_ec_proto.c
>    driver from include/linux/mfd/cros_ec.h to a new file
>    include/linux/platform_data/cros_ec_proto.h
>  - Update all the drivers with the new includes, so
>    - Drivers that only need to know about the protocol include
>      - linux/platform_data/cros_ec_proto.h
>      - linux/platform_data/cros_ec_commands.h
>    - Drivers that need to know about the cros-ec mfd device also include
>      - linux/mfd/cros_ec.h
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
