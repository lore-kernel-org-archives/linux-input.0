From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/9] HID: intel-ish-hid: Clean up external interfaces
Date: Sun,  3 Mar 2019 08:46:45 -0800
Message-ID: <20190303164654.29400-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

FOR kernel v5.2+.

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

Srinivas Pandruvada (8):
  HID: intel-ish-hid: Hide members of struct ishtp_cl_device
  HID: intel-ish-hid: Simplify ishtp_cl_link()
  HID: intel-ish-hid: Move driver registry functions
  HID: intel-ish-hid: Store ishtp_cl_device instance in device
  HID: intel-ish-hid: Move the common functions from client.h
  HID: intel-ish-hid: Add interface functions for struct ishtp_cl
  HID: intel-ish-hid: Move functions related to bus and device
  HID: intel-ish-hid: Use the new interface functions in HID ish client

 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 131 ++++++++++---------
 drivers/hid/intel-ish-hid/ishtp-hid.c        |   6 +-
 drivers/hid/intel-ish-hid/ishtp-hid.h        |   6 +-
 drivers/hid/intel-ish-hid/ishtp/bus.c        |  83 +++++++++++-
 drivers/hid/intel-ish-hid/ishtp/bus.h        |  37 +-----
 drivers/hid/intel-ish-hid/ishtp/client.c     |  60 +++++++--
 drivers/hid/intel-ish-hid/ishtp/client.h     |  24 ----
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h  |  31 -----
 include/linux/intel-ish-client-if.h          | 110 ++++++++++++++++
 9 files changed, 310 insertions(+), 178 deletions(-)
 create mode 100644 include/linux/intel-ish-client-if.h

-- 
2.17.2
