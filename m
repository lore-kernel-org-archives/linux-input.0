From: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] mxs-lradc: Split driver into MFD
Date: Fri, 29 Apr 2016 13:46:14 +0200
Message-ID: <cover.1461930102.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Split existing driver mxs-lradc into MFD with touchscreen and
IIO part.

Tested on I.MX28.

Ksenija Stanojevic (3):
  mfd: mxs-lradc: Add support for mxs-lradc MFD
  iio: adc: mxs-lradc: Add support for adc driver
  input: touchscreen: mxs-lradc: Add support for touchscreen

 drivers/iio/adc/Kconfig                  |  37 +-
 drivers/iio/adc/Makefile                 |   1 +
 drivers/iio/adc/mxs-lradc-adc.c          | 832 +++++++++++++++++++++++++++++++
 drivers/input/touchscreen/Kconfig        |  14 +-
 drivers/input/touchscreen/Makefile       |   1 +
 drivers/input/touchscreen/mxs-lradc-ts.c | 729 +++++++++++++++++++++++++++
 drivers/mfd/Kconfig                      |  33 +-
 drivers/mfd/Makefile                     |   1 +
 drivers/mfd/mxs-lradc.c                  | 213 ++++++++
 include/linux/mfd/mxs-lradc.h            | 210 ++++++++
 10 files changed, 2049 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iio/adc/mxs-lradc-adc.c
 create mode 100644 drivers/input/touchscreen/mxs-lradc-ts.c
 create mode 100644 drivers/mfd/mxs-lradc.c
 create mode 100644 include/linux/mfd/mxs-lradc.h

-- 
1.9.1
