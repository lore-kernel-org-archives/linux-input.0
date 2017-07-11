From: =?UTF-8?B?6rmA7YOc7JiB?= <ktyrun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: add support for HiDeep touchscreen
Date: Tue, 11 Jul 2017 17:01:47 +0900
Message-ID: <CA+d1ZXLAVrWHpgOzQMtWzPN9kz0=EdAxa7gKE=UxMbzVms3Npg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

2017-07-10 10:17 GMT+09:00 Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
>
> On Wed, Jul 05, 2017 at 03:19:48PM +0900, Anthony Kim wrote:
> > The HiDeep touchscreen device is a capacitive multi-touch controller
> > mainly for multi-touch supported devices use. It use I2C interface for
> > communication to IC and provide axis X, Y, Z locations for ten finger
> > touch through input event interface to userspace.
> >
> > It support the Crimson and the Lime two type IC. They are different
> > the number of channel supported and FW size. But the working protocol
> > is same.
> >
> > Signed-off-by: Anthony Kim <anthony.kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
> > ---
> >  .../bindings/input/touchscreen/hideep.txt          |   40 +
> >  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
> >  drivers/input/touchscreen/Kconfig                  |   32 +
> >  drivers/input/touchscreen/Makefile                 |    2 +
> >  drivers/input/touchscreen/hideep.h                 |  338 +++++++
> >  drivers/input/touchscreen/hideep_core.c            | 1029 ++++++++++++++++++++
> >  drivers/input/touchscreen/hideep_dbg.c             |  405 ++++++++
> >  drivers/input/touchscreen/hideep_dbg.h             |   24 +
> >  drivers/input/touchscreen/hideep_isp.c             |  584 +++++++++++
> >  drivers/input/touchscreen/hideep_isp.h             |   96 ++
> >  drivers/input/touchscreen/hideep_sysfs.c           |  249 +++++
> >  11 files changed, 2800 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> >  create mode 100644 drivers/input/touchscreen/hideep.h
> >  create mode 100644 drivers/input/touchscreen/hideep_core.c
> >  create mode 100644 drivers/input/touchscreen/hideep_dbg.c
> >  create mode 100644 drivers/input/touchscreen/hideep_dbg.h
> >  create mode 100644 drivers/input/touchscreen/hideep_isp.c
> >  create mode 100644 drivers/input/touchscreen/hideep_isp.h
> >  create mode 100644 drivers/input/touchscreen/hideep_sysfs.c
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/hideep.txt b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> > new file mode 100644
> > index 0000000..f5ab5e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/hideep.txt
> > @@ -0,0 +1,40 @@
> > +* HiDeep Finger and Stylus touchscreen controller
> > +
> > +Required properties:
> > +- compatible         : must be "hideep,hideep_ts".
>
> s/_/-/
>
> Is there only 1 version or another way to determine the exact chip and
> firmware? If not, then you need a more specific compatible.

Yes, we have to determine the chip and firmware through the firmware file name
 and reading I2C about info.
Also the chip can select by kernel config.

>
> > +- reg                        : I2C slave address, (e.g. 0x6C).
> > +- hideep,max_coords  : Max value for axis X, Y, W, Z.
> > +
> > +Optional properties:
> > +- pinctrl-names      : "reset_down", "reset-up", "intb-ctrl".
> > +                             They are gpio pinctrl names for should be search in driver code.
> > +- pinctrl-0  : Gpio control for "reset-down".
> > +- pinctrl-1  : Gpio control for "reset-up".
> > +- pinctrl-2  : Gpio control for "intb-ctrl".
> > +- hideep,regulator_vdd       : Main voltage(3.3V) name.
> > +- hideep,regulator_vid       : IO voltage(1.8V) name.
>
> Use standard regulator binding.
>
> > +- hideep,irq_gpio            : Define for interrupt gpio pin.
> > +                                             It is to use for set interrupt type.
>
> Use interrupt binding.
>
> > +- hideep,reset_gpio          : Define for reset gpio pin.
> > +                                             It is to use for reset IC.
>
> reset-gpios is the standard name.
>
> > +
> > +Example:
> > +
> > +i2c@00000000 {
> > +
> > +     /* ... */
> > +
> > +     hideep@6c {
>
> touchscreen@6c
>
> > +             compatible = "hideep,hideep_ts";
> > +             reg = <0x6c>;
> > +             pinctrl-names = "reset-down", "reset-up", "intb-ctrl";
> > +             pinctrl-0 = <&reset_gpio0>;
> > +             pinctrl-1 = <&reset_gpio1>;
> > +             pinctrl-2 = <&touch_int>;
> > +             hideep,regulator_vdd = "vdd_ldo33";     // need modify
> > +             hideep,regulator_vid = "vdd_ldo18";     // need modify
> > +             hideep,irq_gpio = <&gpx0 5 0x0>;        // <gpio-name gpio-num gpio-val> need modify
> > +             hideep,reset_gpio = <&gpa0 5 0x1>;      // <gpio-name gpio-num gpio-val> need modify
> > +             hideep,max_coords = <1080 1920 65535 65535>;    // x y w z, need modify
>
> Not documented. Probably should be standard touchscreen properties.
>
> > +     };
> > +};

Thank you for your comments.
I will resend patch to modified.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
