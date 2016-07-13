From: Atri Bhattacharya <badshah400@aim.com>
Subject: Re: [PATCH v3 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Wed, 13 Jul 2016 21:35:56 +0200
Message-ID: <1468438556.12968.8.camel__13152.2292657339$1468443073$gmane$org@aim.com>
References: <1467831078-2530-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39135 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcGMUuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 16:50:52 -0400
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1bNR7E-0005H6-PV
	for linux-input@vger.kernel.org; Wed, 13 Jul 2016 22:50:44 +0200
In-Reply-To: <1467831078-2530-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <public-srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@plane.gmane.org>, public-jikos-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org, public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org
Cc: public-linux-input-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org, public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org




Dear Srinivas,
This patchset works great on my system (YOGA ThinkPad 260)! The only
issue I see is that adaptive screen-rotation/brightness via iio-sensor-
proxy does not work straightaway from boot, instead it works after a
first suspend and wake-up. This is despite

~> cat /usr/lib/systemd/system/iio-sensor-proxy.service=C2=A0
[Unit]
Description=3DIIO Sensor Proxy service
After=3Dmulti-user.target
=2E..

But, this might be the by-now well-known issue:
https://github.com/hadess/iio-sensor-proxy/issues/66
but as I have reported earlier that, with previous patchset versions
and the same configuration, this was working right off a cold boot.

Thanks and best wishes.

On Wed, 2016-07-06 at 11:51 -0700, Srinivas Pandruvada wrote:
> Change log
> v3:
> - Rebased to linux-next as there are some new bus ids are added to
> linux-next
> - Documentation changes suggested by Jonathan
> - The PCI device name for BXTP is changed to APL
> - Added module parameter to enable DMA as some older FW
> have issues in DMA support.
> - On resume just restart to resume faster insted of reset for
> S3 compliant platforms
>=20
> Thanks to Grant Likely and Atri Bhattacharya for test.=C2=A0
> I will add Tested-by to commits for the final version of the patches.
>=20
> v2:
> - Overview in documentation show analogy with usbhid implementation
> - sparse errors for statics. Also pointed by Jiri
> - Clearly marking exported function header file. Clean up all exports
> unused inteface functions
> - Changed to tristate from boolean as pointed by Jiri:
> this required remove/unload functions
> - Prevent crash when ISH enabled on non supported platform
> - Break client.c to smaller part by seprating buffer allocations
> - move bus register/unregister to ishtp module
> - There is only one config symbol INTEL_ISH_HID, removed silent
> config for TRANSPORT and IPC
>=20
>=20
> Starting from Cherrytrail, multiple generation of Intel processors
> offers
> on package sensor hub. Several recent tablets, 2-in-1 convertible
> laptops
> are using ISH instead of external sensor hubs. This resulted in lack
> of
> support of sensor function like device rotation and auto backlight
> adjustment.
> In addition, depending on the OEM implementation, support of ISH is
> required
> to support low power sleep states.
>=20
> The support of ISH on Linux platforms is not new. Android platforms
> with
> Intel SoCs had this support for a while submitted by Daniel Drubin.=C2=
=A0
> This patcheset is reusing most of those changes with=C2=A0=C2=A0clean=
 up and
> removing Android platform specific changes.
>=20
> The user mode ABI is still same as external sensor hubs using Linux
> IIO. So existing user mode software should still work.
> This series primarily brings in new HID transport used in ISH.
>=20
> Thanks to the community members who tested RFC patches and provided
> feedback.
>=20
> For users testing on Linux distributions using IIO sensor proxy,
> a short term work around is required till we have debugged this
> issue.
> In systemd unit file iio-sensor-proxy.service
> In the section "[Unit]" add
> After=3Dmulti-user.target
>=20
> Daniel Drubin (3):
> =C2=A0 hid: intel_ish-hid: ISH Transport layer
> =C2=A0 hid: intel-ish-hid: ipc layer
> =C2=A0 hid: intel-ish-hid: ISH HID client driver
>=20
> Srinivas Pandruvada (3):
> =C2=A0 Documentation: hid: Intel ISH HID document
> =C2=A0 iio: hid-sensors: use asynchronous resume
> =C2=A0 hid: hid-sensor-hub: Add ISH quirk
>=20
> =C2=A0Documentation/hid/intel-ish-hid.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 454=
 ++++++++++
> =C2=A0drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A0=C2=A02 +
> =C2=A0drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A02 +
> =C2=A0drivers/hid/hid-sensor-hub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A04 +
> =C2=A0drivers/hid/intel-ish-hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A017 +
> =C2=A0drivers/hid/intel-ish-hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
|=C2=A0=C2=A022 +
> =C2=A0drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 220 +++++
> =C2=A0drivers/hid/intel-ish-hid/ipc/hw-ish.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A071 ++
> =C2=A0drivers/hid/intel-ish-hid/ipc/ipc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 719
> ++++++++++++++++
> =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 332 ++++++++
> =C2=A0drivers/hid/intel-ish-hid/ipc/utils.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A06=
4 ++
> =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0| 935
> +++++++++++++++++++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp-hid.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 234 ++++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp-hid.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 182 ++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 794
> +++++++++++++++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/bus.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 113 +++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/client-buffers.c=C2=A0=C2=A0=C2=
=A0| 214 +++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/client.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 935
> +++++++++++++++++++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/client.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 182 ++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/dma-if.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 178 ++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/hbm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 912
> ++++++++++++++++++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/hbm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 321 +++++++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/init.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A093 ++
> =C2=A0drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0| 277 ++++++
> =C2=A0.../iio/common/hid-sensors/hid-sensor-trigger.c=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A021 +-
> =C2=A0include/linux/hid-sensor-hub.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A0include/trace/events/intel_ish.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A030 +
> =C2=A0include/uapi/linux/input.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 +
> =C2=A028 files changed, 7329 insertions(+), 1 deletion(-)
> =C2=A0create mode 100644 Documentation/hid/intel-ish-hid.txt
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/Kconfig
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/Makefile
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client-buffe=
rs.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
> =C2=A0create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
> =C2=A0create mode 100644 include/trace/events/intel_ish.h
>=20
--=20

Atri Bhattacharya
Wed 13 Jul 21:29:30 CEST 2016

Sent from openSUSE Tumbleweed (20160710) (x86_64) on my laptop.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
