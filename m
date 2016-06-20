From: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Date: Mon, 20 Jun 2016 15:19:54 +0100
Message-ID: <20160620151954.0c9094db@lxorguk.ukuu.org.uk>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	<alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
	<1466197963.24319.110.camel@linux.intel.com>
	<alpine.LNX.2.00.1606201129060.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.1606201129060.6874-YHPUNQjx9ReKbouaWp301Q@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, chaya.golan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.drubin-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, A.Bhattacharya-pDTOvDb+uMmzQB+pC5nmwQ@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 20 Jun 2016 11:29:28 +0200 (CEST)
Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Fri, 17 Jun 2016, Srinivas Pandruvada wrote:
>=20
> > > > +config INTEL_ISH_HID_TRANSPORT
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n
> > > > +
> > > > +config INTEL_ISH_HID
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Intel Integrated Sensor Hu=
b" =20
> > >=20
> > > Why can't the transport driver be built as a module? =20
> > In current use case for PM, we don't want anyone to unload and
> > complain. =20
>=20
> Sorry, I don't understand this explanation, could you please elaborat=
e?

If the driver isn't loaded your machine doesn't do power management.
There are a small set of drivers that need to be loaded to get pm even =
if
not using that device. ISH is one of them, and unlike the others not
sucked into a standard configuration.

If it's going to get loaded due to the presence of the PCI identifiers =
on
any normal distribution then it's in the same category as graphics and
ADSP based audio, both of which can be modules and the only real world
impact is they get loaded a second or two later during boot.

Alan
