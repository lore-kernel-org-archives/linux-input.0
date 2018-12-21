From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 6/8] iio: adc: add STMPE ADC devicetree bindings
Date: Fri, 21 Dec 2018 12:25:12 -0600
Message-ID: <20181221182512.GA8531@bogus>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-7-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-7-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, digetx@gmail.com, lee.jones@linaro.org, coquelin.stm32@gmail.com, Max Krummenacher <max.krummenacher@toradex.com>, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: linux-input@vger.kernel.org

On Fri, 21 Dec 2018 14:46:35 +0100, Philippe Schenker wrote:
> From: Stefan Agner <stefan@agner.ch>
> 
> This adds the devicetree bindings for the STMPE ADC. This also corrects
> a typo in st,sample-time it is rather "6 -> 124 clocks" according
> to the datasheet and not 144.
> We need to use the naming stmpe_adc in devicetree because this is given
> by the mfd device.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Changes in v5:
>  - Made a one column list
>  - Cleared note about precedence
>  - Changed example to a full STMPE811 device with MFD, touchscreen, and the new
>    stmpe_adc driver.
>  - Added Jonathan Cameron's Reviewed-by
> 
> Changes in v4:
>  - Put reformatting in a separate precursor patch.
> 
> Changes in v3:
>  - Reformatted documentation for touchscreen to use tabs and have a better
>    overview of the settings.
>  - Added note which adc-settings will take precedence.
>  - changed typo in sample-time setting from 144 clocks to 124 clocks, as stated
>    in the datasheet.
> 
> Changes in v2:
>  - Moved the bindings for ADC to the overlying mfd.
>  - Reformatted for better readability
> 
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 +++++
>  .../bindings/input/touchscreen/stmpe.txt      | 88 +++++++++++++------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 +++
>  3 files changed, 98 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
