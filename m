From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/4] iio: adc: add STMPE ADC driver using IIO framework
Date: Wed, 28 Nov 2018 09:04:54 +0000
Message-ID: <20181128090454.GR4272@dell>
References: <20181123142411.8921-1-dev@pschenker.ch>
 <20181123142411.8921-2-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123142411.8921-2-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, Max Krummenacher <max.krummenacher@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, Mark Brown <broonie@kernel.org>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-iio@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Baolin Wang <baolin.wang@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, Marcus Folkesson <marcus.folkesson@gmail.com>, Freeman Liu <freeman.liu@spreadtrum.com>, linux-input@vger.kernel.org, Eugen Hristev <eugen.hristev@microchip.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lars-Peter Clausen <lars@metaf>
List-Id: linux-input@vger.kernel.org

On Fri, 23 Nov 2018, Philippe Schenker wrote:

> From: Stefan Agner <stefan@agner.ch>
> 
> This adds an ADC driver for the STMPE device using the industrial
> input/output interface. The driver supports raw reading of values.
> The driver depends on the MFD STMPE driver. If the touchscreen
> block is enabled too, only four of the 8 ADC channels are available.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v3:
>  - Undo ADC-settings related code-deletions in stmpe-ts.c that the code is
>    backwards-compatible to older devicetrees.
> 
> Changes in v2:
>  - Code formatting
>  - Move code to setup ADC to MFD device, as it is used by both drivers
>    adc and touchscreen
>  - Removed unused includes
>  - Defined the macro STMPE_START_ONE_TEMP_CONV with other macros.
>  - Added new macro that defines the channel of the temperature sensor.
>    Took new name for STMPE_MAX_ADC->STMPE_ADC_LAST_NR and used it throughout
>    the code for better readability.
>  - Added mutex_unlock where missing.
> 
>  drivers/iio/adc/Kconfig              |   7 +
>  drivers/iio/adc/Makefile             |   1 +
>  drivers/iio/adc/stmpe-adc.c          | 326 +++++++++++++++++++++++++++
>  drivers/input/touchscreen/stmpe-ts.c |  36 +--

>  drivers/mfd/Kconfig                  |   3 +-
>  drivers/mfd/stmpe.c                  |  81 +++++++
>  include/linux/mfd/stmpe.h            |   9 +

The MFD changes should be contained in a separate patch.

I don't see anything which ties the changes together.

>  7 files changed, 437 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/iio/adc/stmpe-adc.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
