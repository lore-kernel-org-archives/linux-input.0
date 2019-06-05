From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 02/10] mfd / platform: cros_ec: Move
 cros-ec core driver out from MFD
Date: Wed, 5 Jun 2019 16:23:46 +0200
Message-ID: <cd3d87d2-46eb-2f4f-283b-d984c2cdc2bf@baylibre.com>
References: <20190604152019.16100-1-enric.balletbo@collabora.com>
 <20190604152019.16100-3-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190604152019.16100-3-enric.balletbo@collabora.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-kernel@vger.kernel.org
Cc: gwendal@chromium.org, Banajit Goswami <bgoswami@codeaurora.org>, Vignesh R <vigneshr@ti.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Juergen Fitschen <jfi@ssv-embedded.de>, alsa-devel@alsa-project.org, Stefan Agner <stefan@agner.ch>, Douglas Anderson <dianders@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Guenter Roeck <groeck@chromium.org>, kernel@collabora.com, dtor@chromium.org, Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <jdelvare@suse.de>, Jacky Bai <ping.bai@nxp.com>, linux-rtc@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sean
List-Id: linux-input@vger.kernel.org

On 04/06/2019 17:20, Enric Balletbo i Serra wrote:
> Now, the ChromeOS EC core driver has nothing related to an MFD device, so
> move that driver from the MFD subsystem to the platform/chrome subsystem.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/extcon/Kconfig                     |  2 +-
>  drivers/hid/Kconfig                        |  2 +-
>  drivers/i2c/busses/Kconfig                 |  2 +-
>  drivers/iio/common/cros_ec_sensors/Kconfig |  2 +-
>  drivers/input/keyboard/Kconfig             |  2 +-
>  drivers/media/platform/Kconfig             |  3 +--
>  drivers/mfd/Kconfig                        | 14 +-------------
>  drivers/mfd/Makefile                       |  2 --
>  drivers/platform/chrome/Kconfig            | 21 +++++++++++++++++----
>  drivers/platform/chrome/Makefile           |  1 +
>  drivers/{mfd => platform/chrome}/cros_ec.c |  0
>  drivers/power/supply/Kconfig               |  2 +-
>  drivers/pwm/Kconfig                        |  2 +-
>  drivers/rtc/Kconfig                        |  2 +-
>  sound/soc/qcom/Kconfig                     |  2 +-
>  15 files changed, 29 insertions(+), 30 deletions(-)
>  rename drivers/{mfd => platform/chrome}/cros_ec.c (100%)
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com> # for the cros-cec part
