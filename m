From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH V4 3/3] mfd: da9063: MFD support for OnKey driver
Date: Tue, 9 Jun 2015 07:51:01 +0100
Message-ID: <20150609065101.GA2982@x1>
References: <cover.1432031565.git.stwiss.opensource@diasemi.com>
 <a508f5d715e94fb18e6ef4ce755c2225a17090ea.1432031565.git.stwiss.opensource@diasemi.com>
 <20150608232507.GB420@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150608232507.GB420@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: S Twiss <stwiss.opensource@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, DT <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, INPUT <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-input@vger.kernel.org

On Mon, 08 Jun 2015, Dmitry Torokhov wrote:

> On Tue, May 19, 2015 at 11:32:45AM +0100, S Twiss wrote:
> > From: Steve Twiss <stwiss.opensource@diasemi.com>
> >=20
> > Add MFD support for the DA9063 OnKey driver
> >=20
> > The function da9063_clear_fault_log() is added to mitigate the case=
 of a
> > hardware power-cut after a long-long OnKey press. Although there is=
 no
> > software intervention in this case (by definition) such a shutdown =
would
> > cause persistent information within the DA9063 FAULT_LOG that would=
 be
> > available during the next device restart.
> >=20
> > Clearance of this persistent register must be completed after such =
a
> > hardware power-cut operation has happened so that the FAULT_LOG doe=
s not
> > continue with previous values. The clearance function has been adde=
d here
> > in the kernel driver because wiping the fault-log cannot be counted=
 on
> > outside the Linux kernel.
> >=20
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> >=20
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> ...
>=20
> > diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/d=
a9063/pdata.h
> > index 95c8742..612383b 100644
> > --- a/include/linux/mfd/da9063/pdata.h
> > +++ b/include/linux/mfd/da9063/pdata.h
> > @@ -103,6 +103,7 @@ struct da9063;
> >  struct da9063_pdata {
> >  	int				(*init)(struct da9063 *da9063);
> >  	int				irq_base;
> > +	bool				key_power;
> >  	unsigned			flags;
> >  	struct da9063_regulators_pdata	*regulators_pdata;
> >  	struct led_platform_data	*leds_pdata;
>=20
> I need this bit of pdata to merge the OnKey driver... Lee, any chance
> you could drop it from the patch in your tree?

Consider it done.

> Alternatively, can you pick the OnKey driver (the latest version is
> below)?
>=20
> Thanks.
>=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
