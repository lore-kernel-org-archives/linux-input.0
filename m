From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: am335x: IIO/ADC fixes if used together with TSC, v2
Date: Tue, 7 Jan 2014 08:54:56 +0000
Message-ID: <20140107085456.GD3182@lee--X1>
References: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387466911-3732-1-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dmitry, Jonathan,

This is for you.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e=
42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git tags/ib-iio-input-3.13-1

for you to fetch changes up to 7ca6740cd1cd410828a01151a044b51910d06eff=
:

  mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization (2014-01-=
07 08:45:00 +0000)

----------------------------------------------------------------
Immutable branch for IIO and Input

----------------------------------------------------------------
Sebastian Andrzej Siewior (5):
      iio: ti_am335x_adc: Adjust the closing bracket in tiadc_read_raw(=
)
      mfd: ti_am335x_tscadc: Make am335x_tsc_se_update() local
      mfd: ti_am335x_tscadc: Don't read back REG_SE
      mfd: ti_am335x: Drop am335x_tsc_se_update() from resume path
      mfd: input: iio: ti_amm335x: Rework TSC/ADC synchronization

 drivers/iio/adc/ti_am335x_adc.c           | 68 +++++++++++++++++++++++=
++++++++++++++++++++++++++-------------------
 drivers/input/touchscreen/ti_am335x_tsc.c |  4 ++--
 drivers/mfd/ti_am335x_tscadc.c            | 71 +++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++-----------
 include/linux/mfd/ti_am335x_tscadc.h      |  8 ++++++--
 4 files changed, 117 insertions(+), 34 deletions(-)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
