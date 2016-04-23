From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: [PATCH V3 0/3] iio: mxs-lradc: simplify TS handling
Date: Sat, 23 Apr 2016 19:57:56 +0000
Message-ID: <1461441479-23218-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch series simplifies TS handling of mxs-lradc.

These patches has been tested with i.MX23 and i.MX28 but without
a touchscreen. I added only a bogus touchscreen in devicetree.

It would be nice if someone with a real touchscreen could test it.

Changes in V3:
- remove dev.parent assignment as suggested by Dimitry
- add new patch to remove mxs_lradc_ts_unregister
- remove PM implementation from series in order to wait until 
  Ksenija has split the driver

Changes in V2:
- rebase on iio/testing since patch 2 and 3 from V1 has been applied
- also remove input_unregister_device in patch 1
- use mask of virtual channels for IRQ disabling in patch 2

Stefan Wahren (3):
  iio: mxs-lradc: simplify TS registration
  iio: mxs-lradc: remove mxs_lradc_ts_unregister
  iio: mxs-lradc: disable only masked channels in     
    mxs_lradc_hw_stop

 drivers/iio/adc/mxs-lradc.c |   34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

-- 
1.7.9.5
