From: Zhang Lixu <lixu.zhang@intel.com>
Subject: [PATCH v2 0/3] HID: intel-ish-hid: support s2idle and s3 in ish_suspend()
Date: Thu,  8 Aug 2019 18:21:10 +0800
Message-ID: <20190808102113.27802-1-lixu.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org, lixu.zhang@intel.com
List-Id: linux-input@vger.kernel.org

Currently, the NO_D3 flag is set in ish_probe(), the intel-ish-ipc driver
puts the ISH into D0i3 when system enter both suspend-to-idle(S0ix) and
suspend-to-mem(S3). These patches are to put the ISH into D3 when system
enter S3 and put the ISH into D0i3 when system enter S0ix.

I tested these patches on the following platforms:
ISH 5.2: ICL
ISH 5.0: CNL CFL WHL CML
ISH 4.0: GLK
ISH 3.0: KBL

Test steps:
* Run the IIO Sensor tool to read the accel_3d sensor data
* Run cmd "echo mem > /sys/power/state" to suspend-to-mem
* Press the keyboard to wake up OS.
* Check if the tool can get the sensor data after OS resume.
* Run cmd "echo freeze > /sys/power/state" to suspend-to-idle
* Press the keyboard to wake up OS.
* Check if the tool can get the sensor data after OS resume.

Test results:
The tool can get the accel_3d sensor data after resuming from both
suspend-to-mem and suspend-to-idle.

Changes from v1:
* Fix the indentation issue
* Elaborate the reason to remove the NO_D3 flag
* Split the PATCH v1 to three changes, and try to minimize the lines change

Zhang Lixu (3):
  HID: intel-ish-hid: ipc: set NO_D3 flag only when needed
  HID: intel-ish-hid: ipc: make ish suspend paths clear
  HID: intel-ish-hid: ipc: check the NO_D3 flag to distinguish resume
    paths

 drivers/hid/intel-ish-hid/ipc/hw-ish.h  |  1 +
 drivers/hid/intel-ish-hid/ipc/ipc.c     |  2 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 95 +++++++++++++++----------
 3 files changed, 61 insertions(+), 37 deletions(-)

-- 
2.17.1
