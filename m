From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 00/10] Move part of cros-ec out of MFD
	subsystem
Date: Tue, 4 Jun 2019 19:07:34 +0300
Message-ID: <20190604160734.GM9224@smile.fi.intel.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20190604152019.16100-1-enric.balletbo@collabora.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Enno Luebbers <enno.luebbers@intel.com>, gwendal@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-doc@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Juergen Fitschen <jfi@ssv-embedded.de>, alsa-devel@alsa-project.org, Stefan Agner <stefan@agner.ch>, Sebastian Reichel <sre@kernel.org>, Jilayne Lovejoy <opensource@jilayne.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dong Aisheng <aisheng.dong@nxp.com>, Guenter Roeck <groeck@chromium.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ravi Chandra Sadineni <rav>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 04, 2019 at 05:20:09PM +0200, Enric Balletbo i Serra wrote:
> Hi,
> 
> This is the first attempt to clean up a bit more the cros-ec drivers
> to have a better separation on what is part of the MFD subsystem and what
> is part of platform/chrome.
> 
> It'd be really nice have some reviews, acks and tested on different
> platforms from the chromiumos people before merge all this patchset, as
> this moves a lot of code.
> 
> The major changes introduced by this patchset are:
> 1. Move the core driver to platform/chrome, as is not really related to
> an MFD device driver.
> 2. Create a new misc chardev driver to replace the chardev bits from
> cros-ec-dev (MFD)
> 3. Added some convenience structs in cros-ec-dev (MFD) to easy add more
> subdrivers and avoid to add more boiler plate.
> 
> Once applied we have moved all the code to platform/chrome except the
> cros-ec-dev driver, which is the one that instantiates the different
> subdrivers as cells of the MFD device.
> 
> I tested the following patches on Veyron, Kevin, Samus, Peach Pi and
> Peach Pit without noticing any problem, but they would need a lot of
> more tests. I'll continue testing while the reviewing process of this
> patchset.
> 

If my tag helps, here it is:
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Waiting for your feedback,
>  Enric
> 
> 
> Enric Balletbo i Serra (10):
>   mfd / platform: cros_ec: Handle chained ECs as platform devices
>   mfd / platform: cros_ec: Move cros-ec core driver out from MFD
>   mfd / platform: cros_ec: Miscellaneous character device to talk with
>     the EC
>   mfd: cros_ec: Switch to use the new cros-ec-chardev driver
>   mfd / platform: cros_ec: Rename config to a better name
>   mfd / platform: cros_ec: Reorganize platform and mfd includes
>   mfd: cros_ec: Update with SPDX Licence identifier and fix description
>   mfd: cros_ec: Use kzalloc and cros_ec_cmd_xfer_status helper
>   mfd: cros_ec: Add convenience struct to define dedicated CrOS EC MCUs
>   mfd: cros_ec: Add convenience struct to define autodetectable CrOS EC
>     subdevices
> 
>  Documentation/ioctl/ioctl-number.txt          |   2 +-
>  drivers/extcon/Kconfig                        |   2 +-
>  drivers/extcon/extcon-usbc-cros-ec.c          |   3 +-
>  drivers/hid/Kconfig                           |   2 +-
>  drivers/hid/hid-google-hammer.c               |   4 +-
>  drivers/i2c/busses/Kconfig                    |   2 +-
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c       |   4 +-
>  drivers/iio/accel/cros_ec_accel_legacy.c      |   3 +-
>  drivers/iio/common/cros_ec_sensors/Kconfig    |   2 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |   3 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |   3 +-
>  drivers/iio/light/cros_ec_light_prox.c        |   3 +-
>  drivers/iio/pressure/cros_ec_baro.c           |   3 +-
>  drivers/input/keyboard/Kconfig                |   2 +-
>  drivers/input/keyboard/cros_ec_keyb.c         |   4 +-
>  drivers/media/platform/Kconfig                |   3 +-
>  .../media/platform/cros-ec-cec/cros-ec-cec.c  |   4 +-
>  drivers/mfd/Kconfig                           |  26 +-
>  drivers/mfd/Makefile                          |   4 +-
>  drivers/mfd/cros_ec_dev.c                     | 433 +++++-------------
>  drivers/platform/chrome/Kconfig               |  48 +-
>  drivers/platform/chrome/Makefile              |   2 +
>  drivers/{mfd => platform/chrome}/cros_ec.c    |  64 +--
>  drivers/platform/chrome/cros_ec_chardev.c     | 279 +++++++++++
>  drivers/platform/chrome/cros_ec_debugfs.c     |   3 +-
>  drivers/platform/chrome/cros_ec_i2c.c         |  12 +-
>  drivers/platform/chrome/cros_ec_lightbar.c    |   3 +-
>  drivers/platform/chrome/cros_ec_lpc.c         |   7 +-
>  drivers/platform/chrome/cros_ec_lpc_reg.c     |   4 +-
>  drivers/platform/chrome/cros_ec_proto.c       |   3 +-
>  drivers/platform/chrome/cros_ec_rpmsg.c       |   6 +-
>  drivers/platform/chrome/cros_ec_spi.c         |  12 +-
>  drivers/platform/chrome/cros_ec_sysfs.c       |   3 +-
>  drivers/platform/chrome/cros_ec_trace.c       |   2 +-
>  drivers/platform/chrome/cros_ec_trace.h       |   4 +-
>  drivers/platform/chrome/cros_ec_vbc.c         |   3 +-
>  drivers/platform/chrome/cros_usbpd_logger.c   |   5 +-
>  drivers/power/supply/Kconfig                  |   2 +-
>  drivers/power/supply/cros_usbpd-charger.c     |   5 +-
>  drivers/pwm/Kconfig                           |   2 +-
>  drivers/pwm/pwm-cros-ec.c                     |   4 +-
>  drivers/rtc/Kconfig                           |   2 +-
>  drivers/rtc/rtc-cros-ec.c                     |   3 +-
>  .../linux/iio/common/cros_ec_sensors_core.h   |   3 +-
>  include/linux/mfd/cros_ec.h                   | 302 +-----------
>  .../{mfd => platform_data}/cros_ec_commands.h |   0
>  include/linux/platform_data/cros_ec_proto.h   | 315 +++++++++++++
>  .../uapi/linux/cros_ec_chardev.h              |  18 +-
>  sound/soc/codecs/cros_ec_codec.c              |   4 +-
>  sound/soc/qcom/Kconfig                        |   2 +-
>  50 files changed, 902 insertions(+), 732 deletions(-)
>  rename drivers/{mfd => platform/chrome}/cros_ec.c (85%)
>  create mode 100644 drivers/platform/chrome/cros_ec_chardev.c
>  rename include/linux/{mfd => platform_data}/cros_ec_commands.h (100%)
>  create mode 100644 include/linux/platform_data/cros_ec_proto.h
>  rename drivers/mfd/cros_ec_dev.h => include/uapi/linux/cros_ec_chardev.h (70%)
> 
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko
