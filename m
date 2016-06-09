From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Thu, 09 Jun 2016 14:54:47 -0700
Message-ID: <1465509287.24319.3.camel@linux.intel.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:54576 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbcFIVxL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jun 2016 17:53:11 -0400
In-Reply-To: <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>

Hi,
On Thu, 2016-06-09 at 22:45 +0100, Grant Likely wrote:
> On Tue, May 31, 2016 at 5:27 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >=20
> > Starting from Cherrytrail, multiple generation of Intel processors
> > offers
> > on package sensor hub. Several recent tablets, 2-in-1 convertible
> > laptops
> > are using ISH instead of external sensor hubs. This resulted in
> > lack of
> > support of sensor function like device rotation and auto backlight
> > adjustment. In addition, depending on the OEM implementation,
> > support of ISH
> > is required to support low power sleep states.
> >=20
> > The support of ISH on Linux platforms is not new. Android platforms
> > with
> > Intel SoCs had this support for a while submitted by Daniel Drubin.
> > This patcheset is reusing most of those changes with=C2=A0=C2=A0cle=
an up and
> > removing Android platform specific changes.
> Hi Srinivas,
>=20
> Thanks for this patch series. I've got an HP Spectre x360 G2
> (skylake), and I've built a 4.6.0 kernel with this driver patched in.
> It detects the sensors hub, and creates IIO devices under
> /sys/bus/iio/devices:
>=20
> $ ls /sys/bus/iio/devices/
> iio:device0=C2=A0=C2=A0iio:device1=C2=A0=C2=A0iio:device2=C2=A0=C2=A0=
iio:device3=C2=A0=C2=A0iio:device4
> iio:device5=C2=A0=C2=A0iio:device6=C2=A0=C2=A0iio:device7=C2=A0=C2=A0=
iio:device8=C2=A0=C2=A0iio:device9
> trigger0=C2=A0=C2=A0trigger1=C2=A0=C2=A0trigger2=C2=A0=C2=A0trigger3=C2=
=A0=C2=A0trigger4=C2=A0=C2=A0trigger5=C2=A0=C2=A0trigger6
> trigger7=C2=A0=C2=A0trigger8=C2=A0=C2=A0trigger9
>=20
> However, I haven't figured out how to test it yet. (This is the first
> time I'm working with IIO). Do you have any test code or test
> procedures to show if it is working?
>=20
If you use Fedora 23 (or any distro with iio-sensor-proxy with gnome
rotation stuff), you should be able to do screen rotation and
brightness using ALS.
Each of these folders should have some raw sysfs files=C2=A0
in_xxx_raw_xx

You should be able to use "cat" on them.

Thanks,
Srinivas


> Thanks,
> g.
>=20
> >=20
> >=20
> > This series is tested on:
> > - Lenovo Yoga 260 with Skylake processor
> > - HP Pavilion x2 detachable with Cherrytrail
> >=20
> > The user mode ABI is still same as external sensor hubs using Linux
> > IIO. So existing user mode software should still work without
> > change.
> > This series primarily brings in new HID transport used in ISH.
> >=20
> > This series submitted as a RFC to try on several devices. We have
> > received request from Linux users who wanted this support. So I
> > hope all
> > those users try and give feedback.
> >=20
> > Daniel Drubin (3):
> > =C2=A0 hid: intel_ish-hid: ISH Transport layer
> > =C2=A0 hid: intel-ish-hid: ipc layer
> > =C2=A0 hid: intel-ish-hid: ISH HID client driver
> >=20
> > Srinivas Pandruvada (1):
> > =C2=A0 Documentation: hid: Intel ISH HID document
> >=20
> > =C2=A0Documentation/hid/intel-ish-hid.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0375 +++++++++
> > =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A02 +
> > =C2=A0drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0=C2=A02 +
> > =C2=A0drivers/hid/intel-ish-hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A027 +
> > =C2=A0drivers/hid/intel-ish-hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A020 +
> > =C2=A0drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h=C2=A0=C2=A0|=C2=A0=
=C2=A0220 +++++
> > =C2=A0drivers/hid/intel-ish-hid/ipc/hw-ish.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A071 ++
> > =C2=A0drivers/hid/intel-ish-hid/ipc/ipc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0710
> > ++++++++++++++++
> > =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A0238 ++++++
> > =C2=A0drivers/hid/intel-ish-hid/ipc/utils.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A065 ++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c |=C2=A0=C2=A0672
> > +++++++++++++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0201 +++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp-hid.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0157 ++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0670
> > +++++++++++++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A099 +++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/client.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0| 1131
> > ++++++++++++++++++++++++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/client.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0196 +++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/dma-if.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A0175 ++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/hbm.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0911
> > +++++++++++++++++++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/hbm.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0319 ++++++++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/init.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A094 +++
> > =C2=A0drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h=C2=A0=C2=A0|=C2=A0=
=C2=A0276 +++++++
> > =C2=A0include/trace/events/intel_ish.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A030 +
> > =C2=A023 files changed, 6661 insertions(+)
> > =C2=A0create mode 100644 Documentation/hid/intel-ish-hid.txt
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/Kconfig
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/Makefile
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.=
h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client=
=2Ec
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
> > =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.=
h
> > =C2=A0create mode 100644 include/trace/events/intel_ish.h
> >=20
> > --
> > 1.9.1
> >=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
