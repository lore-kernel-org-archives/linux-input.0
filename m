From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 0/9 v2] constify thermal_zone_of_device_ops structures
Date: Fri, 11 Aug 2017 07:17:06 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1708110716270.2204@hadrien>
References: <1502204943-20075-1-git-send-email-Julia.Lawall@lip6.fr> <1502422611.2598.19.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-634072267-1502428627=:2204"
Return-path: <linux-hwmon-owner@vger.kernel.org>
In-Reply-To: <1502422611.2598.19.camel@intel.com>
Sender: linux-hwmon-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, linux-rpi-kernel@lists.infradead.org, bhumirks@gmail.com, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, linux-hwmon@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--8323329-634072267-1502428627=:2204
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Fri, 11 Aug 2017, Zhang Rui wrote:

> On Tue, 2017-08-08 at 17:08 +0200, Julia Lawall wrote:
> > The thermal_zone_of_device_ops structures are only passed as the
> > fourth
> > argument to thermal_zone_of_sensor_register or
> > devm_thermal_zone_of_sensor_register, both of which are declared as
> > const.
> > Thus the thermal_zone_of_device_ops structures themselves can be
> > const.
> >
> > v2: add structures passed to devm_thermal_zone_of_sensor_register
> > also.
> >
> > Done with the help of Coccinelle.
> >
> I don't see the patches changes out of drivers/thermal.
>
> As there is no dependencies between these patches, I guess I will only
> take patches that changes drivers/thermal.

No dependencies.  Each individual patch was only sent to its maintainers.

julia

>
> thanks,
> rui
> > ---
> >
> >  drivers/hwmon/hwmon.c                      |    2 +-
> >  drivers/hwmon/scpi-hwmon.c                 |    2 +-
> >  drivers/input/touchscreen/sun4i-ts.c       |    2 +-
> >  drivers/thermal/broadcom/bcm2835_thermal.c |    2 +-
> >  drivers/thermal/hisi_thermal.c             |    2 +-
> >  drivers/thermal/qoriq_thermal.c            |    2 +-
> >  drivers/thermal/rcar_gen3_thermal.c        |    2 +-
> >  drivers/thermal/samsung/exynos_tmu.c       |    2 +-
> >  drivers/thermal/zx2967_thermal.c           |    2 +-
> >  9 files changed, 9 insertions(+), 9 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--8323329-634072267-1502428627=:2204--
