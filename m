From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v2 0/2] some updates for newer elantech touchpads
Date: Mon, 21 Nov 2011 13:53:04 +0800
Message-ID: <1321854786-6666-1-git-send-email-jj_ding@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:39099 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab1KUFzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Nov 2011 00:55:23 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, JJ Ding <jj_ding@emc.com.tw>

Hi,

These two are my last pending patches for newer elantech touchpads.
The first patch adds support for a shorter and faster send_cmd, available
since v3 hardware. The other one teaches the driver to query resolution
data from v4 hardware.

Patches are against Dmitry's current -next tree.

Any comment is welcome, thank you very much.

Change in v2:
 - allow resolution query to fail, print a warning if so. (Daniel)

JJ Ding (2):
  Input: elantech - add support for elantech fast command
  Input: elantech - add resolution query support for v4 hardware

 drivers/input/mouse/elantech.c |   75 +++++++++++++++++++++++++++++++++++----
 drivers/input/mouse/elantech.h |    2 +
 2 files changed, 69 insertions(+), 8 deletions(-)

-- 
1.7.8-rc2

