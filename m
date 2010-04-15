From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 0/8] Series short description
Date: Thu, 15 Apr 2010 23:45:55 +0200
Message-ID: <20100415214520.14142.56114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@redhat.com
Cc: linux-media@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The following series implements the suggested change to ir-core
to use a 1:31 struct for pulse/space durations, adds two new
raw decoders, converts two users of ir-functions to plain ir-core
and fixes a few small bugs in ir-core.

---

David H=C3=A4rdeman (8):
      ir-core: change duration to be coded as a u32 integer
      ir-core: Add JVC support to ir-core
      ir-core: Add Sony support to ir-core
      ir-core: remove ir-functions usage from dm1105
      ir-core: convert mantis from ir-functions.c
      ir-core: fix double spinlock init in drivers/media/IR/rc-map.c
      ir-core: fix table resize during keymap init
      ir-core: fix some confusing comments


 drivers/media/IR/Kconfig           |   18 ++
 drivers/media/IR/Makefile          |    2=20
 drivers/media/IR/ir-core-priv.h    |   63 ++++---
 drivers/media/IR/ir-jvc-decoder.c  |  320 ++++++++++++++++++++++++++++=
++++++++
 drivers/media/IR/ir-keytable.c     |   12 +
 drivers/media/IR/ir-nec-decoder.c  |  120 ++++++++------
 drivers/media/IR/ir-raw-event.c    |   32 ++--
 drivers/media/IR/ir-rc5-decoder.c  |  105 ++++++------
 drivers/media/IR/ir-rc6-decoder.c  |  221 +++++++++++++------------
 drivers/media/IR/ir-sony-decoder.c |  312 ++++++++++++++++++++++++++++=
+++++++
 drivers/media/IR/ir-sysfs.c        |   12 +
 drivers/media/IR/rc-map.c          |    5 -
 12 files changed, 955 insertions(+), 267 deletions(-)
 create mode 100644 drivers/media/IR/ir-jvc-decoder.c
 create mode 100644 drivers/media/IR/ir-sony-decoder.c
