From: David =?utf-8?b?SMOkcmRlbWFu?= <david@hardeman.nu>
Subject: [PATCH 0/4] ir-core: one-line bugfix, add RC5x, NECx, RC6
Date: Fri, 09 Apr 2010 01:04:20 +0200
Message-ID: <20100408230246.14453.97377.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@redhat.com
Cc: linux-input@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The following series implements support for a couple of new protocols
now that we finally reached an agreement on how durations should be
handled in ir-raw-event.

Also included is a one-line fix that got missed in my previous conversi=
on
of drivers/media/dvb/ttpci/budget-ci.c.

(not to mention that this is my first test run with stgit)

---

David H=C3=A4rdeman (4):
      Fix the drivers/media/dvb/ttpci/budget-ci.c conversion to ir-core
      Add RC5x support to ir-core
      Add NECx support to ir-core
      Add RC6 support to ir-core


 drivers/media/IR/Kconfig            |    9 +
 drivers/media/IR/Makefile           |    1=20
 drivers/media/IR/ir-core-priv.h     |    7 +
 drivers/media/IR/ir-nec-decoder.c   |    3=20
 drivers/media/IR/ir-raw-event.c     |    1=20
 drivers/media/IR/ir-rc5-decoder.c   |   78 +++++--
 drivers/media/IR/ir-rc6-decoder.c   |  412 +++++++++++++++++++++++++++=
++++++++
 drivers/media/IR/ir-sysfs.c         |    2=20
 drivers/media/dvb/ttpci/budget-ci.c |    2=20
 include/media/rc-map.h              |    1=20
 10 files changed, 494 insertions(+), 22 deletions(-)
 create mode 100644 drivers/media/IR/ir-rc6-decoder.c
