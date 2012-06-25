From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4] E6 bug fix and code cleanup
Date: Mon, 25 Jun 2012 14:35:24 -0700
Message-ID: <1340660124-27323-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42203 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756242Ab2FYVbV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 17:31:21 -0400
Received: by pbbrp8 with SMTP id rp8so7101299pbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 14:31:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>

The first two patches fix 0xE6 bug. The other two are just cleanup.

Ping Cheng (4):
  input - wacom: fix retrieving touch_max bug
  input - wacom: don't retrieve touch_max when it is predefined
  input - wacom: BTN_TOOL_DOUBLETAP is not a valid device_type
  input - wacom: TPC2FG doesn't store touch id for slots

 drivers/input/tablet/wacom_sys.c |    8 +++++---
 drivers/input/tablet/wacom_wac.c |    6 ++++--
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
1.7.7.6

