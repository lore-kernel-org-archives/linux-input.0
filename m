From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 00/10] HID: intel-ish-hid: Clean up external interfaces
Date: Mon, 18 Mar 2019 12:14:18 -0700
Message-ID: <20190318191428.6527-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

NOT FOR kernel v5.1.

v2
- Rebased on the top of
"HID: intel-ish: enable raw interface to HID devices on ISH"
which Jiri already applied.
- Also exported devc pointer for DMA

No functional changes are expected with this series. I am posting this now
because of usage of ISH in ChromeOS Embedded Controller.
https://lkml.org/lkml/2019/2/24/26
I want to make sure that API is restricted before more development and posting
there.

Currently only one ISH client is using ISH transport. But it is changing now
with the development of other clients using ISH transport. Some of these
clients which are targeted for Linux based OS only laptops, are not using
HID to export sensors. As more clients are getting developed it is important
that the external interface for ISH transport only allows what clients need.
Currently the header files used by clients "client.h" and "ishtp-dev.h"
include other ISH header files. Also clients access fields from structure
which also has other fields which are only used by ISH transort.

So this series introduces one header file "linux/intel-ish-client-if.h".
This header files doesn't include any other ISH transport header files.
There are interface functions defined so that clients never have to directly
access any ISH transort structures.
Also clients don't have to match there GUID in probe. They will be only
probbed if their GUID matches, which is passed as driver registry. 


Hong Liu (1):
  HID: intel-ish-hid: Add match callback to ishtp bus type

Srinivas Pandruvada (9):
  HID: intel-ish-hid: Hide members of struct ishtp_cl_device
  HID: intel-ish-hid: Simplify ishtp_cl_link()
  HID: intel-ish-hid: Move driver registry functions
  HID: intel-ish-hid: Store ishtp_cl_device instance in device
  HID: intel-ish-hid: Move the common functions from client.h
  HID: intel-ish-hid: Add interface functions for struct ishtp_cl
  HID: intel-ish-hid: Move functions related to bus and device
  HID: intel-ish-hid: Use the new interface functions in HID ish client
  HID: intel-ish-hid: Add interface function for PCI device pointer

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 131 ++++++++++---------
 drivers/hid/intel-ish-hid/ishtp-hid.c        |   6 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |   6 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c        |  96 +++++++++++++-
 drivers/hid/intel-ish-hid/ishtp/bus.h        |  37 +-----
 drivers/hid/intel-ish-hid/ishtp/client.c     |  60 +++++++--
 drivers/hid/intel-ish-hid/ishtp/client.h     |  24 ----
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  31 -----
 include/linux/intel-ish-client-if.h          | 112 ++++++++++++++++
 9 files changed, 325 insertions(+), 178 deletions(-)
 create mode 100644 include/linux/intel-ish-client-if.h

-- 
2.17.2
