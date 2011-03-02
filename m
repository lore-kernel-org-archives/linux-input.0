From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4 v3] input - wacom : USB Tablet PC support
Date: Tue,  1 Mar 2011 16:16:01 -0800
Message-ID: <1299024961-8465-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:39335 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485Ab1CBARQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2011 19:17:16 -0500
Received: by pwi15 with SMTP id 15so996834pwi.19
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2011 16:17:16 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>

Mainly to change the 1FGT devices to the existing touchscreen format and
the 2FGT devices to MT format.

Patches 3 and 4 are at v3. They are updated with Henrik's review comments.
Patches 1 and 2 are the original ones. To make it easy to review the whole
set, all four are resent together.

Ping Cheng (4):
  input : wacom - Remove 2FGT Tablet PC events in TAP format
  input - wacom : process pen data in its own routine
  input - wacom : support one finger touch the touchscreen way
  input - wacom: Support 2FGT in MT format

 drivers/input/tablet/wacom_sys.c |   12 +-
 drivers/input/tablet/wacom_wac.c |  246 +++++++++++++++-----------------------
 drivers/input/tablet/wacom_wac.h |    6 +-
 3 files changed, 103 insertions(+), 161 deletions(-)

-- 
1.7.4

