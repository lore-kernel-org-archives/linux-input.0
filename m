From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/2] Cleanup and fix touch_down implementation
Date: Fri, 20 Feb 2015 14:25:19 -0800
Message-ID: <1424471119-4628-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33748 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754555AbbBTWZ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 17:25:28 -0500
Received: by pdjz10 with SMTP id z10so10671652pdj.0
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2015 14:25:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Hi Jiri,

This set is based on your for-3.20/upstream-fixes branch.

If pen comes in proximity while touch is down, we force touch up
before sending pen events. This idea has been implemented for
Tablet PCs. But other tablets that support both pen and touch are
not fully considered.

Ping Cheng (2):
  HID: wacom: do not send pen events before touch is up/forced out
  HID: wacom: rely on actual touch down count to decide touch_down

 drivers/hid/wacom_wac.c | 81 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 32 deletions(-)

-- 
1.9.1

