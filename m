From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/9] Input: sun4i-ts: Add thermal zone sensor support
Date: Fri, 9 Jan 2015 10:42:57 -0800
Message-ID: <20150109184257.GB39037@dtor-ws>
References: <1420798676-22856-1-git-send-email-wens@csie.org>
 <1420798676-22856-2-git-send-email-wens@csie.org>
 <20150109172318.GA39037@dtor-ws>
 <20150109183313.GA24190@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150109183313.GA24190@developer>
Sender: linux-pm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 09, 2015 at 02:33:15PM -0400, Eduardo Valentin wrote:
> Dmitry,
>=20
> On Fri, Jan 09, 2015 at 09:23:18AM -0800, Dmitry Torokhov wrote:
> > On Fri, Jan 09, 2015 at 06:17:48PM +0800, Chen-Yu Tsai wrote:
> > > The touchscreen controller has a temperature sensor embedded in t=
he SoC,
> > > which already has hwmon support in the driver.
> > >=20
> > > Add DT thermal zone support so we can use it with cpufreq for the=
rmal
> > > throttling.
> > >=20
> > > This also adds a comment stating that we do not know the actual f=
ormula
> > > for calculating the temperature.
> > >=20
> > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > ---
> >=20
> >=20
> >   CC [M]  drivers/input/touchscreen/sun4i-ts.o
> > drivers/input/touchscreen/sun4i-ts.c:208:15: error: variable
> > =E2=80=98sun4i_ts_tz_ops=E2=80=99 has initializer but incomplete ty=
pe
> >  static struct thermal_zone_of_device_ops sun4i_ts_tz_ops =3D {
> >                ^
> > drivers/input/touchscreen/sun4i-ts.c:209:2: error: unknown field
> > =E2=80=98get_temp=E2=80=99 specified in initializer
> >   .get_temp =3D get_temp,
> >   ^
> > drivers/input/touchscreen/sun4i-ts.c:209:2: warning: excess element=
s in
> > struct initializer [enabled by default]
> > drivers/input/touchscreen/sun4i-ts.c:209:2: warning: (near
> > initialization for =E2=80=98sun4i_ts_tz_ops=E2=80=99) [enabled by d=
efault]
> > drivers/input/touchscreen/sun4i-ts.c: In function =E2=80=98sun4i_ts=
_probe=E2=80=99:
> > drivers/input/touchscreen/sun4i-ts.c:331:8: warning: passing argume=
nt 4
> > of =E2=80=98thermal_zone_of_sensor_register=E2=80=99 from incompati=
ble pointer type
> > [enabled by default]
> >         &sun4i_ts_tz_ops);
> >         ^
> > In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
> > include/linux/thermal.h:302:1: note: expected =E2=80=98int (*)(void=
 *, long int
> > *)=E2=80=99 but argument is of type =E2=80=98struct thermal_zone_of=
_device_ops *=E2=80=99
> >  thermal_zone_of_sensor_register(struct device *dev, int id,
> >  ^
> > drivers/input/touchscreen/sun4i-ts.c:331:8: error: too few argument=
s to
> > function =E2=80=98thermal_zone_of_sensor_register=E2=80=99
> >         &sun4i_ts_tz_ops);
> >         ^
> > In file included from drivers/input/touchscreen/sun4i-ts.c:37:0:
> > include/linux/thermal.h:302:1: note: declared here
> >  thermal_zone_of_sensor_register(struct device *dev, int id,
> >  ^
> > make[1]: *** [drivers/input/touchscreen/sun4i-ts.o] Error 1
> > make: *** [drivers/input/touchscreen/sun4i-ts.o] Error 2
> >=20
>=20
> What kernel version are you using?
>=20
> It looks like you are missing the of thermal ops commit.

Ah, OK, I have not uprevved my branches with 3.19 stuff yet.

--=20
Dmitry
