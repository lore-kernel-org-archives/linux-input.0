From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD, IIO and Input due for the
 v5.1 merge window
Date: Wed, 16 Jan 2019 12:44:21 +0000
Message-ID: <20190116124421.GD23399@dell>
References: <20181221134638.20600-1-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-1-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, digetx@gmail.com, coquelin.stm32@gmail.com, Philippe Schenker <philippe.schenker@toradex.com>, Arnd Bergmann <arnd@arndb.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, William Breathitt Gray <vilhelm.gray@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, Fabio Estevam <fabio.estevam@nxp.com>, Randy Dunlap <rdunlap@infradead.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Freeman Liu <fre>
List-Id: linux-input@vger.kernel.org

Taken all but the ARM patches.

These need to be reviewed and go in via ARM-SoC.

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-iio-input-v5.1

for you to fetch changes up to 81cdab79818988d27d8aeb162b7988c9e6dde936:

  iio: adc: add STMPE ADC devicetree bindings (2019-01-16 12:37:36 +0000)

----------------------------------------------------------------
Immutable branch between MFD, IIO and Input due for the v5.1 merge window

----------------------------------------------------------------
Philippe Schenker (3):
      dt-bindings: stmpe: Reformatting parameter list and use tabs only
      mfd: stmpe: Move ADC related defines to MFD header
      Input: stmpe-ts: preparations for STMPE ADC driver

Stefan Agner (3):
      mfd: stmpe: Preparations for STMPE ADC driver
      iio: adc: add STMPE ADC driver using IIO framework
      iio: adc: add STMPE ADC devicetree bindings

 .../devicetree/bindings/iio/adc/stmpe-adc.txt      |  21 ++
 .../bindings/input/touchscreen/stmpe.txt           | 116 +++++--
 Documentation/devicetree/bindings/mfd/stmpe.txt    |  28 +-
 drivers/iio/adc/Kconfig                            |   7 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/stmpe-adc.c                        | 363 +++++++++++++++++++++
 drivers/input/touchscreen/stmpe-ts.c               |  66 +---
 drivers/mfd/Kconfig                                |   3 +-
 drivers/mfd/stmpe.c                                |  68 ++++
 include/linux/mfd/stmpe.h                          |  21 ++
 10 files changed, 610 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
 create mode 100644 drivers/iio/adc/stmpe-adc.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
