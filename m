From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH v3 0/4] zForce upstreaming
Date: Wed, 4 May 2016 12:24:37 +0200
Message-ID: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:42112 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbcEDKYq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 06:24:46 -0400
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id 8CC3FD80212
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:44 +0200 (CEST)
Received: from SI-HUB1001.de.bosch.com (vsgw22.fe.internet.bosch.com [10.4.98.11])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 49E401B80325
	for <linux-input@vger.kernel.org>; Wed,  4 May 2016 12:24:44 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>

From: Oleksij Rempel <linux@rempel-privat.de>

Changelog:
v2
 - rename scan-freq-idle and scan-freq-finger
   to scan-idle-hz and scan-active-hz.
 - rebase with already acked "Input: zforce_ts: Fix dual touch recognition"
   from previous patchset.

v3
 - rename touch-size-min to touch-size-min-mm
 - fix typo
 - replace "zforce_ts: Reject open if initialization not finished" patch.
   Instead of reject open event, we will call zforce_start() from zforce_boot().

Knut Wohlrab (2):
  Input: zforce_ts: Add device tree support for scanning frequency
  Input: zforce_ts: Add support for minimum touch size limit

Marcel Grosshans (1):
  Input: zforce_ts: Reinitialize touch controller when  BOOT_COMPLETE
    received

Oleksij Rempel (1):
  Input: zforce_ts: allow open even if initialisation is not completed

 .../bindings/input/touchscreen/zforce_ts.txt       |   6 +
 drivers/input/touchscreen/zforce_ts.c              | 174 ++++++++++++++++++---
 include/linux/platform_data/zforce_ts.h            |   3 +
 3 files changed, 157 insertions(+), 26 deletions(-)

-- 
1.9.1

