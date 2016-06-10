From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Fri, 10 Jun 2016 06:55:04 -0700
Message-ID: <1465566904.10525.11.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
	 <1465509287.24319.3.camel@linux.intel.com>
	 <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACxGe6vq-FDpjG8WtrraveQo+ZT3MHMDFzrA5-qqNLEwcbmNhw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>
List-Id: linux-input@vger.kernel.org

On Fri, 2016-06-10 at 10:44 +0100, Grant Likely wrote:
[...]
>=20
> Yes, I do see the in_*_raw_* files in sysfs, and I'm able to get data
> out of them. Gnome also seems to recognize that the accelerometers
> are
> there because it adds a rotation lock button to the system menu.
>=20
> However, the events are getting through yet. It may be that I'm
> missing something in my kernel config. I'm rebuilding the kernel with
> Debian's config for the 4.5.5 kernel as a quick sanity test. I'll
> report back when I've tried.
>=20
You need to add in /usr/lib/system/systemd/iio-sensor-*

After=3Dmulti-user.target


This service starts too early.

> I'll also take some time and review the patch series later this
> afternoon.

Atri Bhattacharya reported issues with suspend/resume. With my test
patches it is fixed for him

If you want to hold on, I will repost with fixes for susend/resume.

Thanks,
Srinivas

>=20

> g.
>=20
> >=20
> > Thanks,
> > Srinivas
> >=20
> >=20
> > > Thanks,
> > > g.
> > >=20
> > > >=20
> > > >=20
> > > > This series is tested on:
> > > > - Lenovo Yoga 260 with Skylake processor
> > > > - HP Pavilion x2 detachable with Cherrytrail
> > > >=20
> > > > The user mode ABI is still same as external sensor hubs using
> > > > Linux
> > > > IIO. So existing user mode software should still work without
> > > > change.
> > > > This series primarily brings in new HID transport used in ISH.
> > > >=20
> > > > This series submitted as a RFC to try on several devices. We
> > > > have
> > > > received request from Linux users who wanted this support. So I
> > > > hope all
> > > > those users try and give feedback.
> > > >=20
> > > > Daniel Drubin (3):
> > > > =C2=A0 hid: intel_ish-hid: ISH Transport layer
> > > > =C2=A0 hid: intel-ish-hid: ipc layer
> > > > =C2=A0 hid: intel-ish-hid: ISH HID client driver
> > > >=20
> > > > Srinivas Pandruvada (1):
> > > > =C2=A0 Documentation: hid: Intel ISH HID document
> > > >=20
> > > > =C2=A0Documentation/hid/intel-ish-hid.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0375 +++++++++
> > > > =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A02=
 +
> > > > =C2=A0drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A02 +
> > > > =C2=A0drivers/hid/intel-ish-hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A027 +
> > > > =C2=A0drivers/hid/intel-ish-hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A020 +
> > > > =C2=A0drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h=C2=A0=C2=A0|=C2=
=A0=C2=A0220 +++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ipc/hw-ish.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A071 ++
> > > > =C2=A0drivers/hid/intel-ish-hid/ipc/ipc.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0710
> > > > ++++++++++++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0238 ++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ipc/utils.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A065 ++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c |=C2=A0=C2=A0=
672
> > > > +++++++++++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0201 +++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0157 ++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0670
> > > > +++++++++++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A099 +++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/client.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 1131
> > > > ++++++++++++++++++++++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/client.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A0196 +++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/dma-if.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A0175 ++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/hbm.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0911
> > > > +++++++++++++++++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/hbm.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0319 ++++++++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/init.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A094 +++
> > > > =C2=A0drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h=C2=A0=C2=A0|=C2=
=A0=C2=A0276 +++++++
> > > > =C2=A0include/trace/events/intel_ish.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A03=
0 +
> > > > =C2=A023 files changed, 6661 insertions(+)
> > > > =C2=A0create mode 100644 Documentation/hid/intel-ish-hid.txt
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/Kconfig
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/Makefile
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-r=
egs.h
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.=
c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-
> > > > client.c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client=
=2Ec
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client=
=2Eh
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if=
=2Ec
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
> > > > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-=
dev.h
> > > > =C2=A0create mode 100644 include/trace/events/intel_ish.h
> > > >=20
> > > > --
> > > > 1.9.1
> > > >=20
