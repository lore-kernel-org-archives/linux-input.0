From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4 v2] input - wacom : USB Tablet PC support
Date: Wed, 16 Feb 2011 14:50:07 -0800
Message-ID: <1297896607-2445-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57102 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab1BPWvD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 17:51:03 -0500
Received: by qwa26 with SMTP id 26so1803677qwa.19
        for <linux-input@vger.kernel.org>; Wed, 16 Feb 2011 14:51:02 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>

Mainly to change the 1FGT devices to the existing touchscreen format and
the 2FGT devices to MT format.

Patch 4/4 is at v2. It is updated with Henrik's review comments. The 
first three patches stay the same. To make it easy to review the whole
set, all four are resent together.

Ping Cheng (4):
  input : wacom - Remove 2FGT Tablet PC events in TAP format
  input - wacom : process pen data in its own routine
  input - wacom : support one finger touch the touchscreen way
  input - wacom: Support 2FGT in MT format

 drivers/input/tablet/wacom_sys.c |   12 +-
 drivers/input/tablet/wacom_wac.c |  244 ++++++++++++++------------------------
 drivers/input/tablet/wacom_wac.h |    6 +-
 3 files changed, 100 insertions(+), 162 deletions(-)

-- 
1.7.4

