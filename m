From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC 0/4] Intel Integrated Sensor Hub Support (ISH)
Date: Thu, 9 Jun 2016 22:45:13 +0100
Message-ID: <CACxGe6udQ9H5_OBg+h8BB4Bru5Air0LYxtGQkUvr91ebtUE+SA@mail.gmail.com>
References: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464668878-17113-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, benjamin.tissoires@redhat.com, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, Darren Hart <darren@dvhart.com>
List-Id: linux-input@vger.kernel.org

On Tue, May 31, 2016 at 5:27 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Starting from Cherrytrail, multiple generation of Intel processors offers
> on package sensor hub. Several recent tablets, 2-in-1 convertible laptops
> are using ISH instead of external sensor hubs. This resulted in lack of
> support of sensor function like device rotation and auto backlight
> adjustment. In addition, depending on the OEM implementation, support of ISH
> is required to support low power sleep states.
>
> The support of ISH on Linux platforms is not new. Android platforms with
> Intel SoCs had this support for a while submitted by Daniel Drubin.
> This patcheset is reusing most of those changes with  clean up and
> removing Android platform specific changes.

Hi Srinivas,

Thanks for this patch series. I've got an HP Spectre x360 G2
(skylake), and I've built a 4.6.0 kernel with this driver patched in.
It detects the sensors hub, and creates IIO devices under
/sys/bus/iio/devices:

$ ls /sys/bus/iio/devices/
iio:device0  iio:device1  iio:device2  iio:device3  iio:device4
iio:device5  iio:device6  iio:device7  iio:device8  iio:device9
trigger0  trigger1  trigger2  trigger3  trigger4  trigger5  trigger6
trigger7  trigger8  trigger9

However, I haven't figured out how to test it yet. (This is the first
time I'm working with IIO). Do you have any test code or test
procedures to show if it is working?

Thanks,
g.

>
> This series is tested on:
> - Lenovo Yoga 260 with Skylake processor
> - HP Pavilion x2 detachable with Cherrytrail
>
> The user mode ABI is still same as external sensor hubs using Linux
> IIO. So existing user mode software should still work without change.
> This series primarily brings in new HID transport used in ISH.
>
> This series submitted as a RFC to try on several devices. We have
> received request from Linux users who wanted this support. So I hope all
> those users try and give feedback.
>
> Daniel Drubin (3):
>   hid: intel_ish-hid: ISH Transport layer
>   hid: intel-ish-hid: ipc layer
>   hid: intel-ish-hid: ISH HID client driver
>
> Srinivas Pandruvada (1):
>   Documentation: hid: Intel ISH HID document
>
>  Documentation/hid/intel-ish-hid.txt          |  375 +++++++++
>  drivers/hid/Kconfig                          |    2 +
>  drivers/hid/Makefile                         |    2 +
>  drivers/hid/intel-ish-hid/Kconfig            |   27 +
>  drivers/hid/intel-ish-hid/Makefile           |   20 +
>  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h  |  220 +++++
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h       |   71 ++
>  drivers/hid/intel-ish-hid/ipc/ipc.c          |  710 ++++++++++++++++
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c      |  238 ++++++
>  drivers/hid/intel-ish-hid/ipc/utils.h        |   65 ++
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c |  672 +++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp-hid.c        |  201 +++++
>  drivers/hid/intel-ish-hid/ishtp-hid.h        |  157 ++++
>  drivers/hid/intel-ish-hid/ishtp/bus.c        |  670 +++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/bus.h        |   99 +++
>  drivers/hid/intel-ish-hid/ishtp/client.c     | 1131 ++++++++++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/client.h     |  196 +++++
>  drivers/hid/intel-ish-hid/ishtp/dma-if.c     |  175 ++++
>  drivers/hid/intel-ish-hid/ishtp/hbm.c        |  911 +++++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/hbm.h        |  319 ++++++++
>  drivers/hid/intel-ish-hid/ishtp/init.c       |   94 +++
>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  276 +++++++
>  include/trace/events/intel_ish.h             |   30 +
>  23 files changed, 6661 insertions(+)
>  create mode 100644 Documentation/hid/intel-ish-hid.txt
>  create mode 100644 drivers/hid/intel-ish-hid/Kconfig
>  create mode 100644 drivers/hid/intel-ish-hid/Makefile
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
>  create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
>  create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
>  create mode 100644 include/trace/events/intel_ish.h
>
> --
> 1.9.1
>
