From: Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH 0/3] HID: debug: fix the ring buffer implementation
Date: Wed,  3 Oct 2018 19:19:33 +0200
Message-ID: <20181003171936.11271-1-vdronov@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patchset is fixing some aspects of the ring buffer implementation in
drivers/hid/hid-debug.c. This implementation has certain problem points:

- it may stuck in an infinite loop
- it may return corrupted data
- a reader and a writer are not protected by spinlocks, which can lead to
  the corrupted data

The suggested patchset is a new ring buffer implementation which overwrites
the oldest data in case of an overflow. One can verify the suggested ring
buffer implementation by fuzzing it with modified kernel and fuzzer-reader
at: https://gist.github.com/nefigtut/33d56e3870b67493cc867344aed2a062

Vladis Dronov (3):
  HID: debug: avoid infinite loop and corrupting data
  HID: debug: provide reader-writer locking for the ring buffer
  HID: debug: fix ring buffer implementation

 drivers/hid/hid-debug.c   | 201 ++++++++++++++++++++++++++------------
 include/linux/hid-debug.h |   1 +
 2 files changed, 142 insertions(+), 60 deletions(-)

-- 
2.19.0
