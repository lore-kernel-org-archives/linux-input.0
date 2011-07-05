From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/3 v2] input : wacom - Split the 4/4 of a previous set
Date: Tue,  5 Jul 2011 16:24:28 -0700
Message-ID: <1309908268-18755-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33104 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab1GEXW6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:22:58 -0400
Received: by iyb12 with SMTP id 12so5628705iyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:22:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>

Split the "Update Graphire and old Bamboo tablet buttons" into a set of
3 patches as suggested by Henrik.

Dmitry, please apply the 3/4, "Remove BTN_TOOL_FINGER for pad", patch
before this set since they depend on that patch.

Ping Cheng (3):
  input : wacom - Add serial number for Graphire4 and old Bamboo
  input : wacom - Update Graphire4 and old Bamboo tablet buttons
  input : wacom - Cleanup a return value for the old Bamboo

 drivers/input/tablet/wacom_wac.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

-- 
1.7.5.4

