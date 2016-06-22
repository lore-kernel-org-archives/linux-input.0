From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 0/6] Intel Integrated Sensor Hub Support (ISH)
Date: Tue, 21 Jun 2016 22:40:32 -0700
Message-ID: <1466574038-20613-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, jic23@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Change log
v2:
- Overview in documentation show analogy with usbhid implementation
- sparse errors for statics. Also pointed by Jiri
- Clearly marking exported function header file. Clean up all exports
unused inteface functions
- Changed to tristate from boolean as pointed by Jiri:
this required remove/unload functions
- Prevent crash when ISH enabled on non supported platform
- Break client.c to smaller part by seprating buffer allocations
- move bus register/unregister to ishtp module
- There is only one config symbol INTEL_ISH_HID, removed silent
config for TRANSPORT and IPC


Starting from Cherrytrail, multiple generation of Intel processors offers
on package sensor hub. Several recent tablets, 2-in-1 convertible laptops
are using ISH instead of external sensor hubs. This resulted in lack of
support of sensor function like device rotation and auto backlight
adjustment.
In addition, depending on the OEM implementation, support of ISH is required
to support low power sleep states.

The support of ISH on Linux platforms is not new. Android platforms with
Intel SoCs had this support for a while submitted by Daniel Drubin. 
This patcheset is reusing most of those changes with  clean up and
removing Android platform specific changes.

The user mode ABI is still same as external sensor hubs using Linux
IIO. So existing user mode software should still work.
This series primarily brings in new HID transport used in ISH.

Thanks to the community members who tested RFC patches and provided
feedback.

For users testing on Linux distributions using IIO sensor proxy,
a short term work around is required till we have debugged this issue.
In systemd unit file iio-sensor-proxy.service
In the section "[Unit]" add
After=multi-user.target

Daniel Drubin (3):
  hid: intel_ish-hid: ISH Transport layer
  hid: intel-ish-hid: ipc layer
  hid: intel-ish-hid: ISH HID client driver

Srinivas Pandruvada (3):
  Documentation: hid: Intel ISH HID document
  iio: hid-sensors: use asynchronous resume
  hid: hid-sensor-hub: Add ISH quirk

 Documentation/hid/intel-ish-hid.txt                | 449 ++++++++++
 drivers/hid/Kconfig                                |   2 +
 drivers/hid/Makefile                               |   2 +
 drivers/hid/hid-sensor-hub.c                       |   4 +
 drivers/hid/intel-ish-hid/Kconfig                  |  17 +
 drivers/hid/intel-ish-hid/Makefile                 |  22 +
 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h        | 220 +++++
 drivers/hid/intel-ish-hid/ipc/hw-ish.h             |  71 ++
 drivers/hid/intel-ish-hid/ipc/ipc.c                | 719 ++++++++++++++++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            | 327 +++++++
 drivers/hid/intel-ish-hid/ipc/utils.h              |  64 ++
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       | 935 +++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp-hid.c              | 234 ++++++
 drivers/hid/intel-ish-hid/ishtp-hid.h              | 182 ++++
 drivers/hid/intel-ish-hid/ishtp/bus.c              | 780 +++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h              | 110 +++
 drivers/hid/intel-ish-hid/ishtp/client-buffers.c   | 214 +++++
 drivers/hid/intel-ish-hid/ishtp/client.c           | 935 +++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.h           | 182 ++++
 drivers/hid/intel-ish-hid/ishtp/dma-if.c           | 178 ++++
 drivers/hid/intel-ish-hid/ishtp/hbm.c              | 908 ++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/hbm.h              | 321 +++++++
 drivers/hid/intel-ish-hid/ishtp/init.c             |  93 ++
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        | 277 ++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |  21 +-
 include/linux/hid-sensor-hub.h                     |   1 +
 include/trace/events/intel_ish.h                   |  30 +
 include/uapi/linux/input.h                         |   1 +
 28 files changed, 7298 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/intel-ish-hid.txt
 create mode 100644 drivers/hid/intel-ish-hid/Kconfig
 create mode 100644 drivers/hid/intel-ish-hid/Makefile
 create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish-regs.h
 create mode 100644 drivers/hid/intel-ish-hid/ipc/hw-ish.h
 create mode 100644 drivers/hid/intel-ish-hid/ipc/ipc.c
 create mode 100644 drivers/hid/intel-ish-hid/ipc/pci-ish.c
 create mode 100644 drivers/hid/intel-ish-hid/ipc/utils.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid-client.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp-hid.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/bus.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/client-buffers.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/client.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/dma-if.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/hbm.h
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/init.c
 create mode 100644 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h
 create mode 100644 include/trace/events/intel_ish.h

-- 
2.5.5
