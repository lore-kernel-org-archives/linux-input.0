From: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Subject: Re: [PATCH v13 3/5] input: touchscreen: mxs-lradc: Add support for
 touchscreen
Date: Mon, 30 Jan 2017 00:55:09 +0100 (CET)
Message-ID: <1332233362.76422.1485734109212@email.1und1.de>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
 <d18975ff97a8855e9221b0a180b3664a0d04348c.1485711797.git.ksenija.stanojevic@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <d18975ff97a8855e9221b0a180b3664a0d04348c.1485711797.git.ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, harald-95f8Dae0BrPYtjvyW6yDsg@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Ksenija,

> Ksenija Stanojevic <ksenija.stanojevic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> hat am 29. Januar 2017 um 19:04 geschrieben:
> 
> 
> Add 4-wire/5-wire touchscreen controller.

i compiled all 3 driver as a module and kept the devicetree for the Olinuxino iMX233 [1] as it is (no touchscreen). After booting all 3 driver are loaded:

Module                  Size  Used by
mxs_lradc_adc          11000  0
industrialio_triggered_buffer     2628  1 mxs_lradc_adc
kfifo_buf               3337  1 industrialio_triggered_buffer
mxs_lradc_ts            4192  0
mxs_lradc               4402  0
mfd_core                4612  1 mxs_lradc

But the touchscreen driver threw this error:

[  427.230000] mxs-lradc-ts: probe of mxs-lradc-ts failed with error -22

I didn't expect this behavior. I expect that the touchscreen driver notice that there isn't a touchscreen property and abort probing silently. Also i didn't expected that the driver is still loaded in case of a probe error.

Btw shouldn't be the mxs_lradc_adc "Used by" mxs_lradc?

Because "modprobe -r mxs_lradc" doesn't unload mxs_lradc_adc.

[1] - http://lxr.free-electrons.com/source/arch/arm/boot/dts/imx23-olinuxino.dts
