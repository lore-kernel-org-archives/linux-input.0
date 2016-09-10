From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v12 0/5] Goodix touchscreen enhancements
Date: Sat, 10 Sep 2016 20:57:32 +0300
Message-ID: <1473530257-7495-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26075 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754939AbcIJR6o (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 10 Sep 2016 13:58:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, Karsten Merker <merker@debian.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

This is an update for a previous set of patches [1] with enhancements
for the Goodix touchscreens. The first 3 patches are leftovers from
the previous patchset (with minor changes due to rebase), while the
last 2 patches are new.

Thanks,
Irina

[1] https://lkml.org/lkml/2015/11/19/241

Changes in v12:
 - add documentation for configuration firmware update
 - minor changes due to rebase
 - add 2 new patches to fix reset sequence and add support for gt9157

Previous changes:
  https://lkml.org/lkml/2015/11/19/241

Irina Tirdea (5):
  Input: goodix - add sysfs interface to dump config
  Input: goodix - add support for ESD
  Input: goodix - add runtime power management support
  Input: goodix - fix reset sequence
  Input: goodix - add support for gt9157

 .../bindings/input/touchscreen/goodix.txt          |   5 +
 Documentation/input/goodix.txt                     |  84 +++++
 drivers/input/touchscreen/goodix.c                 | 346 +++++++++++++++++++--
 3 files changed, 415 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/input/goodix.txt

-- 
1.9.1

