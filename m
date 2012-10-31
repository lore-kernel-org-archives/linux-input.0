From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/2] input - wacom: Add support to two new multi-touch tablets
Date: Wed, 31 Oct 2012 10:37:50 -0700
Message-ID: <1351705070-14323-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53752 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335Ab2JaRir (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Oct 2012 13:38:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1137302pbb.19
        for <linux-input@vger.kernel.org>; Wed, 31 Oct 2012 10:38:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

This patchset is based on the latest WACOM_24HDT check fix.

Ping Cheng (2):
  input - wacom: Clean up device type code
  input - wacom: Add support to 0x100 and 0x100

 drivers/input/tablet/wacom_sys.c |   58 ++++++++++++++++++++++++++++----------
 drivers/input/tablet/wacom_wac.c |   22 +++++++++++++--
 drivers/input/tablet/wacom_wac.h |    2 ++
 3 files changed, 64 insertions(+), 18 deletions(-)

-- 
1.7.9.5

