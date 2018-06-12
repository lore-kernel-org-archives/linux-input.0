From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH v5 0/3] Input: xen-kbdfront - allow better run-time configuration
Date: Tue, 12 Jun 2018 10:48:53 +0300
Message-ID: <20180612074856.28451-1-andr2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andr2000@gmail.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hi, all!

This patch series synchronizes Xen canonical protocol definitions
which allow the last two patches in the series to update Xen
kbdfront driver with a fix and v5 of the patch to allow better
run-time configuration for xen-kbdfront.

As xen-kbdfront patches rely on protocol changes from patch 1 I am
sending these all together: Boris, Juergen, if you and Dmitry do not
mind, can we have patch 1 applied through Dmitry's tree?

Thank you,
Oleksandr

Changes since v4:
- Added required changes to Xen protocols
- Added a fix for multi-touch XenStore node's locations
- No changes to "Input: xen-kbdfront - allow better run-time
  configuration"

Changes since v3:
- do not connect backend if all virtual devices are disabled (Dmitry)

Changes since v2:
- based on XenStore kbdif features to control which devices are
  exposed instead of module parameters.

Oleksandr Andrushchenko (3):
  xen: Sync up with the canonical protocol definitions in Xen
  Input: xen-kbdfront - fix multi-touch XenStore node's locations
  Input: xen-kbdfront - allow better run-time configuration

 drivers/input/misc/xen-kbdfront.c  | 183 +++++++++++++++++------------
 include/xen/interface/io/displif.h |   8 ++
 include/xen/interface/io/kbdif.h   |  78 +++++++++---
 include/xen/interface/io/sndif.h   |  10 +-
 4 files changed, 180 insertions(+), 99 deletions(-)

-- 
2.17.1
