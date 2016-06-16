From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Thu, 16 Jun 2016 20:14:25 +0100
Message-ID: <CACxGe6vBwiRLgp=Tad8OtxOast2WGNOkEyN9Wq2bBRj_NhBWvA@mail.gmail.com>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35177 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256AbcFPTOq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2016 15:14:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id k184so13622994wme.2
        for <linux-input@vger.kernel.org>; Thu, 16 Jun 2016 12:14:45 -0700 (PDT)
In-Reply-To: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, benjamin.tissoires@redhat.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-iio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, chaya.golan@intel.com, daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be

On Sat, Jun 11, 2016 at 1:13 PM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> Starting from Cherrytrail, multiple generation of Intel processors offers
> on package sensor hub. Several recent tablets, 2-in-1 convertible laptops
> are using ISH instead of external sensor hubs. This resulted in lack of
> support of sensor function like device rotation and auto backlight
> adjustment.
> In addition, depending on the OEM implementation, support of ISH is required
> to support low power sleep states.
>
> The support of ISH on Linux platforms is not new. Android platforms with
> Intel SoCs had this support for a while submitted by Daniel Drubin.
> This patcheset is reusing most of those changes with  clean up and
> removing Android platform specific changes.
>
> The user mode ABI is still same as external sensor hubs using Linux
> IIO. So existing user mode software should still work.
> This series primarily brings in new HID transport used in ISH.
>
> Thanks to the community members who tested RFC patches and provided
> feedback.
>
> For users testing on Linux distributions using IIO sensor proxy,
> a short term work around is required till we have debugged this issue.
> In systemd unit file iio-sensor-proxy.service
> In the section "[Unit]" add
> After=multi-user.target

Tested-by: Grant Likely <grant.likely@hpe.com>

There is still a fiddly problem on my laptop where the sensor data
doesn't always start streaming, but otherwise this version works for
me.

g.

>
> Daniel Drubin (3):
>   hid: intel_ish-hid: ISH Transport layer
>   hid: intel-ish-hid: ipc layer
>   hid: intel-ish-hid: ISH HID client driver
>
> Srinivas Pandruvada (3):
>   Documentation: hid: Intel ISH HID document
>   iio: hid-sensors: use asynchronous resume
>   hid: hid-sensor-hub: Add ISH quirk
>
>  Documentation/hid/intel-ish-hid.txt                |  417 ++++++++
>  drivers/hid/Kconfig                                |    2 +
>  drivers/hid/Makefile                               |    2 +
>  drivers/hid/hid-sensor-hub.c                       |    4 +
>  drivers/hid/intel-ish-hid/Kconfig                  |   27 +
>  drivers/hid/intel-ish-hid/Makefile                 |   20 +
>  drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h        |  220 ++++
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h             |   70 ++
>  drivers/hid/intel-ish-hid/ipc/ipc.c                |  720 +++++++++++++
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  305 ++++++
>  drivers/hid/intel-ish-hid/ipc/utils.h              |   64 ++
>  drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  922 ++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp-hid.c              |  231 ++++
>  drivers/hid/intel-ish-hid/ishtp-hid.h              |  182 ++++
>  drivers/hid/intel-ish-hid/ishtp/bus.c              |  774 ++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/bus.h              |  105 ++
>  drivers/hid/intel-ish-hid/ishtp/client.c           | 1129 ++++++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/client.h           |  194 ++++
>  drivers/hid/intel-ish-hid/ishtp/dma-if.c           |  178 +++
>  drivers/hid/intel-ish-hid/ishtp/hbm.c              |  911 ++++++++++++++++
>  drivers/hid/intel-ish-hid/ishtp/hbm.h              |  319 ++++++
>  drivers/hid/intel-ish-hid/ishtp/init.c             |   94 ++
>  drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |  280 +++++
>  .../iio/common/hid-sensors/hid-sensor-trigger.c    |   21 +-
>  include/linux/hid-sensor-hub.h                     |    1 +
>  include/trace/events/intel_ish.h                   |   30 +
>  include/uapi/linux/input.h                         |    1 +
>  27 files changed, 7222 insertions(+), 1 deletion(-)
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
> 2.5.5
>
