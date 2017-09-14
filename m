From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 2/8] mfd: wm97xx-core: core support for wm97xx Codec
Date: Thu, 14 Sep 2017 08:43:00 +0100
Message-ID: <20170914074300.iobuwn2hrmnf6sen@dell>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170914074146.dnibkvom4yuzejf3@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, 14 Sep 2017, Lee Jones wrote:

> On Wed, 13 Sep 2017, Robert Jarzmik wrote:
> 
> > The WM9705, WM9712 and WM9713 are highly integrated codecs, with an
> > audio codec, DAC and ADC, GPIO unit and a touchscreen interface.
> > 
> > Historically the support was spread across drivers/input/touchscreen and
> > sound/soc/codecs. The sharing was done through ac97 bus sharing. This
> > model will not withstand the new AC97 bus model, where codecs are
> > discovered on runtime.
> > 
> > Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> > Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > Since v3:
> >  - added a "depends on AC97_BUS_NEW" Kconfig statement
> >  - added default values for wm9705, wm9712 per Charles's comment
> > Since v4:
> >  - added Charles's ack
> > Since v5:
> >  - took into account Lee's comments
> > Since v6:
> >  - took into account Lee's comments
> > ---
> >  drivers/mfd/Kconfig        |  14 ++
> >  drivers/mfd/Makefile       |   1 +
> >  drivers/mfd/wm97xx-core.c  | 366 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/wm97xx.h |  25 ++++
> >  4 files changed, 406 insertions(+)
> >  create mode 100644 drivers/mfd/wm97xx-core.c
> >  create mode 100644 include/linux/mfd/wm97xx.h
> 
> Applied, thanks.

Change of plan.  It looks like there are deps.

Unapplied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
