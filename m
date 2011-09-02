From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] MFD/Input: twl6040 (vibra): cleanups
Date: Fri,  2 Sep 2011 18:03:01 +0300
Message-ID: <1314975785-25081-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello,

Small cleanups for the twl6040 MFD driver:
removing the global pointer for the platform_device,
adding accessor to fetch the revision ID of the IC,
Fixing the audpwron GPIO handling.

Changes since v1:
- Accessor for revision is used in the core driver
- audpwron GPIO handling fix

Peter
---
Peter Ujfalusi (4):
  MFD: twl6040: Remove global pointer for platform_device
  MFD: twl6040: Add accessor for revision ID
  Input: twl6040-vibra: Use accessor to get revision information
  MFD: twl6040: Fix power on GPIO handling

 drivers/input/misc/twl6040-vibra.c |    2 +-
 drivers/mfd/twl6040-core.c         |   38 ++++++++++++++++-------------------
 include/linux/mfd/twl6040.h        |    5 ++++
 3 files changed, 23 insertions(+), 22 deletions(-)

-- 
1.7.6.1
