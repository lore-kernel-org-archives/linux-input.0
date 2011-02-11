From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/4] input - wacom : USB Tablet PC support
Date: Thu, 10 Feb 2011 17:31:35 -0800
Message-ID: <1297387895-13609-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57848 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab1BKBcW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Feb 2011 20:32:22 -0500
Received: by iyj8 with SMTP id 8so1940511iyj.19
        for <linux-input@vger.kernel.org>; Thu, 10 Feb 2011 17:32:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pingc@wacom.com>

From: Ping Cheng <pingc@wacom.com>

Mainly to change the 1FGT devices to the existing touchscreen format and
the 2FGT devices to MT format.

Ping Cheng (4):
  input : wacom - Remove 2FGT Tablet PC events in TAP format
  input - wacom : process pen data in its own routine
  input - wacom : support one finger touch the touchscreen way
  input - wacom: Support 2FGT in MT format

 drivers/input/tablet/wacom_sys.c |   12 +-
 drivers/input/tablet/wacom_wac.c |  245 ++++++++++++++------------------------
 drivers/input/tablet/wacom_wac.h |    6 +-
 3 files changed, 101 insertions(+), 162 deletions(-)

-- 
1.7.4

