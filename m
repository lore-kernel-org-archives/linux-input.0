From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4 v4] input - wacom : USB Tablet PC support
Date: Mon,  7 Mar 2011 13:13:23 -0800
Message-ID: <1299532403-2861-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54615 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1CGVPT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 16:15:19 -0500
Received: by pvg12 with SMTP id 12so782603pvg.19
        for <linux-input@vger.kernel.org>; Mon, 07 Mar 2011 13:15:19 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>

Mainly to change the 1FGT devices to the existing touchscreen format and
the 2FGT devices to MT format.

This is the final version with Henrik's "Reviewed-by" added in the patches.

Ping Cheng (4):
  input : wacom - Remove 2FGT Tablet PC events in TAP format
  input - wacom : process pen data in its own routine
  input - wacom : support one finger touch the touchscreen way
  input - wacom: Support 2FGT in MT format

 drivers/input/tablet/wacom_sys.c |   12 +-
 drivers/input/tablet/wacom_wac.c |  247 ++++++++++++++------------------------
 drivers/input/tablet/wacom_wac.h |    6 +-
 3 files changed, 99 insertions(+), 166 deletions(-)

-- 
1.7.4

