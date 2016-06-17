From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Date: Fri, 17 Jun 2016 14:12:43 -0700
Message-ID: <1466197963.24319.110.camel@linux.intel.com>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: jic23@kernel.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, chaya.golan@intel.com, daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-17 at 22:43 +0200, Jiri Kosina wrote:
> On Sat, 11 Jun 2016, Srinivas Pandruvada wrote:
>=20
> [ ... snip ... ]
> > diff --git a/drivers/hid/intel-ish-hid/Kconfig b/drivers/hid/intel-
> ish-hid/Kconfig
> > new file mode 100644
> > index 0000000..8914f3b
> > --- /dev/null
> > +++ b/drivers/hid/intel-ish-hid/Kconfig
> > @@ -0,0 +1,22 @@
> > +menu "Intel ISH HID support"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on X86 && PCI
> > +
> > +config INTEL_ISH_HID_TRANSPORT
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default n
> > +
> > +config INTEL_ISH_HID
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Intel Integrated Sensor Hub"
>=20
> Why can't the transport driver be built as a module?
In current use case for PM, we don't want anyone to unload and
complain.
But if this is a strong requirement, I will change this to a module.

Thanks,
Srinivas

>=20
> [ ... snip ... ]
> > +/**
> > + * ishtp_bus_add_device() - Function to create device on bus
> > + *
> > + * @dev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ishtp device
> > + * @uuid:=C2=A0=C2=A0=C2=A0=C2=A0uuid of the client
> > + * @name:=C2=A0=C2=A0=C2=A0=C2=A0Name of the client
> > + *
> > + * Allocate ISHTP bus client device, attach it to uuid
> > + * and register with ISHTP bus.
> > + */
> > +struct ishtp_cl_device *ishtp_bus_add_device(struct ishtp_device
> *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uuid_le uuid, char
> *name)
> > +{
>=20
> Should be static.
>=20
> [ ... snip ... ]
> > +/**
> > + * ishtp_bus_remove_device() - Function to relase device on bus
> > + *
> > + * @device:=C2=A0=C2=A0client device instance
> > + *
> > + * This is a counterpart of ishtp_bus_add_device.
> > + * Device is unregistered.
> > + * the device structure is freed in 'ishtp_cl_dev_release'
> function
> > + * Called only during error in pci driver init path.
> > + */
> > +void ishtp_bus_remove_device(struct ishtp_cl_device *device)
> > +{
>=20
> Should be static.
>=20
> [ ... snip ... ]
> > +/*
> > + * ishtp_hbm_dma_xfer_ack - receive ack for ISHTP-over-DMA client
> message
> > + *
> > + * Constraint:
> > + * First implementation is one ISHTP message per DMA transfer
> > + */
> > +void ishtp_hbm_dma_xfer_ack(struct ishtp_device *dev,
>=20
> Should be static.
>=20
> [ ... snip ... ]
> > +/* ishtp_hbm_dma_xfer - receive ISHTP-over-DMA client message */
> > +void ishtp_hbm_dma_xfer(struct ishtp_device *dev,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dma_=
xfer_hbm *dma_xfer)
>=20
> Should be static.
>=20
> --=C2=A0
> Jiri Kosina
> SUSE Labs
>=20
