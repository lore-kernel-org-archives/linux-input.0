From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/3] MFD/Input: twl6040 (vibra): cleanups
Date: Fri,  2 Sep 2011 17:32:38 +0300
Message-ID: <1314973961-21187-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:40585 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752391Ab1IBOla (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Sep 2011 10:41:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Misael Lopez Cruz <misael.lopez@ti.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

Small cleanups for the twl6040 MFD driver:
removing the global pointer for the platform_device, and adding accessor
to fetch the revision ID of the IC.

Peter
---
Peter Ujfalusi (3):
  MFD: twl6040: Remove global pointer for platform_device
  MFD: twl6040: Add accessor for revision ID
  Input: twl6040-vibra: Use accessor to get revision information

 drivers/input/misc/twl6040-vibra.c |    2 +-
 drivers/mfd/twl6040-core.c         |   27 +++++++++++----------------
 include/linux/mfd/twl6040.h        |    5 +++++
 3 files changed, 17 insertions(+), 17 deletions(-)

-- 
1.7.6.1

