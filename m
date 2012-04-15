From: chris@cnpbagwell.com
Subject: [PATCH 0/2] Add E5 support
Date: Sun, 15 Apr 2012 17:50:22 -0500
Message-ID: <1334530224-8395-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45293 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab2DOWua (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Apr 2012 18:50:30 -0400
Received: by obbta14 with SMTP id ta14so2854963obb.19
        for <linux-input@vger.kernel.org>; Sun, 15 Apr 2012 15:50:29 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

These are resends of patches to add support for E5 devices.

They are originally from Ping Cheng.  I have made following changes:

 * Rebased patches to current next branch.
 * Made use of features table to initialize touch_max instead of during
   init code; based on review comment.
 * Removed code that created contact ID and added find_slot_from_contactid()
   so that input-mt can handle ID creation; based on review comment.

Jason was nice enough to test on a E5 device as well as with his Intuos5
(since I slightly modified Intuos5 code).

Ping Cheng (2):
  input : wacom - retrieve maximum number of touch points
  input: wacom - add 0xE5 (MT device) support

 drivers/input/tablet/wacom.h     |    4 +-
 drivers/input/tablet/wacom_sys.c |  108 +++++++++++++++++----------
 drivers/input/tablet/wacom_wac.c |  155 +++++++++++++++++++++++++++++++-------
 drivers/input/tablet/wacom_wac.h |    9 ++
 4 files changed, 207 insertions(+), 69 deletions(-)

-- 
1.7.7.6

