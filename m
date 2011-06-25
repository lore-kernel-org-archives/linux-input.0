From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4] input: wacom - Add 3 new models and remove BTN_TOOL_FINGER
Date: Fri, 24 Jun 2011 17:13:43 -0700
Message-ID: <1308960823-20361-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34147 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab1FYAMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 20:12:33 -0400
Received: by pwj7 with SMTP id 7so2074267pwj.19
        for <linux-input@vger.kernel.org>; Fri, 24 Jun 2011 17:12:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>

Ping Cheng (4):
  input : wacom - Wacom Bamboo Pen D4 has 1024 pressure level
  input : wacom - Add 3 new models: 6A, 6B, and 97
  input : wacom - Remove BTN_TOOL_FINGER for pad
  input : wacom - Update Graphire and old Bamboo tablet buttons

 drivers/input/tablet/wacom_wac.c |   47 ++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 24 deletions(-)

-- 
1.7.5.4

