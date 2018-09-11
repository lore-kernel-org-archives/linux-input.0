From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/9] HID: intel ISH: Cleanup patches
Date: Tue, 11 Sep 2018 16:44:12 -0700
Message-ID: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-input@vger.kernel.org

This series is a cleanup series only and help to abstract client API.

There are no functional changes.

Even Xu (6):
  hid: intel-ish-hid: ishtp: add helper function for driver data get/set
  hid: intel-ish-hid: use helper function for private driver data
    set/get
  hid: intel-ish-hid: ishtp: add helper functions for client buffer
    operation
  hid: intel-ish-hid: use helper function to access client buffer
  hid: intel-ish-hid: ishtp: add helper function for client search
  hid: intel-ish-hid: use helper function to search client id

Hong Liu (2):
  HID: intel-ish-hid: use resource-managed api
  HID: intel-ish-hid: using list_head for ipc write queue

Srinivas Pandruvada (1):
  HID: intel_ish-hid: Enhance API to get ring buffer sizes

 drivers/hid/intel-ish-hid/ipc/ipc.c           | 32 ++++----
 drivers/hid/intel-ish-hid/ipc/pci-ish.c       | 75 ++++++-------------
 drivers/hid/intel-ish-hid/ishtp-hid-client.c  | 41 ++++------
 drivers/hid/intel-ish-hid/ishtp/bus.c         | 52 +++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h         |  5 ++
 .../hid/intel-ish-hid/ishtp/client-buffers.c  | 49 ++++++++++++
 drivers/hid/intel-ish-hid/ishtp/client.c      | 24 ++++++
 drivers/hid/intel-ish-hid/ishtp/client.h      |  5 ++
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h   |  2 +-
 9 files changed, 188 insertions(+), 97 deletions(-)

-- 
2.17.1
